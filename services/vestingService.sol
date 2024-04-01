// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/finance/VestingWallet.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VestingService is Ownable {
    IERC20 public token;

    struct VestingSchedule {
        VestingWallet wallet;
        uint256 amountAllocated;
        bool exists;
    }

    mapping(string => VestingSchedule) public vestingSchedules;

    event VestingCreated(string indexed scheduleName, address indexed beneficiary, uint256 amountAllocated);
    event TokensReleased(string indexed scheduleName, address indexed beneficiary, uint256 amountReleased);

    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Token address cannot be the zero address.");
        token = IERC20(_tokenAddress);
    }

    function createVestingSchedule(
        string memory scheduleName,
        address beneficiary,
        uint256 amount,
        uint256 start,
        uint256 duration
    ) external onlyOwner {
        require(!vestingSchedules[scheduleName].exists, "Vesting schedule already exists.");
        require(beneficiary != address(0), "Beneficiary cannot be the zero address.");
        require(amount > 0, "Amount must be greater than zero.");
        require(duration > 0, "Duration must be greater than zero.");

        // Explicitly cast start and duration from uint256 to uint64
        uint64 start64 = uint64(start);
        uint64 duration64 = uint64(duration);

        // Ensure that the conversion hasn't caused data loss
        require(uint256(start64) == start, "Start time conversion overflow");
        require(uint256(duration64) == duration, "Duration conversion overflow");

        VestingWallet newWallet = new VestingWallet(beneficiary, start64, duration64);
        vestingSchedules[scheduleName] = VestingSchedule({
            wallet: newWallet,
            amountAllocated: amount,
            exists: true
        });

        require(token.transferFrom(msg.sender, address(newWallet), amount), "Token transfer failed.");
        emit VestingCreated(scheduleName, beneficiary, amount);
    }


    function releaseTokens(string memory scheduleName) external {
        require(vestingSchedules[scheduleName].exists, "Vesting schedule does not exist.");
        VestingWallet wallet = vestingSchedules[scheduleName].wallet;

        uint256 amountBefore = token.balanceOf(address(wallet));
        wallet.release();
        uint256 amountAfter = token.balanceOf(address(wallet));
        uint256 amountReleased = amountBefore - amountAfter;

        emit TokensReleased(scheduleName, address(wallet), amountReleased);
    }
}