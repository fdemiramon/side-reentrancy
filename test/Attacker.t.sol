// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import {Attacker} from "../src/Attacker.sol";

contract AttackerTest is Test {
    Vault public vault;
    Attacker public attacker;

    function setUp() public {
        vault = new Vault();
        attacker = new Attacker(address(vault));
        vm.deal(address(vault), 10 ether);
    }

    function test_attack() public {
        attacker.attack();
        assertEq(address(attacker).balance, 10 ether);
    }
}
