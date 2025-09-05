// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Counter {
    int256 internal number =0;

    function displayCount () public view returns (int256 ){
        return number;
    }
    modifier DisableIncreament ()  {
        if (number > 100) {
            require(number <100, "You have reached the maximum number");
        }
        _;
    }

        modifier DisableDecreament ()  {
        if (number == 0) {
            require(number >0, "You have react the barest minimum");
        }
        _;
    }

     function ResetCount () public{
        number = 0;
    }
    function Increament  () public DisableIncreament {
        number+=1;
    }
     function Decreament  () public DisableDecreament {
        number-=1;
    }
}