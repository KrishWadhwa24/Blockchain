//Get fund from users
// Able to withdra funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

*/

//To shorten the above interface

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConverter {
    function getPrice() internal view returns(uint256){
        //Address : 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF //zksync sepolia testnet

        //ABI : 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (,int256 price,,,)=priceFeed.latestRoundData();
        //price of eth in terms of usd

        return (uint256)(price*1e10);
    }

    function priceConverter(uint256 ethamount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice*ethamount)/1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256)
    {
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
}

//To reduce the gas price of deploying a contract
//we will use 2 keywords constant and immutable

//Further to save gas, we can create custom errors and call them once revert

error NotOwner();
error CallFailed();

contract FundMe {
    using PriceConverter for uint256;
    uint256 public myValue = 1;

    uint256 public constant miniUSD = 5e18;

    address[] public funders;
    mapping(address => uint256) public AddressToAmount;

    address public immutable i_owner;

    //immutable let you call the variable and change it value only once

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //Allow users to send $
        //Have a minimum Dollar sent as 5$

        myValue += 2; //This action will be reverted if the require turns false, but gas will be still spent
        //What is Revert ?
        // Undo any actions that have been done and send the remaining back

        // msg.value.priceConverter();
        require(
            msg.value.priceConverter() >= miniUSD,
            "Didn't send enough eth"
        );
        funders.push(msg.sender);
        AddressToAmount[msg.sender] = AddressToAmount[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
        // for loop

        for (uint256 funder = 0; funder < funders.length; funder++) {
            address index = funders[funder];
            AddressToAmount[index] = 0;
        }

        funders = new address[](0);
        //withdraw the funds

        /*

        //transfer
        //msg.sender = address
        //payable(msg.sender) = payable address
        payable(msg.sender).transfer(address(this).balance);

        //send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");

        */

        
        //call

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        if (callSuccess != true) {
            revert CallFailed();
        }
    }

    //Modifier
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    //What happens if someone send eth to this contract without fund function ?

    // Receive and Fallback

    receive() external payable {
    fund();
    }

    fallback() external payable { 
        fund();
    }
}
