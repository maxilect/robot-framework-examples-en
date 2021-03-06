*** Settings ***
Documentation       Robot Framework with python.
Library             libraries.ArrayGeneratorLibrary

*** Test Cases ***
Example of python lib usage.
    ${array}        Generate numbers array    ${5}    ${2}    ${8}
    Log to console    ${array}

Method wrapper with nested parameters.
    ${array}        Generate 5 numbers, from 2 to 8
    Log to console    ${array}

Pass the part of the method name as parameter. Loop.
    ${types}        Create list    even    odd
    ${array}        Generate 5 numbers, from 12 to 28
    FOR   ${type}   IN    @{types}
        ${numbers}      Run keyword    Find ${type} numbers in list    ${array}
        log to console     ${numbers}
    END

Decorator example
    ${negs}         Find negatives in the response by calling  Generate numbers array  10  -5  5
    log to console  ${negs}

*** Keywords ***
Find even numbers in list
    [Arguments]     ${list}
    ${evens}        Evaluate    [i for i in $list if i % 2 == 0]
    [Return]        ${evens}

Find odd numbers in list
    [Arguments]     ${list}
    ${odds}         Evaluate    [i for i in $list if i % 2 != 0]
    [Return]        ${odds}

Generate ${n} numbers, from ${from} to ${to}
    ${result}       Generate numbers array    ${n}    ${from}    ${to}
    [Return]        ${result}

Find negatives in the response by calling
    [Arguments]     ${keyword}    @{args}   &{kwargs}
    ${list}         Run keyword    ${keyword}    @{args}    &{kwargs}
    ${negs}         Evaluate    [i for i in $list if i < 0]
    [Return]        ${negs}






