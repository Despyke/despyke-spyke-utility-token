// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

error UnlockTimeInTheFuture();
error WithdrawTooEarly();
error NotOwner();

contract Lock {
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        if (_unlockTime <= block.timestamp) revert UnlockTimeInTheFuture();

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // Uncomment the following line for debugging purposes with Hardhat console
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);
        
        if (block.timestamp < unlockTime) revert WithdrawTooEarly();
        if (msg.sender != owner) revert NotOwner();

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
