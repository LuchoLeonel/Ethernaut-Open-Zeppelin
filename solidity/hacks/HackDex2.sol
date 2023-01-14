// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*  Use Remix https://remix.ethereum.org/

    The trick is that the swap function doesn't check if from or to arguments are in deed token1 or token2

    You need to deploy two SwappableTokenTwo with an initialSupply of 200 each
    Then, you need to send 100 of this token to de Dex, so in the balance will have 100 tokens
    Then, we need to make and approve from my wallet to the dex for an amount of 100 tokens
    This way the dex is gonna be able to spend my tokens
    Then you're going to call the function swap inside Dex2 contract
    Each time you're going to pass one SwappableTokenTwo as argument from and token1 or token2 as argument 2
    The amount it's going to be 100

    Congrats! If you did this with the two tokens, now to can submit the instance
    
*/