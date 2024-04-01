// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ConsentManager is Ownable {
     // Event definitions for transparency and auditing
    event ConsentGranted(address indexed user, string consentType, uint256 timestamp);
    event ConsentRevoked(address indexed user, string consentType, uint256 timestamp);
    event ConsentUpdated(address indexed user, string oldConsentType, string newConsentType, uint256 timestamp);

    // Struct to hold consent details
    struct ConsentLog {
        string consentType;
        bool isActive;
        uint256 timestamp;
    }

    // Mapping to store consent timestamps for each user and consent type
    mapping(address => mapping(string => uint256)) private consents;
    mapping(address => ConsentLog[]) private userConsents;

    /**
     * @dev Grants or updates consent for a user.
     * @param user Address of the user granting or updating consent.
     * @param consentType Type of consent granted or updated.
     * @param isActive Whether the consent is being granted or revoked.
     */
    function setConsent(address user, string memory consentType, bool isActive) public {
        userConsents[user].push(ConsentLog({
            consentType: consentType,
            isActive: isActive,
            timestamp: block.timestamp
        }));

        if(isActive) {
            emit ConsentGranted(user, consentType, block.timestamp);
        } else {
            emit ConsentRevoked(user, consentType, block.timestamp);
        }
    }

    /**
     * @dev Grants consent for a user.
     * @param user Address of the user granting consent.
     * @param consentType Type of consent granted.
     */
    function grantConsent(address user, string memory consentType) public {
        require(consents[user][consentType] == 0, "Consent already granted.");
        consents[user][consentType] = block.timestamp;
        emit ConsentGranted(user, consentType, block.timestamp);
    }

    /**
     * @dev Updates an existing consent's status.
     * @param user Address of the user updating consent.
     * @param consentType Type of consent being updated.
     * @param newConsentType New type of consent, if any.
     */
    function updateConsent(address user, string memory consentType, string memory newConsentType) public {
        bool found = false;
        for(uint i = 0; i < userConsents[user].length; i++) {
            if(keccak256(bytes(userConsents[user][i].consentType)) == keccak256(bytes(consentType)) && userConsents[user][i].isActive) {
                userConsents[user][i].isActive = false; // Revoke old consent
                emit ConsentRevoked(user, consentType, block.timestamp);
                found = true;
                break;
            }
        }

        require(found, "Consent not found.");
        setConsent(user, newConsentType, true); // Grant new consent
    }

    /**
     * @dev Revokes consent for a user.
     * @param user Address of the user revoking consent.
     * @param consentType Type of consent being revoked.
     */
    function revokeConsent(address user, string memory consentType) public {
        require(consents[user][consentType] != 0, "Consent not found.");
        emit ConsentRevoked(user, consentType, block.timestamp);
        delete consents[user][consentType];
    }

    /**
     * @dev Updates consent for a user.
     * @param user Address of the user updating consent.
     * @param oldConsentType Type of consent being updated.
     * @param newConsentType New type of consent.
     */
    function updateConsent(address user, string memory oldConsentType, string memory newConsentType) public {
        require(consents[user][oldConsentType] != 0, "Old consent not found.");
        revokeConsent(user, oldConsentType);
        grantConsent(user, newConsentType);
        emit ConsentUpdated(user, oldConsentType, newConsentType, block.timestamp);
    }

    /**
     * @dev Retrieves the timestamp of when a consent was granted.
     * @param user Address of the user.
     * @param consentType Type of consent.
     * @return timestamp of the consent action.
     */
    function getConsentTimestamp(address user, string memory consentType) public view returns (uint256) {
        return consents[user][consentType];
    }

      /**
     * @dev Retrieves the consent logs for a user.
     * @param user Address of the user.
     * @return Array of consent logs.
     */
    function getConsentLogs(address user) public view returns (ConsentLog[] memory) {
        return consents[user];
    }
}
