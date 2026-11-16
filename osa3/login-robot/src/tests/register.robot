*** Settings ***
Resource  resource.robot
Test Setup  Input New Command And Create User

*** Test Cases ***
Register With Valid Username And Password
    Input Credentials  uusi  Salasana1
    Output Should Contain  New user registered

Register With Already Taken Username And Valid Password
    Input Credentials  kalle  Salasana1
    Output Should Contain  Username is already taken

Register With Too Short Username And Valid Password
    Input Credentials  ab  Salasana1
    Output Should Contain  Username must be at least 3 characters long

Register With Enough Long But Invalid Username And Valid Password
    Input Credentials  Kalle  Salasana1
    Output Should Contain  Username must contain only lowercase letters

Register With Valid Username And Too Short Password
    Input Credentials  uusi  lyhyt
    Output Should Contain  Password must be at least 8 characters long

Register With Valid Username And Long Enough Password Containing Only Letters
    Input Credentials  uusi  salasanajokaonpitkä
    Output Should Contain  Password cannot contain only letters

*** Keywords ***
Input New Command And Create User
    Create User  kalle  kalle123
    Input New Command