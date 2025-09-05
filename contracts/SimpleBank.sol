// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import  "./HelloWorld.sol";

contract BasicBank {
    address private owner;
    constructor () {
         owner  = msg.sender;
         Users.push(User({
            id: owner,
            balance:10000000000000
         }));
    }

    mapping (address => User ) account;
    mapping (address => bool) isRegisteredUser;

    struct User{
        address id;
        uint balance;

    }
    User[] public Users;
    function RegisterUser () public {
       require(isRegisteredUser[msg.sender] = false, "Account already registered");
        User memory  newUser = User({
            id:msg.sender,
            balance:5000

        });
        Users.push(newUser);
    }
    modifier _isOwner(){
        require(msg.sender == owner, "You are not allowed");
        _;
    }
    modifier onlyRegisteredUser(address user) {
        require(isRegisteredUser[user], "Account not registered in our bank.");
    _;
}
   
    modifier CheckBalance(uint _balance){
        require(_balance < account[msg.sender].balance, "Insuffiecient Balance");
        _;
    }

    function getACCountBalance  () public view returns (uint) {
        return account[msg.sender].balance;
    }
    
    function Deposite () public payable{
         account[msg.sender].balance += msg.value ;
    }

     function Withdraw () public payable CheckBalance (msg.value) {
         account[msg.sender].balance -= msg.value ;
    }

    function getDeposites () public view _isOwner returns (uint)  {
        return address(this).balance;
    }

    function sendMoneyToUser (address  user ) public payable onlyRegisteredUser(user ) {
        account[user].balance +=msg.value;
    }
    function getAllUsers () public view _isOwner returns ( User[] memory) {
           return Users;

    }
     function borrowMoney (uint _amount) public {
        account[msg.sender].balance += _amount;
        account[owner].balance -= _amount;
    }
    
    function stake (uint _amount) public {
        account[msg.sender].balance -= _amount;
        account[owner].balance += _amount;
    }
}