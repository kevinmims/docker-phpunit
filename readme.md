# Docker container running php 5.6 and phpUnit

### This is a docker container and powershell script file that can be used to run phpunit tests in any folder containing a phpunit.xml file.  It also opens an chrome browser to a page that shows your code coverage.  If you have the logging element setup as below, refreshing this page will allow you to drill down into your code coverage line by line.

-----

## To use
1. `git clone https://github.com/kevinmims/docker-phpunit.git`
2. `docker build . -t phpunit` 
2. add the path to the direcory you put this in (ie C:/Projects/docker-phpunit/) to windows path (hit windows button, type 'environment variables' and add to PATH)
3. go to a location with a phpunit.xml file and type `dphpunit`

----

## Code coverage
Be sure the `<filter>` element is included in your phpunit.xml file (an example is below).  It defines what files to determine in the coverage test.

To run with code coverage on, type
```
phpunit --coverage-text
```
Another benefit is to look output the code coverage to a html file and open it in your browser.  You can do this by adding the `<logging>` element to your phpunit.xml.  Then navigate to:
```
CHROME file:///C:/PATH_TO_PROJECT/coverageHtml/coverage.html/index.html
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


