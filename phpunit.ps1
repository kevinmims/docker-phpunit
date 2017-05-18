if (Get-Command "docker" -errorAction SilentlyContinue)
{
    docker run --rm -v $PWD/:/opt/project -w /opt/project phpunit phpunit $args
}
else
{
    echo "Docker not installed, the 'docker' command is required to run this script."
}