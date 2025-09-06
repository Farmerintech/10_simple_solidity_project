// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3.0;


contract Faucet {

    address public owner;
    uint public balance;
    constructor () {
        owner = msg.sender;
    }

    uint256 faucetAmount = 0.01 ether;

    mapping(address => User ) public Account;

    struct User {
        address _address;
        uint256 balance;
        uint256 lastRequestTime;

    }
    modifier Cooldown(){
        require(block.timestamp >= Account[msg.sender].lastRequestTime + 1 days, "Maximum claim for today on this account" );
        _;
    }
    modifier hadEnoughBalance () {
        require(address(this).balance >= faucetAmount, "There is no enough funds in the faucet, check back later" );
        _;
    }
    function requestToken (address _addr) public payable hadEnoughBalance returns (string memory){
        // User[msg.sender] = faucetAmount;
         User({
            _address:_addr,
            balance: Account[_addr].balance += faucetAmount,
            lastRequestTime:block.timestamp
        });
        // owner(this.balance)-=faucetAmount;
        payable(_addr).transfer(faucetAmount);
        return "Sent, Token on its way...";
    }
}