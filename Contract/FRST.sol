// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./myERC.sol";

/**
 * @author  .
 * @title   .
 * @dev     .
 * @notice  .
 */

contract FRST is myERC {

    address owner;
    constructor(string memory name_, string memory symbol_, uint256 initialSupply) myERC(name_, symbol_) {
        owner = msg.sender;
        Mint(initialSupply);
    }


    function Mint(uint _toMint) public isOwner(){
        _totalSupply += _toMint;
        _balances[owner] += _toMint;
        emit Transfer(address(0), owner, _toMint);
    } 
}
