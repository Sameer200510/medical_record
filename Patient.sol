// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Patient Registration System
 * @dev Store & retrieve patient and attendant details
 */
contract Patient {
    // Mapping to store patient and attendant details by ID
    mapping(uint256 => patient) public patientlist;
    mapping(uint256 => attendant) public attendantlist;

    // Struct to store patient details
    struct patient {
        string patient_name;
        uint256 age;
        string gender;
        string height;
        uint256 weight;
        string patient_address;
        uint256 phone_no;
        string email_id;
        uint256 date;
        uint256 doctor_id;
        uint256 hospital_id;
    }

    // Struct to store attendant details
    struct attendant {
        uint256 patient_id;
        string attendant_name;
        string attendant_relation;
        uint256 attendant_phn_no;
    }

    // Owner address (the hospital that can store the details)
    address public owner;

    // Constructor to set the owner of the contract
    constructor(address _owner) {
        owner = _owner; // Hospital address (who deploys the contract)
    }

    // Modifier to give access only to the hospital (owner)
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed: Only the hospital can store details.");
        _;
    }

    /**
     * @dev Store patient details
     * @param patient_id Patient ID
     * @param _patient_name Patient name
     * @param _age Age
     * @param _gender Gender
     * @param _height Height
     * @param _weight Weight
     * @param _patient_address Address
     * @param _phone_no Phone number
     * @param _email_id Email ID
     * @param _date Date
     */
    function store_patient_details(
        uint256 patient_id,
        string memory _patient_name,
        uint256 _age,
        string memory _gender,
        string memory _height,
        uint256 _weight,
        string memory _patient_address,
        uint256 _phone_no,
        string memory _email_id,
        uint256 _date
    ) public isOwner {
        patientlist[patient_id] = patient({
            patient_name: _patient_name,
            age: _age,
            gender: _gender,
            height: _height,
            weight: _weight,
            patient_address: _patient_address,
            phone_no: _phone_no,
            email_id: _email_id,
            date: _date,
            doctor_id: 0, // You can set this later as needed
            hospital_id: 0 // You can set this later as needed
        });
    }

    /**
     * @dev Store attendant details
     * @param patient_id Patient ID
     * @param _attendant_name Name of attendant
     * @param _attendant_relation Relation to patient
     * @param _attendant_phn_no Phone number of the attendant
     */
    function store_attendant_details(
        uint256 patient_id,
        string memory _attendant_name,
        string memory _attendant_relation,
        uint256 _attendant_phn_no
    ) public isOwner {
        attendantlist[patient_id] = attendant({
            patient_id: patient_id,
            attendant_name: _attendant_name,
            attendant_relation: _attendant_relation,
            attendant_phn_no: _attendant_phn_no
        });
    }

    /**
     * @dev Retrieve patient details
     * @param patient_id Patient ID
     * @return Patient details (name, age, gender, height, weight, address, phone number, email, date)
     */
    function retrieve_patient_details(uint256 patient_id) 
        public view 
        returns (
            string memory,
            uint256,
            string memory,
            string memory,
            uint256,
            string memory,
            uint256,
            string memory,
            uint256
        )
    {
        patient memory p = patientlist[patient_id];
        return (
            p.patient_name,
            p.age,
            p.gender,
            p.height,
            p.weight,
            p.patient_address,
            p.phone_no,
            p.email_id,
            p.date
        );
    }

    /**
     * @dev Retrieve attendant details
     * @param patient_id Patient ID
     * @return Attendant details (name, relation, phone number)
     */
    function retrieve_attendant_details(uint256 patient_id) 
        public view 
        returns (string memory, string memory, uint256)
    {
        attendant memory a = attendantlist[patient_id];
        return (a.attendant_name, a.attendant_relation, a.attendant_phn_no);
    }
}

