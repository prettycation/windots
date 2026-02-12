
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "E:\anaconda\Scripts\conda.exe") {
    (& "E:\anaconda\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}
#endregion

