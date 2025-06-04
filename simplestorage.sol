// SPDX-License-Identifier: MIT
pragma solidity 0.8.19; //our version

contract SimpleStorage{
    //Basic Types: boolean, uint,int,address,bytes

    // bool hasFavoriteNumber = false;
    // uint number = 98;
    uint256 public num = 88; //0 if uninitialised
    uint256[] listnum; //arrays and 0 indexed in solidity

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


    function addPerson(string memory _name,uint32 _favnum) public {
        listOfFriend.push(Person(_favnum,_name));
    }

    // string favnum = "Krish Wadhwa";
    function store(uint256 _favoriteNumber) public{
        num = _favoriteNumber;
    }

    // view, pure cost no gas
    function retreive() public view returns(uint256) {
        return num;
    }

}