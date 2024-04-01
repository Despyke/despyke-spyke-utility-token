import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-ethers"; // For interacting with Ethereum
import "@nomiclabs/hardhat-etherscan"; // For contract verification
import dotenv from "dotenv";

dotenv.config();

if (!process.env.PRIVATE_KEY) {
  throw new Error("Please set your PRIVATE_KEY in a .env file");
}

const accounts = process.env.PRIVATE_KEY ? process.env.PRIVATE_KEY.split(',') : [];

// Add your Etherscan (or equivalent) API key here
const etherscanApiKey = process.env.ETHERSCAN_API_KEY || "";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    holesky: {
      url: process.env.HOLESKY_RPC_URL || "https://holesky.ethpandaops.io",
      accounts: accounts,
      chainId: 17000, // Holešky Chain ID
    },
    vanar: { // Add a new network entry for Vanar
      url: process.env.VANAR_RPC_URL || "https://rpc-vanguard.vanarchain.com",
      accounts: accounts,
      chainId: 78600, // Vanar Chain ID
    },
    // You can add more network configurations here
  },
  etherscan: {
    // Your Etherscan API key (this is just an example, replace "holesky" with the actual network if available)
    apiKey: etherscanApiKey,
  },
};

export default config;