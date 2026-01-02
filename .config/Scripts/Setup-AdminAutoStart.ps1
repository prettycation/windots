# Setup-AdminAutoStart.ps1
# 功能: 使用 schtasks.exe 为主启动脚本创建免UAC、以管理员权限自启的任务计划。
# 适用环境: Windows PowerShell 5.1 及 PowerShell 7+ (Core)。

# --- 配置区域 ---

# 主启动脚本的完整路径。
$TargetScriptPath = "C:\Users\prettycation\Documents\Scripts\startup.ps1"

# [可选] 任务计划的名称和描述。
$TaskName = "User Startup Script - Admin AutoStart"

# --- 核心逻辑 ---

# 1. 权限检查
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "此脚本需要管理员权限。请以管理员身份运行。"
    Read-Host "按 Enter 键退出。"
    exit
}

# 2. 目标脚本存在性检查
if (-not (Test-Path $TargetScriptPath -PathType Leaf)) {
    Write-Error "错误：目标脚本 '$TargetScriptPath' 未找到！请检查路径是否正确。"
    Read-Host "按 Enter 键退出。"
    exit
}

# 3. 检测旧的自启方式
Write-Host "正在检测旧的自启方式（启动文件夹中的快捷方式）..."
$startupFolderPath = [Environment]::GetFolderPath('Startup')
$conflictingFiles = Get-ChildItem -Path $startupFolderPath -Recurse | Where-Object {
    $isMatch = $false
    if ($_.Extension -eq ".lnk") {
        try {
            $shell = New-Object -ComObject WScript.Shell
            $shortcut = $shell.CreateShortcut($_.FullName)
            if ($shortcut.TargetPath -eq $TargetScriptPath) { $isMatch = $true }
        } catch {}
    }
    $isMatch
}

if ($conflictingFiles) {
    Write-Warning "检测到冲突！为避免重复执行，请手动删除启动文件夹中的旧快捷方式。"
    Read-Host "按 Enter 键以忽略并继续，或按 Ctrl+C 退出以手动处理。"
} else {
    Write-Host "未在启动文件夹中发现冲突的快捷方式。" -ForegroundColor Green
}

# 4. 使用 schtasks.exe 创建或更新任务计划
Write-Host "正在使用 schtasks.exe 创建/更新任务计划 '$TaskName'..."

# 构建要执行的命令。注意：schtasks.exe 对引号的处理很严格。
$CommandToRun = "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$TargetScriptPath`""

# 使用 .NET 类，不受 gsudo 环境影响。
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "将为当前用户 '$CurrentUser' 创建任务。"

try {
    # schtasks.exe 参数详解:
    # /Create           : 创建一个新任务
    # /F                : 如果任务已存在，则强制创建并覆盖
    # /TN <TaskName>    : 指定任务的名称
    # /TR <TaskRun>     : 指定要运行的程序或脚本
    # /SC ONLOGON       : 指定触发器为“用户登录时”
    # /RU <CurrentUser> : 以当前登录的用户身份运行。
    # /RL HIGHEST       : 【核心】以最高权限运行，这会隐式地处理UAC，正是我们需要的功能。
    
    schtasks.exe /Create /F /TN "$TaskName" /TR "$CommandToRun" /SC ONLOGON /RU "$CurrentUser" /RL HIGHEST
    
    Write-Host "成功！任务已按您的要求配置。" -ForegroundColor Green
    Write-Host " - 运行用户: $CurrentUser"
    Write-Host " - 触发器:   On Logon"
    Write-Host " - 权限:     Highest Privileges (跳过UAC)"
} catch {
    Write-Error "使用 schtasks.exe 创建任务计划时发生错误: $($_.Exception.Message)"
}

Read-Host "按 Enter 键退出。"