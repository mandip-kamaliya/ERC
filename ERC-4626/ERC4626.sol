// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract MyERC20{
    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public totalSupply;

    mapping (address=>uint256) public balanceOf;
    mapping (address => mapping(address=>uint256)) public allowance;

    event Transfer(address indexed from , address indexed _to , uint256 _amount);
    event Aproval(address indexed owner,address indexed recepient,uint256 _amount); 

    constructor(string memory n,string memory s,uint8 d){
        name=n;
        symbol=s;
        decimals=d;
    }

    function approve(address recepient,uint256 _amount) external returns(bool){
        require(_amount <= balanceOf[msg.sender],"Not Enough Balance to Approve");
        allowance[msg.sender][_recepient]=_amount;
        emit Aproval(_recepient,_amount);
        return true;
    }

    function transfer(address _recepient , uint256 _amount) external returns(bool){
        _transfer(_recepient , _amount);
        return true;
    }

    function transferFrom(address from , address to , uint256 amount) external returns(bool){
        uint256 allowed = allowance[from][msg.sender];
        if (allowed != type(uint256).max){
            allowance[from][msg.sender] = allowed - amount;
        }
        _transfer(from , to , amount);
        return true;
    }

    function _transfer(address _from ,address _to , uint256 _amount) internal {
         require(_to != address(0),"receiver address is empty");
         require(_amount <= balanceOf[_from],"not enough balance");
         balanceOf[_from]-=_amount;
         balanceOf[_to] += _amount;
         emit Transfer(_from,_to , _amount);
    }

    function _mint(address _to , uint256 _amount) internal{
        totalSupply += _amount;
        balanceOf[_to] = _amount;
        emit Transfer(address(0) , _to , _amount);
    }
    function _burn(address _from , uint256 _amount) internal{
         balanceOf[_from]-=_amount;
        totalSupply-=_amount;       
        emit Transfer(_from , address(0) , _amount);
    }
}