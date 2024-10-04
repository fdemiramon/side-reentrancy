// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    function setUp() public {
        vault = new Vault();
        vm.deal(address(this), 10 ether);
        assertEq(address(vault).balance, 0 ether);
    }

    function test_Balance() public view {
        assertEq(address(this).balance, 10 ether);
    }

    function test_Deposit() public {
        vault.deposit{value: 1 ether}();
        assertEq(address(this).balance, 9 ether);
        assertEq(address(vault).balance, 1 ether);
    }

    function test_Withdraw() public {
        vault.deposit{value: 1 ether}();
        vault.withdraw(1 ether);
        assertEq(address(this).balance, 10 ether);
    }

    receive() external payable {}
}
