# Runs the SQL Server setup scripts after the container is accepting connections.
# SQL Server containers start the engine first; init scripts are applied explicitly.

$ErrorActionPreference = "Stop"

$password = "Uni_Strong_Password_123"
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
