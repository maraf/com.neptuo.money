Push-Location $PSScriptRoot;

.\StaticSiteCrawler\StaticSiteCrawler.exe http://localhost:15658 ..\output /

Pop-Location;