// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {FundMe} from "../src/FundMe.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        //fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundme = deployFundMe.run();
        console.log(msg.sender);
        //0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
        console.log(address(this));
        // 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496

        vm.deal(USER, STARTING_BALANCE);
    }

    // function testMinimumDollarisFive() public {
    //     assertEq(fundme.MINIMUM_USD(), 5e18);
    // }

    // function testOwnerIsMsgSender() public {
    //     assertEq(fundme.i_owner(), msg.sender);
    // }

    function testVersion() public {
        assertEq(fundme.getVersion(), 4);
    }

    // ! The test below may pass because of the vm.expectRevert() func
    function testFundFailsWithoutEnoughEth() public {
        // On the next line after this command, should revert
        vm.expectRevert();
        // assert(this tx fails/reverts)

        fundme.fund{value: 0 ether}();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        // The next tx would be sent by USER
        fundme.fund{value: SEND_VALUE}();

        uint256 amountFunded = fundme.getAddressToAmountFunded(USER);

        assertEq(amountFunded, SEND_VALUE);
    }
}
