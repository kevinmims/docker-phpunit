$path="file:///$PWD/coverage.html/index.html"
if (Get-Command "docker" -errorAction SilentlyContinue)
{
    docker run --rm -v $PWD/:/opt/project -w /opt/project docker-phpunit phpunit $args
    Start-Process Chrome $path
}
else
{
    Write-Output "Docker not installed, the 'docker' command is required to run this script."
}