// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.8.9;

contract TestContract {
    bytes32 public name;

    function setName(bytes32 _data) public returns (bytes32){
        return name = _data;
    }

}