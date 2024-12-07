*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    OperatingSystem
Resource   ../../../core/logger_core.resource

*** Variables ***
${BASE_URL}    	https://jsonplaceholder.typicode.com/

*** Keywords ***
Create Session on JSONPlaceholder API
    ${headers}    Create Dictionary    
    ...    Content-Type=application/json
    
    Create Session    alias=jsonplaceholder    
    ...    url=${BASE_URL}
    ...    headers=${headers}
    ...    disable_warnings=${True}

Get all posts made
    Create Session on JSONPlaceholder API
    ${response}    GET On Session    
    ...    alias=jsonplaceholder    
    ...    url=/posts    
    ...    json=${EMPTY}
    ...    expected_status=any
    Generate logs for the request    ${response}
    RETURN    ${response}

Get a specific post
    [Arguments]    ${post_id}
    Create Session on JSONPlaceholder API
    ${response}    GET On Session
    ...    alias=jsonplaceholder    
    ...    url=/posts/${post_id}    
    ...    json=${EMPTY}
    ...    expected_status=any
    Generate logs for the request    ${response}
    RETURN    ${response} 