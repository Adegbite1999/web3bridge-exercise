// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract UniversityDB {
    struct University {
        string pka;
        string addr;
        string[] senate;
        mapping(string => Faculty) faculty;
    }
     struct UniversityWithoutMapping {
        string pka;
        string addr;
        string[] senate;
     }
    struct Faculty {
        string name;
        string deans;
        string[] hods;
        mapping(string => Dept) dept;
    }

    struct FacultyWithoutMapping {
        string name;
        string deans;
        string[] hods;
    }

    struct Dept {
        string name;
        string hod;
        mapping(string => Students) students;
    }

       struct DeptWithoutMapping {
            string name;
            string hod;
       }
    struct Students {
        string name;
        string nameUni;
        string gender;
        uint matricNo;
        uint cgpa;
    }

    mapping(string => University) stringToUni;
    
    function addUni(string memory _uniName, string memory _pka, string memory _addr, string[] memory _senate) public {
        University storage uni = stringToUni[_uniName];
        uni.pka = _pka;
        uni.addr = _addr;
        uni.senate = _senate;
    }
function addFaculty(string memory _uniName, string memory _fac, string memory _dean, string[] memory _hods) external {
University storage uni     =  stringToUni[_uniName];
uni.faculty[_fac].name =  _fac;
uni.faculty[_fac].deans = _dean;
uni.faculty[_fac].hods = _hods;
}

function addDepartment(string memory _fac,string memory _uniName,string memory _dept,string memory _name, string memory _hod) external{
University storage uni = stringToUni[_uniName];
uni.faculty[_fac].dept[_dept].name = _name;
uni.faculty[_fac].dept[_dept].hod = _hod;
}

function addStudent(string memory _fac,string memory _uniName,string memory _dept,string memory _name,
string memory _sname, string memory _gender, uint _matricNo, uint _cgpa) external{
University storage uni = stringToUni[_uniName];
uni.faculty[_fac].dept[_dept].students[_sname].name = _name;
uni.faculty[_fac].dept[_dept].students[_sname].gender = _gender;
uni.faculty[_fac].dept[_dept].students[_sname].matricNo = _matricNo;
uni.faculty[_fac].dept[_dept].students[_sname].cgpa = _cgpa;
}


// return university details
function viewUniversity(string[] memory query) view external returns(UniversityWithoutMapping[] memory uniDetail){
    uniDetail = new UniversityWithoutMapping[](query.length);
    for(uint i=0; i<query.length; i++){
    University storage uni = stringToUni[query[i]]; 
        uniDetail[i].pka  = uni.pka;
        uniDetail[i].addr = uni.addr;
        uniDetail[i].senate = uni.senate;
    }
}

function viewFaculty(string memory _uniName, string[] memory query) view external returns(FacultyWithoutMapping[] memory facultyDetails){
    facultyDetails = new FacultyWithoutMapping[](query.length);
    for(uint i=0; i<query.length; i++){
    Faculty storage fac = stringToUni[_uniName].faculty[query[i]];
        facultyDetails[i].name  = fac.name;
        facultyDetails[i].deans = fac.deans;
        facultyDetails[i].hods = fac.hods;

    }
}

function viewDept(string memory _uniName, string memory _facName,  string[] memory query) view external returns(DeptWithoutMapping[] memory deptDetails){
    deptDetails = new DeptWithoutMapping[](query.length);
    for(uint i=0; i<query.length; i++){
    Dept storage dept = stringToUni[_uniName].faculty[_facName].dept[query[i]];
        deptDetails[i].name  = dept.name;
        deptDetails[i].hod = dept.hod;
    }
}

function viewStudents( string[] memory query, string memory _uniName, string memory _facName, string memory _dept)  view external returns (Students[] memory studentDetail){
studentDetail = new Students[](query.length);
for(uint i=0; i < query.length; i++){
    Students storage stud = stringToUni[_uniName].faculty[_facName].dept[_dept].students[query[i]];
    studentDetail[i].name = stud.name;
    studentDetail[i].gender = stud.gender;
    studentDetail[i].matricNo = stud.matricNo;
    studentDetail[i].cgpa = stud.cgpa;
}
} 




}
