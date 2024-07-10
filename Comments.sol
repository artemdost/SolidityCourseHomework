// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Homework1{
    function _update(address from, address to, uint256 value) internal virtual { // задается функция
            if (from == address(0)) { // проверям что адрес не нуль
                // Overflow check required: The rest of the code assumes that totalSupply never overflows
                _totalSupply += value; // если нуль то минтим токены
            } else {
                uint256 fromBalance = _balances[from]; // переменная которая хранит текущий баланс откуда выводится
                if (fromBalance < value) { // если он меньше то кидает event что бабок нет
                    revert ERC20InsufficientBalance(from, fromBalance, value);
                }
                unchecked { // иначе
                    // Overflow not possible: value <= fromBalance <= totalSupply.
                    _balances[from] = fromBalance - value; // вычитаем бабло из маппинга, тк бабло убавилось
                }
            }

            if (to == address(0)) { // если адрес ноль то сжигаем токены
                unchecked {
                    // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                    _totalSupply -= value;
                }
            } else { // иначе прибавляем балик логично
                unchecked {
                    // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                    _balances[to] += value;
                }
            }

            emit Transfer(from, to, value); // евент что случился трансфер
        }

}