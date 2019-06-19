ipmo -force Scene7IPSPowerShell
$CompanyInfo = Get-Scene7IPSCompanyInfo -companyName "tervisRender"
$AssetArray = Get-Scene7IPSAssetsByName -companyHandle $CompanyInfo.companyHandle -nameArray @("16DWT1-HERO2")
$AssetArray[0].vignetteInfo
$AssetArray[0].metadataArray

"https://images.tervis.com/ir/render/tervisRender/12SS1-HERO2?req=contents"