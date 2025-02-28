// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Records is ERC721 {
    // Mappings to store different records
    mapping(uint256 => insurance) public insurancelist;
    mapping(uint256 => history) public patienthistory;
    mapping(uint256 => past) public pasthistory;
    mapping(uint256 => diag) public diagnosis;
    mapping(uint256 => treat) public treatment;
    mapping(uint256 => prev) public prevdates;
    mapping(uint256 => patient) public patientlist;
    
    // Structs to store various data
    struct patient {
        uint256 patient_id;
    }

    struct prev {
        uint256 patient_id;
        string previous;
    }

    struct insurance {
        uint256 patient_id;
        string applicable;
        uint64 policy_no;
        string insurer;
        string policy_type;
        string policy_limit;
    }

    struct history {
        uint256 patient_id;
        string complaints;
        string duration;
    }

    struct past {
        uint256 patient_id;
        string family_history;
        string personal_history;
        string drug_history;
    }

    struct diag {
        uint256 patient_id;
        string diag_summary;
        string prescription;
    }

    struct treat {
        string treatment;
        string date_treatment;
        uint256 doctor_id;
        uint256 hospital_id;
        string discharge;
        string follow_up;
    }

    address public owner;

    /**
     * @dev Constructor to initialize the contract.
     */
    constructor() ERC721("SameerMedicalCoin", "SMC") {
        owner = 0xb16859D07238dD99237b1ba02a5087eba78f615d; // Set address of the Doctor as owner
    }

    // Modifier to give access only to the doctor (owner)
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed: Only the doctor can perform this operation.");
        _;
    }

    /**
     * @dev Mint a medical record token.
     * @param patient_id patient id
     */
    function medical_record(uint256 patient_id) public isOwner {
        // Mint the ERC721 token to represent a medical record for the patient
        _mint(msg.sender, patient_id);
        patientlist[patient_id] = patient({patient_id: patient_id}); // Storing patient details
    }

    /**
     * @dev Store previous dates of records updated.
     * @param patient_id patient id
     * @param _previous previous dates of records updated
     */
    function previous_dates(uint256 patient_id, string memory _previous) public isOwner {
        prev storage pr = prevdates[patient_id];
        pr.previous = _previous;
    }

    /**
     * @dev Retrieve previous dates of records updated.
     * @param patient_id patient id
     * @return previous dates
     */
    function get_previous_dates(uint256 patient_id) public view returns (string memory) {
        prev memory pr = prevdates[patient_id];
        return pr.previous;
    }

    /**
     * @dev Store insurance details.
     * @param patient_id patient id
     * @param _applicable is applicable or not
     * @param _policy_no policy number
     * @param _insurer name of insurer
     * @param _policy_type type of policy
     * @param _policy_limit limit of policy
     */
    function insurance_details(
        uint256 patient_id,
        string memory _applicable,
        uint64 _policy_no,
        string memory _insurer,
        string memory _policy_type,
        string memory _policy_limit
    ) public isOwner {
        insurance storage i = insurancelist[patient_id];
        i.applicable = _applicable;
        i.policy_no = _policy_no;
        i.insurer = _insurer;
        i.policy_type = _policy_type;
        i.policy_limit = _policy_limit;
    }

    /**
     * @dev Retrieve insurance details.
     * @param patient_id patient id
     * @return insurance details
     */
    function get_insurance(uint256 patient_id) public view returns (string memory, uint64, string memory, string memory, string memory) {
        insurance memory i = insurancelist[patient_id];
        return (i.applicable, i.policy_no, i.insurer, i.policy_type, i.policy_limit);
    }

    /**
     * @dev Store present illness details.
     * @param patient_id patient id
     * @param _complaints complaints
     * @param _duration duration of the complaint
     */
    function present_illness(uint256 patient_id, string memory _complaints, string memory _duration) public isOwner {
        history storage hi = patienthistory[patient_id];
        hi.complaints = _complaints;
        hi.duration = _duration;
    }

    /**
     * @dev Retrieve present illness details.
     * @param patient_id patient id
     * @return complaints and duration
     */
    function get_present_illness(uint256 patient_id) public view returns (string memory, string memory) {
        history memory hi = patienthistory[patient_id];
        return (hi.complaints, hi.duration);
    }

    /**
     * @dev Store past illness details.
     * @param patient_id patient id
     * @param _family_history history of family illness
     * @param _personal_history history of personal illness
     * @param _drug_history history of drug usage
     */
    function past_illness(uint256 patient_id, string memory _family_history, string memory _personal_history, string memory _drug_history) public isOwner {
        past storage pa = pasthistory[patient_id];
        pa.family_history = _family_history;
        pa.personal_history = _personal_history;
        pa.drug_history = _drug_history;
    }

    /**
     * @dev Retrieve past illness details.
     * @param patient_id patient id
     * @return family history, personal history, drug history
     */
    function get_past_illness(uint256 patient_id) public view returns (string memory, string memory, string memory) {
        past memory pa = pasthistory[patient_id];
        return (pa.family_history, pa.personal_history, pa.drug_history);
    }

    /**
     * @dev Store functional diagnosis details.
     * @param patient_id patient id
     * @param _diag_summary summary of diagnosis
     * @param _prescription prescription
     */
    function func_diagnosis(uint256 patient_id, string memory _diag_summary, string memory _prescription) public isOwner {
        diag storage d = diagnosis[patient_id];
        d.diag_summary = _diag_summary;
        d.prescription = _prescription;
    }

    /**
     * @dev Retrieve functional diagnosis details.
     * @param patient_id patient id
     * @return diagnosis summary and prescription
     */
    function get_func_diagnosis(uint256 patient_id) public view returns (string memory, string memory) {
        diag memory d = diagnosis[patient_id];
        return (d.diag_summary, d.prescription);
    }

    /**
     * @dev Store treatment summary details.
     * @param patient_id patient id
     * @param _treatment treatment
     * @param _date_treatment date of treatment
     * @param _doctor_id id of doctor treated
     * @param _hospital_id id of hospital
     * @param _discharge date of discharge
     * @param _follow_up date for follow up
     */
    function treatment_summary(
        uint256 patient_id,
        string memory _treatment,
        string memory _date_treatment,
        uint256 _doctor_id,
        uint256 _hospital_id,
        string memory _discharge,
        string memory _follow_up
    ) public isOwner {
        treat storage tr = treatment[patient_id];
        tr.treatment = _treatment;
        tr.date_treatment = _date_treatment;
        tr.doctor_id = _doctor_id;
        tr.hospital_id = _hospital_id;
        tr.discharge = _discharge;
        tr.follow_up = _follow_up;
    }

    /**
     * @dev Retrieve treatment summary details.
     * @param patient_id patient id
     * @return treatment details
     */
    function get_treatment_summary(uint256 patient_id) public view returns (string memory, string memory, uint256, uint256, string memory, string memory) {
        treat memory tr = treatment[patient_id];
        return (tr.treatment, tr.date_treatment, tr.doctor_id, tr.hospital_id, tr.discharge, tr.follow_up);
    }
}
