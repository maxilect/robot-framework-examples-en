*** Settings ***
Documentation       Example of smoke-autotest with template.
...                 Tests with templates are scaled easily.
...                 Tagging added including non-critical tags
...                 Russian language keywords
Library             RequestsLibrary
Test Setup          Создать соединение
Test Teardown       Закрыть все соединения
Test Template       Smoke-тест

*** Variables ***
${base_url}         https://en.wikipedia.org/wiki

*** Test Cases ***
Check accessibility of Isaac Newton page
    [Tags]              Newton
    /Isaac_Newton       1642

Check accessibility of Albert Einstein page
    [Tags]              Einstein
    /Albert_Einstein    1879

Check accessibility of Stephen Hawking page
    [Tags]              Hawking
    /Stephen_Hawking    1942

Check accessibility of non-existent page (to display error)
    [Tags]              Numbers
    /123456789          1899

Check accessibility of non-existent page (to display non-critical errors)
    [Tags]              Letters    Known
    /abcdefghi          1799

*** Keywords ***
Создать соединение
    Create session     conn     ${base_url}    disable_warnings=1

Закрыть все соединения
    Delete all sessions

Smoke-тест
    [Arguments]     ${url}    ${expected_word}
    ${response}     Get request        conn     ${url}
                    Should be equal    ${response.status_code}    ${200}
    ...                 msg=Response code != 200 ОК during GET ${url}.
                    Check word on page    ${response.text}    ${expected_word}

Check word on page
    [Arguments]     ${text}    ${expected_word}
                    Should contain    ${text}    ${expected_word}    msg=Can't find the word ${expected_word}!
