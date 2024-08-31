// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// Importing ERC20 implementation from OpenZeppelin




contract MyToken is ERC20 {
    // Creating a custom token by inheriting from OpenZeppelin's ERC20
    constructor(uint x) ERC20("NameOfToken", "Symbol") {        
        _mint(msg.sender, x);       // the amount x is total circulation, and it'll be minted to the caller of the constructor
    }
}