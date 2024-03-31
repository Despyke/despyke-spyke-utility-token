# Despyke's Spyke utility token project

 This repository contains the development environment for the Spyke Utility Token, leveraging the Hardhat framework for Ethereum. Our project includes smart contracts for the Spyke token, unit tests for ensuring contract integrity, and deployment scripts for public networks.

## Features

- **Spyke token Ccntract**: An ERC-20 compliant utility token for the Despyke ecosystem.
- **Comprehensive test suite**: Ensures contract functionality and security.
- **Deployment scripts**: For deploying the token contract to Ethereum networks.
- **Hardhat ignition module**: Simplifies deployment and interaction with the contracts.

## Getting Started

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

- **View Hardhat Tasks**: List all available tasks.

    ```shell
    yarn hardhat help
    ```

- **Run Tests**: Execute the test suite.

    ```shell
    yarn hardhat test
    ```

- **Generate Gas Usage Report**: Requires `hardhat-gas-reporter`.

    ```shell
    REPORT_GAS=true yarn hardhat test
    ```

- **Start Local Ethereum Node**: For development and testing.

    ```shell
    yarn hardhat node
    ```

- **Deploy Contracts**: Using Hardhat Ignition.

    ```shell
    yarn hardhat ignition deploy ./ignition/modules/SpykeToken.ts
    ```

## Coding Standards

Our project adheres to the [Ethereum Foundation's Solidity Style Guide](https://docs.soliditylang.org/en/v0.8.11/style-guide.html). We expect all contributors to follow these guidelines to maintain code consistency and quality across the Despyke ecosystem.

## Contributing

Contributions are welcome! Please refer to our [CONTRIBUTING.md](CONTRIBUTING.md) file for more information on how to get involved and submit pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file in the repository for full license text.
