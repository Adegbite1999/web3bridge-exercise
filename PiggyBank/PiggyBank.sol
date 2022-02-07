// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.8.0;

contract PiggyBank {
    // Anyone can deposit ETH into the contract
    // Only Owner can withdraw from the piggy bank
    // Once thhe owner withdraws, the contract is destroyed.

    mapping(address => uint256) balance;
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    // functionn deposit ETH into account;
    function deposit() public payable {
        require(msg.value > 0, "Amount too small"); // what if i run a constructor to set the owner of the piggyBank just once ??
        balance[msg.sender] += msg.value;
    }

    function BreakPiggy() public payable onlyOwner {
        address payable addr = payable(address(msg.sender));
        selfdestruct(addr);
    }

    function getBalance() public view returns (uint256) {
        return balance[msg.sender];
    }
    // function withdraw
    // unamed return variable can remain unassigned. add an explicit return with value to all non-rverting code path or name the variable

    // There will be a fallback function that recieve ether sent from other address
}
