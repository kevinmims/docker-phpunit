# must be run as administrator

# build the container
docker-compose build

# install path variable
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$PWD\", [EnvironmentVariableTarget]::Machine)
Write-Host 
Write-Host ---> Environment variable added for $PWD\
Write-Host 