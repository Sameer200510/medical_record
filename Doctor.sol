// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Hospital Registration
 * @dev Store & retrieve Hospital details 
 */
contract Doctor { 
    // Mapping to store doctor details by ID
    mapping(uint256 => doctor) public doctorlist;

    // Struct for storing doctor details
    struct doctor {
        string doctor_name;
        string doctor_specialisation;
        uint256 doctor_ph_no;
        string doctor_address;
    }

    address public owner;

    // Constructor to set the owner's address (hospital address)
    constructor(address _owner) {
        owner = _owner; // Set the hospital address
    }

    // Modifier to restrict access only to the hospital (owner)
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed: Only the hospital can store details.");
        _;
    }

    /**
     * @dev Store doctor details
     * @param doctor_id ID of the doctor
     * @param _doctor_name Name of the doctor
     * @param _doctor_specialisation Specialisation of the doctor
     * @param _doctor_ph_no Phone number of the doctor
     * @param _doctor_address Address of the doctor
     */
    function store_doctor_details(
        uint16 doctor_id,
        string memory _doctor_name,
        string memory _doctor_specialisation,
        uint256 _doctor_ph_no,
        string memory _doctor_address
    ) public isOwner {
        // Create a new doctor struct with the given details
        doctor memory d = doctor({
            doctor_name: _doctor_name,
            doctor_specialisation: _doctor_specialisation,
            doctor_ph_no: _doctor_ph_no,
            doctor_address: _doctor_address
        });

        // Store doctor details in the mapping
        doctorlist[doctor_id] = d;  
    }

    /**
     * @dev Retrieve doctor details
     * @param doctor_id ID of the doctor
     * @return doctor details (name, specialisation, phone number, and address)
     */
    function retrieve_doctor_details(uint16 doctor_id) 
        public 
        view 
        returns (string memory, string memory, uint256, string memory)
    {
        // Retrieve the doctor struct from the mapping
        doctor memory d = doctorlist[doctor_id];

        // Return the doctor details
        return (d.doctor_name, d.doctor_specialisation, d.doctor_ph_no, d.doctor_address);
    }
}
