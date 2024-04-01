# Despyke's Spyke utility token project

 This repository contains the development environment for the Spyke utility token, leveraging the Hardhat framework for Ethereum. Our project includes smart contracts for the Spyke token, unit tests for ensuring contract integrity, and deployment scripts for public networks.

## Features

- **Spyke Token Contract**: An ERC-20 compliant utility token for the Despyke ecosystem, featuring advanced functionalities like storing user meta data, consent logs, burning and pausing.
- **Comprehensive Test Suite**: Ensures contract functionality and security.
- **Deployment Scripts**: For deploying the token contract to Ethereum networks.
- **Hardhat Ignition Module**: Simplifies deployment and interaction with the contracts.
- **ConsentManager Contract**: Manages user consent logs on the blockchain, enhancing user privacy and ensuring transparent, immutable consent records.
- **Advanced Vesting Service**: A sophisticated service for managing token vesting schedules, supporting complex vesting scenarios.

## New planned features

### 1. Security features

- **ERC20Pausable**: Introduces the ability to pause and unpause token transfers, enhancing security and control in response to unforeseen circumstances.

### 2. Deflationary mechanisms
- **ERC20Burnable**: Allows tokens to be burned, reducing the overall supply and adding a deflationary mechanism to the tokenomics.

### 3. Staking 
- Allows tokens to be staked for rewards, whilst keeping the value ecosystem deflationary.

### 3. Immutable consent logs

- Transparently and immutably records every consent action by a user, with a timestamp for data integrity and non-repudiation.

### 4. Anonymity and privacy

- Utilizes Ethereum addresses as anonymized IDs, maintaining user privacy while ensuring traceability and accountability of consents.

### 5. Token reward system

- Seamlessly integrates with Despyke's broader ecosystem, including a token rewards system that aligns user consent for data sharing with token distribution and rewards.

## Getting started

### Prerequisites

Ensure you have [Node.js](https://nodejs.org/) (>=12.x) installed on your system. We recommend using [Yarn](https://yarnpkg.com/) for dependency management.

### Installation

1. Clone this repository to your local machine:

    ```shell
    git clone https://github.com/Despyke/despyke-utility-token
    ```

2. Navigate to the project directory:

    ```shell
    cd '/../../../despyke-utility-token'
    ```

3. Install the dependencies:

    ```shell
    yarn install
    ```

### Usage

Here are some key commands to interact with the project:

- **View Hardhat tasks**: List all available tasks.

    ```shell
    yarn hardhat help
    ```

- **Run tests**: Execute the test suite.

    ```shell
    yarn hardhat test
    ```

- **Generate gas usage report**: Requires `hardhat-gas-reporter`.

    ```shell
    REPORT_GAS=true yarn hardhat test
    ```

- **Start local Ethereum node**: For development and testing.

    ```shell
    yarn hardhat node
    ```

- **Deploy contracts**: Using Hardhat Ignition.

    ```shell
    yarn hardhat ignition deploy ./ignition/modules/SpykeToken.ts
    ```

## Coding standards

Our project adheres to the [Ethereum Foundation's Solidity Style Guide](https://docs.soliditylang.org/en/v0.8.11/style-guide.html). We expect all contributors to follow these guidelines to maintain code consistency and quality across the Despyke ecosystem.

## Contributing

Contributions are welcome! Please refer to our [CONTRIBUTING.md](CONTRIBUTING.md) file for more information on how to get involved and submit pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file in the repository for full license text.
