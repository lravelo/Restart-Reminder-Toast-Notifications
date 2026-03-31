$ImageDir = "C:\Program Files\RestartReminder"
$ImageUrl = "https://raw.githubusercontent.com/lravelo/Restart-Reminder-Toast-Notifications/refs/heads/main/images"
$Images = @{
    "notification_icon.ico" = "$ImageUrl/notification_icon.ico"
    "startrestart.gif"     = "$ImageUrl/startrestart.gif"
    "pleasereboot.gif"     = "$ImageUrl/pleasereboot.gif"
    "shuttingdown.gif"     = "$ImageUrl/shuttingdown.gif"
}

# Ensure directory exists
if (-not (Test-Path -Path $ImageDir)) {
    New-Item -Path $ImageDir -ItemType Directory -Force | Out-Null
}

# Download missing files
foreach ($file in $Images.Keys) {
    $localPath = Join-Path $ImageDir $file
    $url = $Images[$file]

    if (-not (Test-Path -Path $localPath)) {
        try {
            Invoke-WebRequest -Uri $url -OutFile $localPath -UseBasicParsing
        } catch {
            Write-Warning "Failed to download $file from $url. Error: $_"
        }
    }
}
