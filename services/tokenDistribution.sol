// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../contracts/SpykeToken.sol";
import "./vestingService.sol";

contract TokenDistributionService is Ownable {
    SpykeToken private token;
    VestingService private vestingService;

    constructor(SpykeToken _token, VestingService _vestingService) {
        token = _token;
        vestingService = _vestingService;
    }

    // You can add functions here to interact with the VestingService for setting up vesting
    // and to perform other token distribution tasks like airdrops, etc.
}
