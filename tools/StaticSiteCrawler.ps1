Push-Location $PSScriptRoot;

.\StaticSiteCrawler\StaticSiteCrawler.exe http://localhost:15658 ..\artifacts\StaticSite /

Pop-Location;