@echo off
echo Compiling Java sources...
javac -d WEB-INF/classes -cp "c:\tomcat10\lib\servlet-api.jar;WEB-INF/lib/*" src/model/*.java src/util/*.java src/dao/*.java src/controller/*.java
if %errorlevel% neq 0 (
    echo Compilation failed!
    exit /b %errorlevel%
)
echo Compilation successful!