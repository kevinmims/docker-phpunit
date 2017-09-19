# remove duplicate arguments
$args = $args | Select-Object -uniq

# get docker arguments (prefixed by --)
$dockerArgs = $args|Where-Object{$_ -like "--*"}

# get other arguments
$otherArgs = $args|Where-Object{$_ -notlike "--*"}

# define constant
$path="file:///$PWD/coverage.html/index.html"

# test if user is running docker
if (Get-Command "docker" -errorAction SilentlyContinue)
{
    # run the container witht he phpunit command and map the current location
    docker run --rm -v $PWD/:/opt/project -w /opt/project docker-phpunit phpunit $dockerArgs
    
    # handle arguments on the cli
    ForEach($arg in $otherArgs)
    {
        # look for coverage argument to show code coverage in browser
        if($arg -eq 'showCoverage')
        {
            Start-Process Chrome $path
        } 
        else 
        {
            Write-Host
            Write-Host "==> Argument not recognized: " $arg
            Write-Host
        }
    }
}
else
{
    Write-Output "Docker not installed, the 'docker' command is required to run this script."
}