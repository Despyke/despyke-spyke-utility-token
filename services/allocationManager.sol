// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./VestingService.sol"; // Adjust the import path as necessary

contract AllocationManager is Ownable {
    IERC20 public token;
    VestingService public vestingService;

    uint256 public constant TOTAL_SUPPLY = 1e12 * 1e18; // Example, adjust as necessary

    // Allocation percentages as constants
    uint256 public constant SEED_ROUND_PERCENTAGE = 3; // 3%
    uint256 public constant PRIVATE_ROUND_PERCENTAGE = 8; // 8%
    uint256 public constant PRESALE_ROUND_PERCENTAGE = 5; // 5%
    uint256 public constant PUBLIC_ROUND_PERCENTAGE = 9; // 9%
    uint256 public constant LIQUIDITY_ALLOCATION_PERCENTAGE = 10; // 10%
    uint256 public constant MARKETING_OPERATIONS_ALLOCATION_PERCENTAGE = 10; // 10%
    uint256 public constant ECOSYSTEM_TREASURY_STAKING_PLATFORM_DEVELOPMENT_ALLOCATION_PERCENTAGE = 35; // 35%
    uint256 public constant TEAM_AND_ADVISORS_ALLOCATION_PERCENTAGE = 10; // 10%
    uint256 public constant COMMUNITY_ALLOCATION_PERCENTAGE = 5; // 5%
    uint256 public constant PARTNERSHIP_AND_GRANTS_ALLOCATION_PERCENTAGE = 5; // 5%

    // Allocation names for mapping keys
    string[] public allocationNames = [
        "SeedRound",
        "PrivateRound",
        "PresaleRound",
        "PublicRound",
        "Liquidity",
        "MarketingOperations",
        "EcosystemTreasury",
        "TeamAndAdvisors",
        "Community",
        "PartnershipAndGrants"
    ];

    struct Allocation {
        uint256 amount;
        uint256 start;
        uint256 duration;
        bool created;
    }

    mapping(string => Allocation) public allocations;

    event AllocationCreated(string indexed name, uint256 amount, uint256 start, uint256 duration);
    event VestingScheduleInitiated(string indexed name, address indexed beneficiary, uint256 amount);

    constructor(address _tokenAddress, address _vestingServiceAddress) {
        require(_tokenAddress != address(0), "Token address cannot be the zero address.");
        require(_vestingServiceAddress != address(0), "Vesting service address cannot be the zero address.");

        token = IERC20(_tokenAddress);
        vestingService = VestingService(_vestingServiceAddress);

        // Automatically create allocations based on constants
        _createAllocations();
    }

    function _createAllocations() internal onlyOwner {
        uint256 totalSupply = token.totalSupply(); // Assuming `totalSupply()` is available

        _createAllocation("SeedRound", totalSupply * SEED_ROUND_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
        _createAllocation("PrivateRound", totalSupply * PRIVATE_ROUND_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
        _createAllocation("PresaleRound", totalSupply * PRESALE_ROUND_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
        _createAllocation("PublicRound", totalSupply * PUBLIC_ROUND_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
        _createAllocation("Liquidity", totalSupply * LIQUIDITY_ALLOCATION_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
        _createAllocation("MarketingOperations", totalSupply * MARKETING_OPERATIONS_ALLOCATION_PERCENTAGE / 100, block.timestamp, 12 * 30 days);
        _createAllocation("EcosystemTreasury", totalSupply * ECOSYSTEM_TREASURY_STAKING_PLATFORM_DEVELOPMENT_ALLOCATION_PERCENTAGE / 100, block.timestamp, 24 * 30 days);
        _createAllocation("TeamAndAdvisors", totalSupply * TEAM_AND_ADVISORS_ALLOCATION_PERCENTAGE / 100, block.timestamp, 36 * 30 days);
        _createAllocation("Community", totalSupply * COMMUNITY_ALLOCATION_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
        _createAllocation("PartnershipAndGrants", totalSupply * PARTNERSHIP_AND_GRANTS_ALLOCATION_PERCENTAGE / 100, block.timestamp, 6 * 30 days);
    }

    function _createAllocation(string memory name, uint256 amount, uint256 start, uint256 duration) internal {
        require(!allocations[name].created, "Allocation already exists.");
        allocations[name] = Allocation({
            amount: amount,
            start: start,
            duration: duration,
            created: true
        });
        emit AllocationCreated(name, amount, start, duration);
    }

    function initiateVestingSchedule(string memory allocationName, address beneficiary) public onlyOwner {
        require(allocations[allocationName].created, "Allocation does not exist.");
        Allocation storage allocation = allocations[allocationName];

        // Ensure there's enough token balance or set up token minting here if necessary
        require(token.transferFrom(owner(), address(vestingService), allocation.amount), "Token transfer to vesting service failed.");

        vestingService.createVestingSchedule(allocationName, beneficiary, allocation.amount, allocation.start, allocation.duration);
        emit VestingScheduleInitiated(allocationName, beneficiary, allocation.amount);
    }

    // Implement any additional management or reporting functions as needed
}