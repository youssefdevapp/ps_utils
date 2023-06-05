[array]$SiteLinks = "https://www.google.com/",
                    "https://www.mozilla.org/",
                    "https://www.microsoft.com/",
                    "https://www.bing.com/"

foreach($url in $SiteLinks) {

   try {
      Write-host "Verifying $url" -ForegroundColor Yellow
      $checkConnection = Invoke-WebRequest -Uri $url
      if ($checkConnection.StatusCode -eq 200) {
         Write-Host "Connection Verified!" -ForegroundColor Green
      }
   } 
   catch [System.Net.WebException] {
      $exceptionMessage = $Error[0].Exception
      if ($exceptionMessage -match "503") {
         Write-Host "Server Unavaiable" -ForegroundColor Red
      }
      elseif ($exceptionMessage -match "404") {
         Write-Host "Page Not found" -ForegroundColor Red
      }
      elseif ($exceptionMessage -match "400") {
         Write-Host "Bad request" -ForegroundColor Red
      }
      else {
         Write-Host $exceptionMessage -ForegroundColor Red
      }
   }
}
