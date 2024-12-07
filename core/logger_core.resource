*** Settings ***
Variables    ../settings.yaml

*** Keywords ***
Generate logs in the console for the requests made
    [Arguments]    ${response}

    IF     ${SETTINGS_ENABLE_LOGS} == ${True}
        Generate logs for the request    ${response}
    END

Generate logs for the request
    [Arguments]    ${response}

    Log To Console    \n------------------ REQUEST START ------------------
    Log To Console    \n${response.request.method} ${response.url}
    Log To Console    \nREQUEST HEADERS: ${response.request.headers}
    Log To Console    \nREQUEST BODY: ${response.request.body}
    Log To Console    \n\nRESPONSE BODY: ${response.text}
    Log To Console    \nSTATUS CODE: ${response.status_code}
    Log To Console    \n------------------- REQUEST END -------------------\n