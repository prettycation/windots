-- office.yazi plugin with cross-platform fixes for Windows
-- Version 4: Defines success by checking for the output file, not the exit code.

local M = {}

-- Cross-platform function to get a sanitized username.
local function get_safe_username()
	local username = os.getenv("USERNAME") or os.getenv("USER") or os.getenv("LOGNAME")
	if not username then
		return "yazi_fallback_user"
	end
	return username:gsub("[\\/<>:\"|?*%s]", "_"):lower()
end

-- Find the correct command for LibreOffice ('libreoffice' or 'soffice').
local function get_libreoffice_command()
	local names = { "libreoffice", "soffice" }
	local is_windows = ya.target_os() == "windows"
	local CHECK_CMD = is_windows and "where" or "which"
	local REDIRECTION = is_windows and " >nul 2>&1" or " >/dev/null 2>&1"

	for _, name in ipairs(names) do
		if os.execute(CHECK_CMD .. " " .. name .. REDIRECTION) then
			return name
		end
	end

	ya.notify({
		title = "office.yazi",
		content = "Could not find `libreoffice` or `soffice` in your system's PATH.",
		timeout = 5,
		level = "error",
	})
	return nil
end

-- Initialize global constants for the plugin.
local LIBREOFFICE_COMMAND = get_libreoffice_command()

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err = self:preload(job)
	if not ok or err then
		ya.err("office.yazi error: " .. tostring(err))
		return
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))
	ya.image_show(cache, job.area)
	ya.preview_widgets(job, {})
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		local step = ya.clamp(-1, job.units, 1)
		ya.manager_emit("peek", { math.max(0, cx.active.preview.skip + step), only_if = job.file.url })
	end
end

function M:doc2pdf(job)
	local cache_url = ya.file_cache(job)
	if not cache_url then
		return nil, Err("Could not get cache file path from Yazi.")
	end

	local temp_dir_url = cache_url.parent
	if not temp_dir_url then
		return nil, Err("Could not determine parent directory of cache file.")
	end

	local temp_dir_path = tostring(temp_dir_url)
	local source_file_path = tostring(job.file.url)

	-- Run the LibreOffice command and capture its output.
	local libreoffice = Command(LIBREOFFICE_COMMAND)
		:arg("--headless")
		:arg("--convert-to")
		:arg("pdf")
		:arg("--outdir")
		:arg(temp_dir_path)
		:arg(source_file_path)
		:stdin(Command.NULL)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	-- Construct the expected path of the output PDF file.
	local pdf_filename = job.file.url.stem .. ".pdf"
	local tmp_pdf_url = temp_dir_url:join(pdf_filename)
	local tmp_pdf_path = tostring(tmp_pdf_url)

	-- ==================== FIX IS HERE ====================
	-- The true test of success is whether the PDF file was created.
	-- We no longer rely on the command's exit status (`libreoffice.status.success`).
	if not fs.cha(tmp_pdf_url) then
		-- If the file doesn't exist, it's a real failure. Log the command's output for debugging.
		local output = libreoffice.stdout .. libreoffice.stderr
		return nil, Err("LibreOffice ran but the PDF file was not created. Output: %s", output)
	end
	-- ===================================================

	-- If we reach here, the file exists, so the conversion was successful.
	return tmp_pdf_path
end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local tmp_pdf_path, err = self:doc2pdf(job)
	if not tmp_pdf_path then
		return false, err
	end

	local output, err = Command("pdftoppm")
		:arg("-singlefile")
		:arg("-jpeg")
		:arg("-jpegopt")
		:arg("quality=" .. rt.preview.image_quality)
		:arg(tmp_pdf_path)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	fs.remove("file", Url(tmp_pdf_path))

	if not output then
		return false, Err("Failed to start `pdftoppm`: %s", err)
	elseif not output.status.success then
		return false, Err("`pdftoppm` failed: %s", output.stderr)
	end

	local ok, err = fs.write(cache, output.stdout)
	if not ok then
		return false, Err("Failed to write to cache file: %s", err)
	end

	return true
end

return M
