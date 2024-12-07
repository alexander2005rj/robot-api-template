*** Settings ***
Variables    ../settings.yaml


*** Variables ***
&{TEST_DB}    DBName=Test
...           DBHost=localhost    
...           DBPort=1234
...           DBUser=${SETTINGS_DATABASE_TEST_USERNAME}
...           DBPass=${SETTINGS_DATABASE_TEST_PASSWORD}