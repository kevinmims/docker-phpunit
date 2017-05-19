# Docker container running php 5.6 and phpUnit

### This is a docker container and powershell script file that can be used to run phpunit tests in any folder containing a phpunit.xml file.  It also opens an chrome browser to a page that shows your code coverage.  If you have the logging element setup as below, refreshing this page will allow you to drill down into your code coverage line by line.

-----

## To use
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
4. This will build the docker container for you.  It will also put the path this direcory in your windows environment variables path (ie C:\YOUR-PATH_HERE\docker-phpunit\).
5. go to a folder that contains a phpunit.xml file and type:
```
docker-phpunit
```
This will bring up the docker container, run your unit tests, show you your output in the terminal and open a chrome browser window to see your code coverage (if your phpunit.xml is configured correctly)

----

## Code coverage
You can run code coverage a few ways.  If you included the `<filter>` element in your phpunit.xml file (an example is below) it will run when you type `docker-phpunit`.

If you did not include that element, you can still see the code coverage percentages by adding the argument as below

```
phpunit --coverage-text
```

If you include the `<logging>` element in your phpunit.xml file, you will get a html page that shows your code coverage and will allow you to drill down to each file and see which lines are tested and which test verified the line.  The browser page the script opens will be on the following page:
```
CHROME file:///C:/PATH_TO_PROJECT/coverage.html/index.html
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

---

## PHPUnit.xml

Be sure your project includes this file.  Here is a sample format:
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


