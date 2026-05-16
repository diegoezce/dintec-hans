# Deploy control.html to RobotOS server
$SERVER = "192.168.232.129"
$USER = "root"
$PASSWORD = "hans"
$REMOTE_PATH = "/usr/local/RobotOS/home/RobotOS/dist/"
$LOCAL_FILE = "$PSScriptRoot\dist\control.html"

# Install Posh-SSH if not already installed
if (-not (Get-Module -ListAvailable -Name Posh-SSH)) {
    Write-Host "Installing Posh-SSH module..."
    Install-Module -Name Posh-SSH -Force -Scope CurrentUser
}

Import-Module Posh-SSH

$credential = New-Object System.Management.Automation.PSCredential($USER, (ConvertTo-SecureString $PASSWORD -AsPlainText -Force))

Write-Host "Uploading $LOCAL_FILE to ${USER}@${SERVER}:${REMOTE_PATH}"
Set-SCPItem -ComputerName $SERVER -Credential $credential -Path $LOCAL_FILE -Destination $REMOTE_PATH -AcceptKey

if ($?) {
    Write-Host "Upload successful."
} else {
    Write-Host "Upload failed."
}
