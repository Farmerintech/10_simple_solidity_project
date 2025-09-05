// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import  "./HelloWorld.sol";

contract BasicBank {
    address private owner;
    constructor () {
         owner  = msg.sender;
         Users.push(User({
            _user: owner,
            balance:10000000000000
         }));
    }

    mapping (address => uint ) account;
    mapping (address => bool) isRegisteredUser;

    struct User{
        address _user;
        uint balance;

    }
    User[] public Users;
    function RegisterUser (address, uint) public {
       require(isRegisteredUser[msg.sender] = false, "Account already registered");
        User memory  newUser = User({
            _user:msg.sender,
            balance:account[msg.sender]

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
   
    modifier CheckBalance(uint _amount){
        require(_amount < account[msg.sender], "Insuffiecient Balance");
        _;
    }

    function getACCountBalance  () public view returns (uint) {
        return account[msg.sender];
    }
    
    function Deposite () public payable{
         account[msg.sender] += msg.value ;
         getACCountBalance();
    }

     function Withdraw () public payable CheckBalance (msg.value) {
         account[msg.sender] -= msg.value ;
         getACCountBalance();
    }

    function getDeposites () public view _isOwner returns (uint)  {
        return address(this).balance;
    }

    function sendMoneyToUser (address  user ) public payable onlyRegisteredUser(user ) {
        account[user] +=msg.value;
    }
    function getAllUsers () public view _isOwner returns ( User[] memory) {
           return Users;

    }
}