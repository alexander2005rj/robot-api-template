*** Settings ***
Documentation    Resource with keywords for SQL database manipulation
Library          DatabaseLibrary
Library          OperatingSystem
Library          String
Resource         connections.resource

*** Keywords ***
Connect to a SQL-type database
    [Documentation]    This keyword is used to connect to the SQL database. 
    ...    Python modules currently "natively" supported: https://github.com/MarketSquare/Robotframework-Database-Library
    [Arguments]    ${sgdb_module}    ${database}
    Connect To Database    ${sgdb_module}    
    ...    ${database['DBName']}
    ...    ${database['DBUser']}    
    ...    ${database['DBPass']}
    ...    ${database['DBHost']}    
    ...    ${database['DBPort']}    

Create SQL query in string format
    [Documentation]    This keyword is used to read a .sql file and replace its variables. 
    ...    Its return is an SQL command in string format.
    ...    The variables to be replaced must be within the scope of the test.
    ...    You must inform them in the test using 'Set Test Variable'.
    [Arguments]    ${sql_file_name}
    ${sql_file_name}    Get File    ${CURDIR}/queries/sql/${sql_file_name}.sql
    ${sql_file_name}    Replace Variables    ${sql_file_name}
    RETURN    ${sql_file_name}

Execute Select Query
    [Documentation]    This keyword is used to execute SELECT statements. 
    ...    It returns the query result in dictionary form.
    [Arguments]    ${sgdb_module}     ${database}    ${sql_string}
    Connect to a SQL-type database    ${sgdb_module}    ${database}
    ${result}    Query    ${sql_string}    returnAsDict=True
    Disconnect From Database
    RETURN    ${result}

Execute SQL String
    [Documentation]    This keyword is used to execute INSERT, UPDATE or DELETE statements. There is no return.
    [Arguments]    ${sgdb_module}     ${database}    ${sql_string}
    Connect to a SQL-type database    ${sgdb_module}    ${database}
    Execute Select Query    ${sgdb_module}     ${database}    ${sql_string}
    Disconnect From Database