// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {SimpleStorage} from "./simplestorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorage;

    function createSimpleStorage() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorage.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorage) public {
        SimpleStorage mySimple = listOfSimpleStorage[_simpleStorageIndex];
        mySimple.store(_newSimpleStorage);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage mySimpleStorage = listOfSimpleStorage[_simpleStorageIndex];
        return mySimpleStorage.retreive();
    }
}
