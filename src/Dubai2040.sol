// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract Dubai2040 is ERC20 {

    constructor ( ) ERC20("Dubai2040", "@DXB2040") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Mint 1 million tokens to the deployer
    }
}