# Loads the Cypher init script into the running Neo4j container.

$ErrorActionPreference = "Stop"

$envFile = Join-Path $PSScriptRoot "..\.env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]+)=(.*)$") {
            [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
        }
    }
}

$user = if ($env:NEO4J_USER) { $env:NEO4J_USER } else { "neo4j" }
$password = if ($env:NEO4J_PASSWORD) { $env:NEO4J_PASSWORD } else { "uni_password" }

docker cp ./init/01_art_graph.cypher uni-neo4j:/tmp/01_art_graph.cypher
docker exec uni-neo4j cypher-shell -u $user -p $password -f /tmp/01_art_graph.cypher
