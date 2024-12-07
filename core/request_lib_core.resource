*** Settings ***
Library    RequestsLibrary


*** Keywords ***
Validate the response status code
    [Arguments]    ${response}    ${expected_status_code}

    TRY
        ${url}    Set Variable    ${response.url}
        ${http_method}    Set Variable    ${response.request.method}
        ${actual_status_code}    Set Variable    ${response.status_code}
    EXCEPT   
        Fail    Unable to retrieve required response data for the request made. Please check the logs for more details.
    END
    
    Should Be Equal As Integers 
    ...    first=${actual_status_code}
    ...    second=${expected_status_code}
    ...    msg=Invalid status code. Actual: ${actual_status_code} | Expected: ${expected_status_code} \nRequest: ${http_method} ${url}
    ...    values=False

Generate logs for the request
    [Arguments]    ${response}    ${endpoint_name}

    Log To Console    \n------------------ ${endpoint_name} START ------------------
    Log To Console    \n${response.request.method} ${response.url}
    Log To Console    \nREQUEST HEADERS: ${response.request.headers}
    Log To Console    \nREQUEST BODY: ${response.request.body}
    Log To Console    \n\nRESPONSE BODY: ${response.text}
    Log To Console    \nSTATUS CODE: ${response.status_code}
    Log To Console    \n------------------- ${endpoint_name} END -------------------\n