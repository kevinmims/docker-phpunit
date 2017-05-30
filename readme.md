# Docker container running php 5.6 and phpUnit

### This is a docker container and powershell script file that can be used to run phpunit tests in any folder containing a phpunit.xml file.  It also opens an chrome browser to a page that shows your code coverage.  If you have the logging element setup as below, refreshing this page will allow you to drill down into your code coverage line by line.

-----

## To Install
1. Run PowerShell as Administrator

2. Go to the folder you want to hold the project then type:
```
git clone https://github.com/kevinmims/docker-phpunit.git
```
3. The project will be cloned into C:\YOUR_FOLDER_PATH\docker-phpunit.  Type:
```
cd docker-phpunit

./install.ps1
``` 
4. This will build the docker container for you.  It will also add the path of this directory to your windows environment variables path (ie C:\YOUR-PATH_HERE\docker-phpunit\).

----- 
## To Use
Go to a folder that contains a phpunit.xml file and type:

```
docker-phpunit
```

## Arguments

You can pass as many commands into the container as you choose by adding the `--` prefix to the command, ie
```
docker-phpunit --coverage-text
```

This will add the text output for code coverage to the powershell window (if your phpunit.xml is configured correctly). 


You can open a chrome browser window to see your code coverage from the command line by adding the `coverage` argument, ie

```
docker-phpunit coverage
```

Order does not matter
```
docker-phpunit coverage --coverage-text
```

> Currently, `coverage` is the only argument supported

-----

## PHPUnit.xml

> <b>Your project MUST include this file. </b>

1.  For code coverage, include the `<filter>` element

2. Include the `<logging>` element to get a html page that shows your code coverage and allows you to drill down to each file and see which lines are tested and which test verified the line.  Navigate your browser to the following page to view (or include the `coverage` argument as outlined above)

```
CHROME file:///C:/PATH_TO_PROJECT/coverage.html/index.html
```


Here is a sample `phpunit.xml` file
```
<phpunit bootstrap="bootstrap.php">
    <php>
        <env name="TEST" value="test"/>
        <ini name="display_errors" value="On" />
        <ini name="display_startup_errors" value="On" />
    </php>
    <testsuites>
        <testsuite>
            <directory>application/tests</directory>
        </testsuite>
    </testsuites>
    <filter>
        <whitelist processUncoveredFilesFromWhitelist="true">
            <directory suffix=".php">application/tests/</directory>
            <exclude>
                <directory suffix=".php">/path/to/files</directory>
                <file>/path/to/file</file>
            </exclude>
        </whitelist>
    </filter>
    <logging>
        <log type="coverage-html" target="/opt/project/coverageHtml/coverage.html"/>
    </logging>
</phpunit>
```

-----

## Trouble shooting

 Verify xdebug is installed
```
docker run -it phpunit bash

php -ini|grep 'xdebug support'
```
You should get `xdebug support => enabled`

To see all xdebug properties
```
php -ini|grep 'xdebug'
```

