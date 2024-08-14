/**
* Написать контракт токена, в котором будут выполнены условия:
* Минт токенов пользователь может делать раз в 10 дней;
* Если токены минтятся раньше, берется комиссия в 10% от количества токенов;
* Администратор может устанавливать: период минта, допустимое количество минта, размер комиссии;
* Использовать файловый паттерн для отслеживания изменения ключевых переменных;
*/


// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, Ownable, ERC20Permit {

    event File(bytes32 what, bytes value);
    error InvalidParameter(bytes32 what);

    constructor(address initialOwner)
        ERC20("MyToken", "MTK")
        Ownable(initialOwner)
        ERC20Permit("MyToken")
    {}

    mapping(address => uint256) canMintLine;

    uint public periodMint = 10 * 24 * 60 * 60;
    uint public amountMint = 1000;
    uint public commissionMint = 10;



    function mint(address to, uint256 amount) public {
        require(amount <= amountMint, "invalid amount");
        if (block.timestamp >= canMintLine[msg.sender]){
            canMintLine[msg.sender] = block.timestamp + periodMint;
            _mint(to, amount); 
        } else {
            _mint(0xdD870fA1b7C4700F2BD7f44238821C26f7392148, amount * 100 / 1000);
            _mint(to, amount - amount * 100 / 1000);
            require(amount * 100 / 1000 + amount - amount * 100 / 1000 == amount);
        }
    }

    function file(bytes32 what, bytes calldata value) external onlyOwner {
        if (what == "periodMint") periodMint = abi.decode(value, (uint256));
        else if (what == "amountMint") amountMint = abi.decode(value, (uint256));
        else if (what == "commissionMint") commissionMint = abi.decode(value, (uint256));
        else revert InvalidParameter(what);
        emit File(what, value);
    }


    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            result := mload(add(source, 32))
        }
    }

    function toBytes(string memory source) public pure returns (bytes memory) {
        return bytes(source);
    }
}
