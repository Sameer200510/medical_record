// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Hospital Registration
 * @dev Store & retrieve hospital details 
 */
contract Hospital  {
    // Mapping to store hospital details by ID
    mapping(uint256 => hospital) public hospitallist;

    // Struct to store hospital details
    struct hospital {
        string hospital_name;
        string hospital_address;
        string hospital_spec;
    }

    // Owner address (the hospital that can store the details)
    address public owner;

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender; // Hospital address (who deploys the contract)
    }

    // Modifier to give access only to the hospital (owner)
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed: Only the hospital can store details.");
        _;
    }

    /**
     * @dev Store hospital details
     * @param hospital_id Hospital registration ID
     * @param _hospital_name Name of the hospital
     * @param _hospital_address Address of the hospital
     * @param _hospital_spec Specialization of the hospital
     */
    function store_hospital_details(
        uint256 hospital_id,
        string memory _hospital_name,
        string memory _hospital_address,
        string memory _hospital_spec
    ) public isOwner {
        // Store the hospital details in the mapping
        hospitallist[hospital_id] = hospital({
            hospital_name: _hospital_name,
            hospital_address: _hospital_address,
            hospital_spec: _hospital_spec
        });
    }

    /**
     * @dev Retrieve hospital details
     * @param hospital_id Hospital registration ID
     * @return hospital details (name, address, specialization)
     */
    function retrieve_hospital_details(uint256 hospital_id)
        public
        view
        returns (string memory, string memory, string memory)
    {
        // Ensure that the hospital exists in the mapping
        require(bytes(hospitallist[hospital_id].hospital_name).length > 0, "Hospital not found");

        hospital memory h = hospitallist[hospital_id];
        return (h.hospital_name, h.hospital_address, h.hospital_spec);
    }
}
