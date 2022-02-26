
// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.8.4;

contract DataBase{
    // @params struct:extend the citizen record to add more  items to record
    struct NationalIds{
        bytes32 NIN;
        bytes32 VoterCard;
        bytes32 DriverLicense;
        bool passport;
    }

    struct BirthCert{
        address addr;
        bytes32 uniqueID;
        string fatherName;
        string motherName;
        uint age;
        NationalIds details;
    }
    mapping(string => BirthCert) public BirthCertRecords;
    mapping(address => bool) BirthCertExist;

    address owner;
    string nameOfOrganization;

    constructor(string memory _name){
        owner = msg.sender;
        nameOfOrganization = _name; 
    }

 modifier onlyAdmin(){
     require(owner == msg.sender);
     _;
 }

    // @add to the struct
    function addToCitizens(address _addr, string memory _fatherName, string memory _motherName, uint _age, string memory _fullName, bool _passport) external onlyAdmin {
       require(BirthCertExist[_addr] == false);
        bytes32  random = concat( _addr, _age);
         bytes32  Nin = genNIN( _fatherName, _age);
          bytes32  License = genLicense( _motherName, _age);
           bytes32  Vc = genVc( _fullName, _age);
    BirthCert storage citizen = BirthCertRecords[_fullName];
    citizen.addr = _addr;
    citizen.uniqueID = random;
    citizen.fatherName = _fatherName;
    citizen.motherName = _motherName;
    citizen.age = _age;
    citizen.details.NIN = Nin;
    citizen.details.VoterCard=  Vc;
    citizen.details.DriverLicense =License;
    citizen.details.passport  =_passport;
    BirthCertExist[_addr] =true;
    }
     function citizenssDatabase(string[] memory query) external view returns (BirthCert[] memory arr) {
          arr = new BirthCert[](query.length);
         for(uint i=0; i < query.length; i++){
             arr[i] =  BirthCertRecords[query[i]];
         }
     }

    function concat(address _address, uint _age) private view  returns (bytes32){
        return  bytes32 (abi.encodePacked(_address,_age, block.timestamp));
    }
        function genNIN(string memory _fatherName, uint _age) private view  returns (bytes32){
        return  bytes32 (abi.encodePacked(_fatherName,_age, block.timestamp));
    }
        function genLicense(string memory _motherName, uint _age) private view  returns (bytes32){
        return  bytes32 (abi.encodePacked(_motherName,_age, block.timestamp));
    }
        function genVc(string memory _fullName, uint _age) private view  returns (bytes32){
        return  bytes32 (abi.encodePacked(_fullName,_age, block.timestamp));
    }


}