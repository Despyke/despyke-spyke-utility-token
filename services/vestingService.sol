// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/finance/VestingWallet.sol";
import "../contracts/SpykeToken.sol";

contract VestingService is Ownable {
    SpykeToken private token;

    // Define the vesting wallet structure
    struct VestingWalletInfo {
        VestingWallet wallet;
        uint256 amount;
    }

    mapping(string => VestingWalletInfo) public vestingWallets;

    constructor(SpykeToken _token) {
        token = _token;
    }

    function createVestingWallet(string memory name, address beneficiary, uint256 amount, uint64 start, uint64 duration) public onlyOwner {
        require(address(vestingWallets[name].wallet) == address(0), "Vesting wallet already exists.");

        VestingWallet newWallet = new VestingWallet(beneficiary, start, duration);
        vestingWallets[name] = VestingWalletInfo(newWallet, amount);
        token.transfer(address(newWallet), amount);
    }

    function release(string memory name) public {
        require(address(vestingWallets[name].wallet) != address(0), "Vesting wallet does not exist.");
        vestingWallets[name].wallet.release();
    }
}
