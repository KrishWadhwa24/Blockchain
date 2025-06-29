//SPDC-License-Identiifer: MIT

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns(uint256){
        //Address : 0x694AA1769357215DE4FAC081bf1f309aDC325306

        //ABI : 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
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
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}