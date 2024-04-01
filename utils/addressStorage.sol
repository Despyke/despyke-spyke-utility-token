// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressStorage {
    address[] public addresses;

    constructor(address[] memory _initialAddresses) {
        addresses = _initialAddresses;
    }

    function addAddress(address _newAddress) public {
        addresses.push(_newAddress);
    }

    // Other functions for interacting with the address list...
}

// Now let's add the team address
contract TeamAddresses {
    AddressStorage public addressStorage;

    constructor(AddressStorage _addressStorage) {
        addressStorage = _addressStorage;
    }

    function addTeamAddress() external {
        address teamAddress1 = 0xfdbcFA2CAa1156e23f88ADa4ba5caba049B23220;
        addressStorage.addAddress(teamAddress1);
    }
}
