// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank {
    // Functionalities as a user
    // Be able to get your balance => Done
    // Be able to withdraw money from your account => Done
    // Be able to send money to another account from your acccount => Done
    // Be able to deposit money into your account => done
// Contract build a bank account
// functionality of the bank should include:
// 

// Bank contract
// Functionalities as a user :
// user can deposit into thier account
// user can withdraw from their account
// user can send money to another account
// user can get account balance
// 

    // Functionalities as a bank
    // Be able to get bank balance 
    address immutable private COO;
    constructor (address _owner) {
         COO = _owner; 
    }
    uint bankBalance; 
    event ShowData (bytes data);

    mapping(address=> uint) private User_Balance;

    modifier onlyOwner () {
        require(COO == msg.sender, "Function can only be accessed by Bank");
        _;
    }
    function get_user_balance() external view returns (uint) {
        return User_Balance[msg.sender];
    }

    function deposit_funds () public payable {
        User_Balance[msg.sender] += msg.value ;
        bankBalance += msg.value;
    }

    receive () external payable{
        deposit_funds();
    }

    function withdraw_funds (uint _amount) external{
        require (User_Balance[msg.sender] >= _amount, "Insufficient Funds");
         User_Balance[msg.sender] -= _amount;
         (bool sent, bytes memory data) = msg.sender.call{value: _amount}('');
         require (sent == true, "Transaction failed");
       emit ShowData(data);
       bankBalance -= _amount;

    }

    function send_funds (uint _amount, address _to) external{
        require (User_Balance[msg.sender] >= _amount, "Insufficient Funds");
         User_Balance[msg.sender] -= _amount;
         (bool sent, bytes memory data) = _to.call{value: _amount}('');
         sent = true;
       emit ShowData(data);

    }

    function getBankBalance () onlyOwner view external returns (uint){
        return bankBalance;
    }
}
