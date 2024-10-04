// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vault {
    mapping(address => uint256) public balances;

    /**
     * @dev Deposits funds into the vault.
     */
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev Withdraws funds from the vault.
     * @param _amount The amount of funds to withdraw.
     */
    function withdraw(uint256 _amount) public {
        balances[msg.sender] -= _amount;
        (bool success,) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");
    }

    /**
     * @dev Flash loans funds from the vault.
     * @param _amount The amount of funds to flash loan.
     */
    function flashLoan(uint256 _amount) public {
        uint256 previousBalance = address(this).balance;
        (bool success,) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");
        require(previousBalance <= address(this).balance, "Flash loan failed");
    }
}
