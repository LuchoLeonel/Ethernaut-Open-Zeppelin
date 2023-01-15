// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/DoubleEntryPoint.sol";

/*
  The goal of this challenge it's to protect Vault contract, not to hack it
  So, the vulnerability is that when we call the function sweepToken of the CryptoVault contract
  That function calls the transfer function of the LegacyToken contract, and
  That function calls the delegateTransfer function of the DoubleEntryPoint contract
  This way, when we whant to transfer a Legacy token we're actually transfering the DoubeEntryPoint token
  
  So, we're gonna make a Forta bot that detects when:
    -this function is called inside the DoubleEntryPoint contract
    -the origSender is the Vault contract
*/

contract ProtectDoubleEntryPoint is IDetectionBot {
  // We're going to use the Vault contract address to check if it's the origSender
  address private vault = 0x521ba1F005B90FEfd5360470427e694A8B1D2c61;
  // We're going to use the 4bytes signature of the delegateTransfer function to check if it's the function called
  bytes private functionSelector = abi.encodeWithSignature("delegateTransfer(address,uint256,address)");

  function handleTransaction(address user, bytes calldata msgData) external override {
    // Msg.data contains both the function selector and the function payload
    // The first 4 bytes of the msg.data are the function selector
    bytes memory msgDataSelector = abi.encodePacked(msgData[0], msgData[1], msgData[2], msgData[3]);
    // The following bytes are the function payload, wich are in this case the arguments to, value and origSender
    // We're going to use only the origSender address
    (address _to, uint256 _value, address origSender) = abi.decode(msgData[4:], (address, uint256, address));

    // Now, we make the checking:
    // The keccak256 hash of the msgData selector match with the one for delegateTransfer selector?
    // The origSender addres is the the vaul address?
    if (keccak256(msgDataSelector) == keccak256(functionSelector) && origSender == vault) {
      // If true, we're going to raise an alert for the user
      // This way the transaction it's going to be reverted and we're going to protect the Vault Contract
      IForta(msg.sender).raiseAlert(user);
    }
  }
}