# Runs the SQL Server setup scripts after the container is accepting connections.
# SQL Server containers start the engine first; init scripts are applied explicitly.

$ErrorActionPreference = "Stop"

$envFile = Join-Path $PSScriptRoot "..\.env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]+)=(.*)$") {
            [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
        }
    }
}

$password = if ($env:MSSQL_SA_PASSWORD) { $env:MSSQL_SA_PASSWORD } else { "Uni_Strong_Password_123" }
$sqlcmd = "/opt/mssql-tools18/bin/sqlcmd"

Write-Host "Waiting for SQL Server..."
for ($i = 0; $i -lt 30; $i++) {
    docker exec uni-sqlserver $sqlcmd -S localhost -U sa -P $password -C -Q "SELECT 1" *> $null
    if ($LASTEXITCODE -eq 0) { break }
    Start-Sleep -Seconds 2
}

docker cp ./init/01_schema.sql uni-sqlserver:/tmp/01_schema.sql
docker cp ./init/02_seed.sql uni-sqlserver:/tmp/02_seed.sql
docker cp ./init/03_routines.sql uni-sqlserver:/tmp/03_routines.sql

docker exec uni-sqlserver $sqlcmd -S localhost -U sa -P $password -C -i /tmp/01_schema.sql
docker exec uni-sqlserver $sqlcmd -S localhost -U sa -P $password -C -i /tmp/02_seed.sql
docker exec uni-sqlserver $sqlcmd -S localhost -U sa -P $password -C -i /tmp/03_routines.sql

Write-Host "BirdCourse database is ready."
