// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version


/* Solution in console

  The function that was override is transfer but the function transferFrom was not overrided.
  The ERC20 standard from which we are inheriting has this function.
  
  This transfer needs to be approved first
  -await contract.approve(player, await contract.balanceOf(player))

  Once you approve the amount you want to transfer, you can call the function transferFrom
  -await contract.transferFrom(player, instance, await contract.balanceOf(player))

 */