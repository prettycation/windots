# ==================================================================================
# Windows 桌面环境启动脚本
# ==================================================================================

# --- 步骤 1: 在后台启动所有“守护”脚本 ---

# --- 启动Windhawk ---

Write-Host "Starting Windhawk..."
Start-Process -FilePath (scoop which Windhawk) -ArgumentList "-tray-only"
Start-Sleep -Seconds 1


# 在后台以“无窗口”模式启动“任务栏守护”脚本 ---
# Write-Host "Starting Taskbar Manager in a truly hidden window..."
# $TaskbarScript = "$env:USERPROFILE\Documents\Scripts\taskbar-manager.ps1"
# nircmd.exe exec hide powershell.exe -ExecutionPolicy Bypass -File `"$TaskbarScript`"

# 启动“Nuisance Window Manager”脚本
Write-Host "Starting Nuisance Window Manager..."
$NuisanceWindowScript = "$env:USERPROFILE\Documents\Scripts\NuisanceWindow-manager.ps1"
# 提权
gsudo powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$NuisanceWindowScript`"


# --- 步骤 2: 启动窗口管理器 ---

Write-Host "Starting GlazeWM..."
Start-Process -FilePath (scoop which glazewm)
Start-Sleep -Seconds 1


# --- 步骤 3: 启动状态栏 ---

Write-Host "Starting YASB..."
Start-Process -FilePath (scoop which yasb)
Start-Sleep -Seconds 1

