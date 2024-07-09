// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Homework1{
    // Создать переменные (uint, address, bool)
    uint public number;
    address public owner;
    bool public isSigned;

    // Создать константу и immutable
    uint public constant YEAR = 2024;
    address public immutable FIRSTOWNER;

    // Создать маппинг
    mapping(address => uint) public balances;

    // Создать массив с динамической длиной
    address[] public interacted;

    // Создать 2 модификатора: на проверку владельца и проверку нулевого адреса
    modifier isOwner(){
        require(msg.sender == owner, "You are not an owner");
        _;
    }

    modifier IsZero(){
        require(msg.sender != address(0), "Address is zero");
        _;
    }

    // Создать вложенный мэппинг (nested mapping);
    mapping(address => mapping(uint => uint)) public transactionsValue;

    // Создать мэппинг со структурой;
    struct LastTransaction{
        address from;
        address to;
        uint value;
    }
    mapping(address => LastTransaction) public lastTransaction;

    // Создать структуру, в которой будет другая структура;
    struct AddressInfo{
        LastTransaction transaction;
        string nickname;
    }

    // Создать массив структур;
    AddressInfo[] public addressData;

    // Изменение адреса владельца контракта с проверкой на нулевой адрес;
    function changeOwner(address _newOwner) public IsZero{
        owner = _newOwner;
    }

    // Которая будет устанавливать immutable в конструкторе;
    constructor(){
        owner = msg.sender;
        FIRSTOWNER = msg.sender;
    }

    // Которая будет добавлять значение в динамический массив;
    function addAddress(address _interacted) public{
        interacted.push(_interacted);
    }

    // Которая будет удалять значение из массива с уменьшением его длины;
    function deleteElem(uint _id) public{
        require(_id < interacted.length, "Incorrect id");
        interacted[_id] = interacted[interacted.length-1];
        interacted.pop();
    }

    // Которая будет добавлять значение во вложенном мэппинге;
    function addNestedMapping(address _address, uint _id, uint _value) public{
        transactionsValue[_address][_id] = _value;
    }

    // Которая будет удалять значение во вложенном мэппинге;
    function deleteNestedMapping(address _address, uint _id) public{
        transactionsValue[_address][_id] = 0;
    }

    // Которая будет добавлять значения struct в мэппинге;
    function addLastTransaction(address _from, address _to, uint _value) public{
        lastTransaction[_from] = LastTransaction({
            from: _from,
            to: _to,
            value: _value
        });
    }

    // Которая будет добавлять значение в массив структур;
    function addAddressData(LastTransaction memory _lastTransaction, string memory _nickname) public{
        addressData.push(AddressInfo({
            transaction: _lastTransaction,
            nickname: _nickname
        }));
    }

    // Которая будет добавлять в простой маппинг запись, что пользователю пришел эфир;
    function receivedEth(address _address, uint _value) public{
        balances[_address] += _value;
    }
}
