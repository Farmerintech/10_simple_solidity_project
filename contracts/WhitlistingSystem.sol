// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3.0;

contract Whitlist {

    mapping(address => bool) whitlistedList;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner(){
        require(msg.sender == owner, "You are not allowed, only the owner is allowed");
        _;
    }

    function addToWhiteList (address _address) public isOwner {
        whitlistedList[_address] = true;
    } 

     function removeFromWhiteList (address _address) public isOwner {
        whitlistedList[_address] = false;
    } 

    function isWhitlisted (address _address) public view returns (bool){
        return whitlistedList[_address];
    }
}