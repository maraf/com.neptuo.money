param([string]$buildFolder)

Push-Location $PSScriptRoot;

$outputPath = "..\output";
$delay = 3000;

# Start IIS.
Write-Host "Execute dotnet run."
$server = Start-Process "dotnet" -NoNewWindow -PassThru -ArgumentList "run --project ..\src\com.neptuo.money\com.neptuo.money.csproj"

Write-Host "Waiting $($delay)."
Start-Sleep -Milliseconds $delay

# Crawl site.
Write-Host "Running StaticSiteCrawler."
.\StaticSiteCrawler\StaticSiteCrawler.exe http://localhost:5000/ $outputPath /

# Fail build when any URL download failed.
if (!($LastExitCode -eq 0))
{
    Write-Error -Message "Crawler result: $LastExitCode" -ErrorAction Stop
    # throw "Crawler result: $LastExitCode";
}

# Debug print output.
Write-Host "Content of output:"
$items = Get-ChildItem -Path $outputPath
ForEach ($item in $items) 
{ 
    $size = (Get-Item "$($outputPath)\$($item)").Length
    Write-Host "'$($item)' - $($size)B"
}

# Stop IIS.
Write-Host "Stopping dotnet process."
Stop-Process $server

Pop-Location;