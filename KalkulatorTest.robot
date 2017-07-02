*** Settings ***
Library  Selenium2Library
Suite Setup       Open calculator website
Test Teardown   My Teardown
Suite Teardown     Close Browser

*** Variables ***
${BROWSER}  Firefox
${CALCULATOR URL}  http://www.math.com/students/calculators/source/basic.htm

*** Test Cases ***
5+5=10
    Click Buttons   five   plus   five   DoIt
    Textfield Value Should Be   Input   10

-2+-2=-4
    Click Buttons   minus   two  plus   minus   two   DoIt
    Textfield Value Should Be   Input   -4

7+-6=1
    Click Buttons   seven   plus   minus   six   DoIt
    Textfield Value Should Be   Input   1

5-15=-10
    Result and operation   -10   five   minus   one   five

-6--5=-1
    Result and operation   -1   minus   six   minus   minus   five

-6-3=-9
    Result and operation   -9   minus   six   minus   three

6*-2.5=-15
    Click Buttons   six  times   minus   two
    point
    Click Buttons   five    DoIt
    Textfield Value Should Be   Input   -15


4*7=28
    Click Buttons   four  times  seven   DoIt
    Textfield Value Should Be   Input   28

-5.5*-4=22
    Click Buttons   minus   five
    point
    Click Buttons   five   times   minus   four   DoIt
    Textfield Value Should Be   Input   22

-10/-4=2.5
    Result and operation  2.5   minus   one   zero   div   minus   four

15/-3=-5
    Result and operation   -5   one   five   div   minus   three

0.5/0.5=1
    Click Buttons   zero
    point
    Click Buttons   five   div   zero
    point
    Click Buttons   five  DoIt
    Textfield Value Should Be   Input   1

10/0=Infinity
    Result and operation   Infinity   one   zero   div   zero

0/0=NaN
    Result and operation   NaN   zero   div   zero

0/10=0
    Result and operation  0   zero   div   one   zero

Clicking Clear should clear input
    Click Buttons    two    five
    Textfield Value Should Be    Input    25
    Click Button    clear
    Textfield Value Should Be    Input    ${EMPTY}

12345679*9=111111111
    Result and operation   111111111   one  two  three  four  five  six  seven  nine  times  nine

-7*3-5+30/3=-16
    Result and operation   -16   minus   seven   times   three  minus   five   plus   three  zero  div   three


*** Keywords ***
Open calculator website
    Open Browser   ${CALCULATOR URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be  Basic Calculator

Click Buttons
    [Arguments]    @{List of buttons}
    :FOR    ${button_text}    IN    @{List of buttons}
    \    Click Button    ${button_text}
    \    Sleep   1

Result and operation
    [Arguments]    ${Expected result}    @{Buttons to click}
    Click Buttons    @{Buttons to click}   DoIt
    Textfield Value Should Be    Input    ${Expected result}

point
    Press Key   Input   .
    Sleep   1

My Teardown
    Input Text    Input    ${EMPTY}
    Textfield Value Should Be    Input    ${EMPTY}
    Sleep   2
