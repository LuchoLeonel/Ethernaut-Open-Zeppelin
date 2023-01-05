// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

contract HackNaughtCoin {
    address public timeZone1Library; // SLOT 0
    address public timeZone2Library; // SLOT 1
    address public owner; // SLOT 2
    uint256 storedTime;

    function setTime() /*uint256 _time*/ public {
        owner = msg.sender;
    }
}
