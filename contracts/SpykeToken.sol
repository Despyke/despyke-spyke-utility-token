// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpykeToken is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 1e12 * 1e18; // 1 trillion SPYKE

    constructor() ERC20("SpykeToken", "SPYKE") {
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
