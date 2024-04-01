# Despyke's Spyke utility token project

 This repository contains the development environment for the Spyke utility token, leveraging the Hardhat framework for Ethereum. Our project includes smart contracts for the Spyke token, unit tests for ensuring contract integrity, and deployment scripts for public networks.

## Features

- **Spyke Token Contract**: An ERC-20 compliant utility token for the Despyke ecosystem, featuring advanced functionalities like burning and pausing.
- **Comprehensive Test Suite**: Ensures contract functionality and security.
- **Deployment Scripts**: For deploying the token contract to Ethereum networks.
- **Hardhat Ignition Module**: Simplifies deployment and interaction with the contracts.
- **ConsentManager Contract**: Manages user consent logs on the blockchain, enhancing user privacy and ensuring transparent, immutable consent records.
- **Advanced Vesting Service**: A sophisticated service for managing token vesting schedules, supporting complex vesting scenarios.

## New planned features

### Transition to Proof of Stake (PoS) for Minting

In alignment with our commitment to sustainability and scalability, future minting operations within the Despyke ecosystem will transition to a **Proof of Stake (PoS)** mechanism. This strategic move is guided by several core principles that align with our broader goals:

### Energy efficiency

- **PoS significantly reduces energy consumption** compared to the traditional Proof of Work (PoW) mechanism, aligning with our strong commitment to sustainability and environmental responsibility.

### Enhanced scalability and speed

- PoS enables **faster transaction speeds and enhanced scalability**. This improvement directly impacts the overall efficiency of our minting services, making the process smoother for users and reducing transaction backlog during high-demand periods.

### Security and decentralization

- A core principle of our transition to PoS is maintaining robust security mechanisms while also being conscious of avoiding centralization. We aim to foster **a more inclusive and secure network**, ensuring that our platform remains resilient against attacks and equitable in participation opportunities.

### Minting service impact

- The transition to PoS is expected to **provide a smoother experience for our minting services**, thanks to faster transaction processing times and more cost-effective transactions. This change will benefit users by improving the responsiveness and accessibility of our services.

We believe that transitioning to a Proof of Stake mechanism for future minting operations not only aligns with our commitment to sustainability and scalability but also sets a new standard for responsible blockchain development. Stay tuned for further updates as we make progress on this exciting transition.

### Enhanced security features

- **ERC20Pausable**: Introduces the ability to pause and unpause token transfers, enhancing security and control in response to unforeseen circumstances.
- **ERC20Burnable**: Allows tokens to be "burned," reducing the overall supply and adding a deflationary mechanism to the token economics.

### Immutable consent logs

- Transparently and immutably records every consent action by a user, with a timestamp for data integrity and non-repudiation.

### Anonymity and privacy

- Utilizes Ethereum addresses as anonymized IDs, maintaining user privacy while ensuring traceability and accountability of consents.

### Regulatory compliance

- Designed with adaptability in mind to comply with global privacy laws and regulations, including GDPR, reinforcing our commitment to user rights and privacy.

### Integration with Despyke ecosystem

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
