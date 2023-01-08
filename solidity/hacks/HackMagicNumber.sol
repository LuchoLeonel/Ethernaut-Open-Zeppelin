// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// We create this contract to use it in remix
// https://remix.ethereum.org/
// We deploy it and see into the debug window
contract TestingOpcodes {
    function whatIsTheMeaningOfLife() pure external returns(uint){
        assembly { 
            // 2a in Hex is 42
            mstore(0x00, 0x2a) // Store 42 in memory address 0
            return(0x00, 0x20) // return memory at address 0 with 0x20 length
        }
    }
}

/* We're going to find the following opcodes using remix:

    0x602a - 2    (PUSH1 2a)   |
    0x6000 - 2    (PUSH1 00)   |- MSTORE(0x00, 0x2a)
    0x52   - 1    (MSTORE)     |
    0x6020 - 2    (PUSH1 0x20)  |
    0x6000 - 2    (PUSH1 0x00)  |- RETURN(0x00,0x20) 
    0xF3   - 1    (RETURN)      |
    ======== 10 bytes => 0x0a  
    32 - 10 bytes = 22 bytes => 0x16    
    ========    
    0x602a60005260206000f3 with 22 bytes prepadding

 */

// So we're going to use this opcodes of 10 bytes in a new contract that it's going to be deployed
contract HackMagicNumber {
    constructor() {
        assembly{
            // Store bytecode at to mem position 0
            mstore(0x00, 0x602a60005260206000f3)
            // return mem position 0x16 => skip prepadding 0 for 22 bytes
            return(0x16, 0x0a)
        }
    }
}

/* To ensure this work you can call in the console the function and should return:
    0x000000000000000000000000000000000000000000000000000000000000002a

    -await web3.eth.call({
        to: '0xE8247ABecbF1E39193a66951E6A2db897aBF02D2', 
        data: '0x650500c1'
    })

    0x650500c1 is abi encoded for "whatIsTheMeaningOfLife()"

    Then pass the address of your contract to the MagicNumber contract and submit the instance
    -await contract.setSolver("YOUR_CONTRACT_ADDRESS")

*/
