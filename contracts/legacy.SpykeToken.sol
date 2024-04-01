// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/TokenTimelock.sol";
import "@openzeppelin/contracts/finance/VestingWallet.sol"; 

contract SpykeToken is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 1e12 * 1e18; // 1 trillion SPYKE

    uint256 public constant SEED_ROUND_ALLOCATION = TOTAL_SUPPLY * 3 / 100; // 3%
    uint256 public constant PRIVATE_ROUND_ALLOCATION = TOTAL_SUPPLY * 8 / 100; // 8%
    uint256 public constant PRESALE_ROUND_ALLOCATION = TOTAL_SUPPLY * 5 / 100; // 5%
    uint256 public constant PUBLIC_ROUND_ALLOCATION = TOTAL_SUPPLY * 9 / 100; // 9%
    uint256 public constant LIQUIDITY_ALLOCATION = TOTAL_SUPPLY * 10 / 100; // 10%
    uint256 public constant MARKETING_OPERATIONS_ALLOCATION = TOTAL_SUPPLY * 10 / 100; // 10%
    uint256 public constant ECOSYSTEM_TREASURY_STAKING_PLATFORM_DEVELOPMENT_ALLOCATION = TOTAL_SUPPLY * 35 / 100; // 35%
    uint256 public constant TEAM_AND_ADVISORS_ALLOCATION = TOTAL_SUPPLY * 10 / 100; // 10%
    uint256 public constant COMMUNITY_ALLOCATION = TOTAL_SUPPLY * 5 / 100; // 5%
    uint256 public constant PARTNERSHIP_AND_GRANTS_ALLOCATION = TOTAL_SUPPLY * 5 / 100; // 5%

    uint256 public vestingStart = block.timestamp;
    uint256 public vestingDuration = 365 days; 
    mapping(string => VestingWallet) public vestingWallets;

    address[] public SEED_ADDRESSES;
    address[] public PRIVATE_ADDRESSES;
    address[] public PUBLIC_ADDRESSES;
    address[] public LIQUIDITY_ADDRESSES;
    address[] public MARKETING_OPERATIONS_ADDRESSES;
    address[] public ECOSYSTEM_TREASURY_ADDRESSES;
    address[] public TEAM_ADVISORS_ADDRESSES;
    address[] public COMMUNITY_ADDRESSES;
    address[] public PARTNERSHIP_GRANTS_ADDRESSES;

 constructor() ERC20("SpykeToken", "SPYKE") {
        _mint(address(this), TOTAL_SUPPLY);

        uint64 vestingStart = uint64(block.timestamp);

        // Properly calculate durations as seconds, then cast to uint64 if needed
        uint64 seedDuration = uint64(6 * 30 days); // Approximation for 6 months
        uint64 privateDuration = uint64(6 * 30 days); // Approximation for 6 months    
        uint64 publicDuration = uint64(6 * 30 days); // Approximation for 6 months    
        uint64 liquidityDuration = uint64(6 * 30 days); // Approximation for 6 months
        uint64 marketingDuration = uint64(12 * 30 days); // Approximation for 12 months
        uint64 ecosystemDuration = uint64(24 * 30 days); // Approximation for 24 months
        uint64 teamDuration = uint64(36 * 30 days); // Approximation for 36 months

        // Seed Round Vesting Wallet
        vestingWallets["SeedRound"] = new VestingWallet(SEED_ADDRESSES[0], vestingStart, seedDuration);
            _transfer(address(this), address(vestingWallets["SeedRound"]), SEED_ROUND_ALLOCATION);

        // Private Round Vesting Wallet
        vestingWallets["PrivateRound"] = new VestingWallet(PRIVATE_ADDRESSES[0], vestingStart, privateDuration);
        _transfer(address(this), address(vestingWallets["PrivateRound"]), PRIVATE_ROUND_ALLOCATION);

        // Public Round Vesting Wallet
        vestingWallets["PublicRound"] = new VestingWallet(PUBLIC_ADDRESSES [0], vestingStart, publicDuration);
        _transfer(address(this), address(vestingWallets["PublicRound"]), PUBLIC_ROUND_ALLOCATION);

        // Liquidity Allocation Vesting Wallet
        vestingWallets["Liquidity"] = new VestingWallet(LIQUIDITY_ADDRESSES [0], vestingStart, liquidityDuration);
        _transfer(address(this), address(vestingWallets["Liquidity"]), LIQUIDITY_ALLOCATION);
            
        // Marketing & Operations Vesting Wallet
        vestingWallets["MarketingOperations"] = new VestingWallet(MARKETING_OPERATIONS_ADDRESSES[0], vestingStart, marketingDuration);
        _transfer(address(this), address(vestingWallets["MarketingOperations"]), MARKETING_OPERATIONS_ALLOCATION);
            
        // Ecosystem/Treasury/Staking/Platform Development Vesting Wallet
        vestingWallets["EcosystemTreasury"] = new VestingWallet(ECOSYSTEM_TREASURY_ADDRESSES[0], vestingStart, ecosystemDuration);
        _transfer(address(this), address(vestingWallets["EcosystemTreasury"]), ECOSYSTEM_TREASURY_STAKING_PLATFORM_DEVELOPMENT_ALLOCATION);
            
        // Team and Advisors Vesting Wallet
        vestingWallets["TeamAdvisors"] = new VestingWallet(TEAM_ADVISORS_ADDRESSES[0], vestingStart, teamDuration);
        _transfer(address(this), address(vestingWallets["TeamAdvisors"]), TEAM_AND_ADVISORS_ALLOCATION);

        // NOTE: Adjust the `address(this)` in new VestingWallet(...) to the actual beneficiary addresses as required
    }
    
    function releaseVestedTokens(string memory group) public {
        VestingWallet wallet = vestingWallets[group];
        wallet.release();
    }

/**
     * @dev Mints tokens to a specified address, ensuring the total supply cap is not exceeded.
     * Emits a {Mint} event upon successful minting.
     *
     * Requirements:
     * - `to` cannot be the zero address.
     * - `amount` must be greater than zero.
     * - The total supply cap cannot be exceeded by minting the new amount.
     *
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    event Mint(address indexed to, uint256 amount);
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "SpykeToken: cannot mint to the zero address");
        require(amount > 0, "SpykeToken: amount must be greater than zero");
        require(totalSupply() + amount <= TOTAL_SUPPLY, "SpykeToken: Cannot exceed total supply");

        _mint(to, amount);
        emit Mint(to, amount);
    }
    
    // Function to handle the distribution based on the tokenomics
    // This will require more detailed implementation, especially for different rounds and their vesting/cliff periods
    function distributeTokens() public onlyOwner {
        // Example distribution call, adjust based on your distribution strategy
        // This might involve transferring tokens to vesting contracts or directly to beneficiary addresses
    }

    // Implement a function to release vested tokens if using custom vesting logic
    // Add other functions and modify existing ones as needed for your tokenomics and functionalities
}