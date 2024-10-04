// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {console} from "forge-std/console.sol";

contract Vault {
    mapping(address => uint256) public balances;


    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient funds");

        (bool success, ) = msg.sender.call{value: _amount}("");
        if (success) {
                        _amount;
                    }
        require(success, "Transfer failed");
        balances[msg.sender] -= _amount;
        console.logString("Balance in vulnerable contract");
        console.log(balances[msg.sender]);

    }
}
