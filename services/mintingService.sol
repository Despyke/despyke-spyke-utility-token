// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract SpykeToken is ERC20, Ownable, ERC20Pausable {
    uint256 public constant TOTAL_SUPPLY = 1e12 * 1e18; // 1 trillion SPYKE

    constructor() ERC20("SpykeToken", "SPYKE") {
        // Initial mint or set aside for future minting.
    }

    /**
     * @dev Mints tokens to a specified address, ensuring the total supply cap is not exceeded.
     * Can only be called by the contract owner. The contract must not be paused.
     *
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) public onlyOwner whenNotPaused {
        require(to != address(0), "SpykeToken: cannot mint to the zero address");
        require(amount > 0, "SpykeToken: amount must be greater than zero");
        require(totalSupply() + amount <= TOTAL_SUPPLY, "SpykeToken: Cannot exceed total supply");

        _mint(to, amount);
    }

    /**
     * @dev Pauses all token transfers.
     *
     * Requirements:
     * - the caller must be the owner.
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     *
     * Requirements:
     * - the caller must be the owner.
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Override of ERC20Pausable's _beforeTokenTransfer to ensure custom logic 
     * for pausing is implemented.
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
