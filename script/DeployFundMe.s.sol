// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {FundMe} from "../src/FundMe.sol";
import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployFundMe is Script {
    FundMe fundme;

    function run() external returns (FundMe) {
        // ? Before startBroadcast ---> Not a real tx!
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // ? After startBroadcast ---> real tx!
        vm.startBroadcast();
        fundme = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();

        // They address of the DeployFundMe deploying the FundMe contract
        // 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496
        console.log(address(this));
        // returns the contact address
        return fundme;
    }
}
