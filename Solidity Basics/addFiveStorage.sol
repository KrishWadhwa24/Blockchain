// SPDX-License_Identifier: MIT

pragma solidity ^0.8.24;

import {SimpleStorage} from "./simplestorage.sol";

contract AddFiveStorage is SimpleStorage{

    
    // function sayHello() public pure returns (string memory)
    // {
    //     return "Hello World";
    // }

    //Change function from simple Storage to add 5 while storing

    function store(uint256 _newNumber) public override{
        num = _newNumber + 5;
    } 
}