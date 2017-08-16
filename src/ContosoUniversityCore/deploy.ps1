function exec($cmd) {
    $global:lastexitcode = 0
    & $cmd
    if ($lastexitcode -ne 0) {
        throw "Error executing command:$cmd"
    }
}

$deployment_environment = $OctopusParameters["DeploymentEnvironment"]
$connection_string = $OctopusParameters["ConnectionString"]

Write-Host "Executing Roundhouse"
Write-Host "    Environment: $deployment_environment"
Write-Host "    Connection String: $connection_string"

exec { & .\App_Data\rh.exe --connectionstring $connection_string `
                  --commandtimeout 300 `
                  --env $deployment_environment `
                  --output .\App_Data\output `
                  --sqlfilesdirectory .\App_Data `
                  --versionfile .\bin\ContosoUniversityCore.dll `
                  --transaction `
                  --silent }