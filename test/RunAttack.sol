// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
pragma abicoder v2;
import {Test, console} from "forge-std/Test.sol";
import {AttackerContract} from "../src/AttackerContract.sol";
import {VulnerableContract} from "../src/VulnerableContract.sol";

contract AttackerContractTest is Test {
    VulnerableContract public vulnerable;
    AttackerContract public attacker;

    function setUp() public {
        vulnerable = new VulnerableContract();
        attacker = new AttackerContract(address(vulnerable));
        vm.deal(address(msg.sender), 1 ether);
        vm.deal(address(vulnerable), 6 ether);
    }

    function test_Balance() public view {
        assertEq(address(msg.sender).balance, 1 ether);
        assertEq(address(vulnerable).balance, 6 ether);
    }

    function test_Hack() public {
        attacker.attack{value: 1 ether}();
    }

}
