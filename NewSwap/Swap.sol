// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./Second.sol";
import "./First.sol";
import "./IERC20.sol";


contract Swap{
    First first;
    Second second;

    constructor(){
        first = First(0xA6D26090a198B63Dc29712370F2f66ACfffdaEF1);
        second = Second(0xcABA4B9660824F1D4afC888D7995A023391C9e2f);
    }

    struct OwnsTokens{ // структура, в которой указывается сколько токенов пришло от данного пользователя
        uint first;
        uint second;
    }

    mapping (address => OwnsTokens) userLiq; // тут хранится соответствующее количество токенов, которое прислано пользователем на данный контракт.

    function swap(uint _tokenId, uint256 amount) public{
        if (_tokenId == 1){
            userLiq[msg.sender].first = first.balanceOf(address(this)); // обновляем данные о состоянии баланса структуры
            require(userLiq[msg.sender].first >= amount, "User did not send enought funds to swap"); // проверяем прислал ли юзер деньги
            second.transfer(msg.sender, amount); // отправляем если все ок
        } else if (_tokenId == 2){
            userLiq[msg.sender].second = second.balanceOf(address(this));
            require(userLiq[msg.sender].second >= amount, "User did not send enought funds to swap");
            first.transfer(msg.sender, amount);
        }
    }

    function currentLiq() public returns (uint, uint){ // просто функция посмотреть баланс структур
        userLiq[msg.sender].first = first.balanceOf(address(this));
        userLiq[msg.sender].second = second.balanceOf(address(this));
        return (userLiq[msg.sender].first, userLiq[msg.sender].second);
    }
    
}
