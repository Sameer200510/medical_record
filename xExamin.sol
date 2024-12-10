// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Hospital Registration
 * @dev Store & retrieve Hospital details
 */
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract xExamine is ERC721 {
    // Mappings to store patient details
    mapping(uint256 => tests) public patienttests;
    mapping(uint256 => scan) public scantests;
    mapping(uint256 => system) public systemexamine;
    mapping(uint256 => prev) public prevdates;
    mapping(uint256 => patient) public patientlist;

    // Structs for various patient details
    struct patient {
        uint256 patient_id;
    }

    struct prev {
        uint256 patient_id;
        string previous;
    }

    struct tests {
        uint256 patient_id;
        string blood_test;
        string urine_test;
        string ecg;
        string mri_scan;
        string ct_scan;
        string xray;
        string lab_test;
    }

    struct scan {
        uint256 patient_id;
        string built;
        string nourishment;
        string eyes;
        string tongue;
        uint64 pulse;
        uint64 temp;
        string blood_pressure;
        uint64 respiratory_rate;
    }

    struct system {
        uint256 patient_id;
        string cns;
        string cvs;
        string rs;
        string abdomen;
    }

    // Owner address (Doctor's address)
    address public owner;

    /**
     * @dev Constructor to initialize the contract.
     */
    constructor() ERC721("MedicalCoin", "MEDC") {
        owner = 0xb16859D07238dD99237b1ba02a5087eba78f615d; // Address of Doctor
    }

    // Modifier to give access only to the doctor
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }

    /**
     * @dev Function to display name of the token
     */
    function namedecl() public view returns (string memory) {
        return name(); // Calling the built-in function in ERC721
    }

    /**
     * @dev Function to display symbol of the token
     */
    function symboldecl() public view returns (string memory) {
        return symbol(); // Calling the built-in function in ERC721
    }

    /**
     * @dev Function to display the total count of the tokens
     */
    function totalSupply() public view returns (uint256) {
        // Return the total supply. Replace with appropriate implementation if needed.
        return totalSupply(); // This line can be removed or replaced by tracking supply manually.
    }

    /**
     * @dev Function to mint a medical record token
     * @param patient_id Patient's ID
     */
    function medical_record(uint256 patient_id) public {
        _mint(msg.sender, patient_id); // Mint the ERC721 token to represent a medical record for the patient
        patientlist[patient_id] = patient({patient_id: patient_id}); // Storing the patient details
    }

    /**
     * @dev Store previous dates of records updated
     * @param patient_id Patient ID
     * @param _previous Previous dates of records updated
     */
    function previous_dates(uint256 patient_id, string memory _previous) public isOwner {
        prev memory pr = prev({patient_id: patient_id, previous: _previous});
        prevdates[patient_id] = pr; // Storing the previous dates
    }

    /**
     * @dev Retrieve previous dates of records updated
     * @param patient_id Patient ID
     */
    function get_previous_dates(uint256 patient_id) public view returns (string memory) {
        prev memory pr = prevdates[patient_id];
        return pr.previous; // Returning the previous dates
    }

    /**
     * @dev Store investigations details
     * @param patient_id Patient ID
     * @param _blood_test Blood test result
     * @param _urine_test Urine test result
     * @param _ecg ECG result
     * @param _mri_scan MRI scan report
     * @param _ct_scan CT scan report
     * @param _xray X-ray result
     * @param _lab_test Other lab test result
     */
    function investigations(
        uint256 patient_id,
        string memory _blood_test,
        string memory _urine_test,
        string memory _ecg,
        string memory _mri_scan,
        string memory _ct_scan,
        string memory _xray,
        string memory _lab_test
    ) public isOwner {
        tests memory t = tests({
            patient_id: patient_id,
            blood_test: _blood_test,
            urine_test: _urine_test,
            ecg: _ecg,
            mri_scan: _mri_scan,
            ct_scan: _ct_scan,
            xray: _xray,
            lab_test: _lab_test
        });
        patienttests[patient_id] = t; // Storing the investigations details
    }

    /**
     * @dev Retrieve investigations details
     * @param patient_id Patient ID
     */
    function get_investigations(uint256 patient_id)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        tests memory t = patienttests[patient_id];
        return (t.blood_test, t.urine_test, t.ecg, t.mri_scan, t.ct_scan, t.xray, t.lab_test); // Returning investigations details
    }

    /**
     * @dev Store general examination details
     * @param patient_id Patient ID
     * @param _built Built of the patient
     * @param _nourishment Nourishment status
     * @param _eyes Eyes examination result
     * @param _tongue Tongue examination result
     * @param _pulse Pulse rate
     * @param _blood_pressure Blood pressure
     * @param _temp Temperature
     * @param _respiratory_rate Respiratory rate
     */
    function general_examin(
        uint256 patient_id,
        string memory _built,
        string memory _nourishment,
        string memory _eyes,
        string memory _tongue,
        uint64 _pulse,
        string memory _blood_pressure,
        uint64 _temp,
        uint64 _respiratory_rate
    ) public isOwner {
        scan memory s = scan({
            patient_id: patient_id,
            built: _built,
            nourishment: _nourishment,
            eyes: _eyes,
            tongue: _tongue,
            pulse: _pulse,
            blood_pressure: _blood_pressure,
            temp: _temp,
            respiratory_rate: _respiratory_rate
        });
        scantests[patient_id] = s; // Storing the general examination details
    }

    /**
     * @dev Retrieve general examination details
     * @param patient_id Patient ID
     */
    function get_general_examin(uint256 patient_id)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            uint64,
            string memory,
            uint64,
            uint64
        )
    {
        scan memory s = scantests[patient_id];
        return (
            s.built,
            s.nourishment,
            s.eyes,
            s.tongue,
            s.pulse,
            s.blood_pressure,
            s.temp,
            s.respiratory_rate
        ); // Returning the general examination details
    }

    /**
     * @dev Store systemic examination details
     * @param patient_id Patient ID
     * @param _cvs Cardio vascular system result
     * @param _cns Central nervous system result
     * @param _rs Respiratory system result
     * @param _abdomen Abdomen system result
     */
    function sys_examin(
        uint256 patient_id,
        string memory _cvs,
        string memory _cns,
        string memory _rs,
        string memory _abdomen
    ) public isOwner {
        system memory sys = system({
            patient_id: patient_id,
            cvs: _cvs,
            cns: _cns,
            rs: _rs,
            abdomen: _abdomen
        });
        systemexamine[patient_id] = sys; // Storing the systemic examination details
    }

    /**
     * @dev Retrieve system examination details
     * @param patient_id Patient ID
     */
    function get_sys_examin(uint256 patient_id)
        public
        view
        returns (string memory, string memory, string memory, string memory)
    {
        system memory sys = systemexamine[patient_id];
        return (sys.cvs, sys.cns, sys.rs, sys.abdomen); // Returning the system examination details
    }
}