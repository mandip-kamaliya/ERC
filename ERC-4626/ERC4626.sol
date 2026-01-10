// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract MyERC20{
    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public totalSupply;

    mapping (address=>uint256) public balanceOf;
    mapping (address => mapping(address=>uint256)) public allowance;

    event Transfer(address indexed _to , uint256 _amount);

    constructor(string memory n,string memory s,uint8 d){
        name=n;
        symbol=s;
        decimals=d;
    }
    function _transfer(address _to , uint256 _amount) internal {
         require(_to != address(0),"receiver address is empty");
         require(_amount <= balanceOf[msg.sender],"not enough balance");
         balanceOf[msg.sender]-=_amount;
         balanceOf[_to] += _amount;
         emit Transfer(_to , _amount);

    }

}