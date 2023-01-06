// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* Solution in console

    The first thing you're going to need it's to get the slot 1 in the storage of the instance
    You see, you can access to the storage slots of the smart contract
    For example, the value of the storage 0 is 1, that represents the true value in a boolean
    -let password = await web3.eth.getStorageAt(instance, 1)

    Once you have the password, you're going to pass it as a parameter in the unlock function
    -await contract.unlock(password)

*/