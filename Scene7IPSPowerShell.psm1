# $GetUserParam = New-Object -TypeName Scene7.getUsersParam
# $getAllCompaniesParam = New-Object -TypeName Scene7.getAllCompaniesParam
# $getCompanyInfoParam = New-Object -TypeName Scene7.getCompanyInfoParam
# $getCompanyInfoParam.companyName = "tervisRender"
# $Result = $Proxy.getCompanyInfo($getCompanyInfoParam)
# $Result.companyInfo

function Get-Scene7IPSCompanyInfo {
    param (
        $companyName
    )
    Invoke-Scene7IPSAPI -MethodName getCompanyInfo -Property $PSBoundParameters
}

function Get-Scene7IPSWebServiceProxy {
    if (-not $Script:Proxy) {
        $Credential = Get-TervisPasswordstatePassword -Guid 9cc7f5a1-5eb1-41fe-8d6d-1619d201dd00
        $Proxy = New-WebServiceProxy -Uri https://s7sps1apissl.scene7.com/scene7/IpsApi-2014-04-03.wsdl -Namespace Scene7

        $AuthHeader = New-Object -TypeName Scene7.authHeader
        $AuthHeader.user = $Credential.UserName
        $AuthHeader.password = $Credential.Password
        $AuthHeader.appName = "tervis"
        $AuthHeader.appVersion = "1.0"
        
        $Proxy.authHeaderValue = $AuthHeader
        $Script:Proxy = $Proxy
    }
    $Script:Proxy
}

function Invoke-Scene7IPSAPI {
    param (
        $MethodName,
        $Parameter,
        $Property
    )
    $Proxy = Get-Scene7IPSWebServiceProxy
    if (-not $Parameter) {
        if ($Property) {
            $Parameter = New-Object -TypeName Scene7."$($MethodName)Param" -Property $Property
        } else {
            $Parameter = New-Object -TypeName Scene7."$($MethodName)Param"
        }
    }
    $Response = $Proxy.$MethodName($Parameter)
    $Response.result
}