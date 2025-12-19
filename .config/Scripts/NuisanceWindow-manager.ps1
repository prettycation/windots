# ==================================================================================
# Nuisance Window Manager (流氓窗口管理器)
# ==================================================================================

# --- 要关闭的程序列表 ---
# 通过“进程名”识别
$nuisanceProcesses = @(
    @{
        ProcessName = "ControlCenterDaemon"
        Comment = "神舟风扇控制程序"
    }
    # 示例，只需在这里添加：
    # ,@{
    #    ProcessName = "UpdateNotifier"
    #    Comment = "某个软件的更新通知程序"
    # }
)

Write-Host "--- Nuisance Window Manager starting ---" -ForegroundColor Cyan

# 等待，以确保这些程序已经启动。
$initialWaitSeconds = 1
Write-Host "Waiting for $initialWaitSeconds seconds for desktop to settle..."
Start-Sleep -Seconds $initialWaitSeconds

# 遍历不需要的进程列表
foreach ($item in $nuisanceProcesses) {
    $processName = $item.ProcessName
    Write-Host "Searching for process: '$processName'"

    try {
        # 根据进程名查找。
        $processesToStop = Get-Process -Name $processName -ErrorAction Stop
        
        if ($null -ne $processesToStop) {

            Write-Host "Found $($processesToStop.Count) instance(s) of '$processName'. Force stopping..." -ForegroundColor Green
            $processesToStop | Stop-Process -Force
            Write-Host "Process '$processName' stopped successfully."
        }
        # 如果 Get-Process 找不到进程，它会直接抛出一个错误，并被下面的 catch 块捕获。
    } catch {
        # 捕获 Get-Process 找不到进程时抛出的错误
        Write-Host "Process '$processName' not found. (Already closed or not running)" -ForegroundColor Yellow
    }
}

Write-Host "--- Nuisance Window Manager finished ---" -ForegroundColor Cyan
