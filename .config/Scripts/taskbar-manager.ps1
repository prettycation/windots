# ==================================================================================
# 任务栏守护脚本 (taskbar-manager.ps1)
# ==================================================================================
# 这个脚本会无限循环，持续隐藏 Windows 任务栏，以防止 explorer.exe 重启后它再次出现。

Write-Host "Taskbar Manager started. Press Ctrl+C to stop."

while ($true) {
    # 执行 nircmd 命令来隐藏任务栏。
    # 我们在这里重复执行，确保任何新出现的任务栏都会被隐藏。
    nircmd.exe win hide class "Shell_TrayWnd"

    # 暂停 5 秒。这个间隔可以在不占用 CPU 的情况下，足够快地响应任务栏的重生。
    Start-Sleep -Seconds 5
}