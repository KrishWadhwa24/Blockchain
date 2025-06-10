// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; //our version

contract SimpleStorage{
    //Basic Types: boolean, uint,int,address,bytes

    // bool hasFavoriteNumber = false;
    // uint number = 98;
    uint256 public num = 88; //0 if uninitialised
    uint256[] listnum; //arrays and 0 indexed in solidity

    

    // string favnum = "Krish Wadhwa";
    
    /*
    Note:

    What is Virtual ?
    If we want the function to be overriden by any other contract, we can use virtual in the base class

    */
    function store(uint256 _favoriteNumber) public virtual {
        num = _favoriteNumber;
    }

    // view, pure cost no gas
    function retreive() public view returns(uint256) {
        return num;
    }

    //memory, storage, calldata
    //memory and calldata are both temporary variables
    //The main difference is that memory can be modified but calldata doesn't allow data to be modified

    //storage is permanent memory on blockcahin


    //2nd concept MApping

    struct Person{
        uint32 favnum;
        string name;
    }

    // Person public myFriend = Person(4,"Parnika Garg");

    /*
    Static array:
    Person[5] public friends;
    */

    //Dynamic array
    Person[] public listOfFriend;

    mapping(string => uint32) public nameTonum;

    function addPerson(string memory _name,uint32 _favnum) public {
        listOfFriend.push(Person(_favnum,_name));
        nameTonum[_name] = _favnum;
    }
}