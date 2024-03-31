import { HardhatUserConfig } from "hardhat/config";
import dotenv from "dotenv";

dotenv.config();

// Validates that the PRIVATE_KEY environment variable is set.
if (!process.env.PRIVATE_KEY) {
  throw new Error("Please set your PRIVATE_KEY in a .env file");
}

// Supports an array of private keys
const accounts = process.env.PRIVATE_KEY ? process.env.PRIVATE_KEY.split(',') : [];

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    holesky: {
      url: process.env.HOLESKY_RPC_URL || "https://holesky.ethpandaops.io",
      accounts: accounts,
      chainId: 17000, // Holešky Chain ID
    },
  },
  // Additional configurations like etherscan API key for verifying contracts
};

export default config;