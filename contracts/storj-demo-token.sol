pragma solidity ^0.5.1;

contract StorjDemoToken {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint8 public decimals;

    event Transfer (
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    event Approval (
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping (address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor (uint256 _initialSupply, uint8 _decimals, string memory _name, string memory _symbol) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(
            balanceOf[msg.sender] >= _value,
            "insufficient balance"
        );

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(
            _value <= balanceOf[_from],
            "nope"
        );
        require(
            _value <= allowance[_from][msg.sender],
            "nope"
        );

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}