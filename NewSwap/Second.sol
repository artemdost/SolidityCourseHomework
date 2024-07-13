// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC20.sol";

/**
 * @author  .
 * @title   .
 * @dev     .
 * @notice  .
 */

contract Second is ERC20 {

    constructor(string memory name_, string memory symbol_, uint256 initialSupply) ERC20(name_, symbol_) {
        owner = msg.sender;
        Mint(initialSupply);
    }


    function Mint(uint _toMint) public isOwner(){
        _totalSupply += _toMint;
        _balances[owner] += _toMint;
    } 
}
