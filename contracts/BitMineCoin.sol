pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/StandardToken.sol";

contract BitMineCoin is StandardToken{
	address public _owner;
	address public _mine_pool_locked_address;
	string public name = "BitMineCoin";
	string public symbol = "BMC";
	uint8 public decimals = 18;
	uint256 public INITIAL_SUPPLY = 21000000 * (10 ** uint256(decimals));

	function BitMineCoin() public{
		totalSupply = INITIAL_SUPPLY;
		_mine_pool_locked_address = address(100);
		_owner = msg.sender;
		//locked to an empty address, no one can control.
		balances[_mine_pool_locked_address] = INITIAL_SUPPLY-100000*(10 ** uint256(decimals)); 
		//use to reward to active players in early period.
		balances[_owner] = 100000*(10 ** uint256(decimals)); 
	}

	function transfer_internal(address _from,address _to, uint256 _value) internal returns (bool) {
	    require(_to != address(0));
	    require(_value <= balances[_from]);

	    // SafeMath.sub will throw if there is not enough balance.
	    balances[_from] = balances[_from].sub(_value);
	    balances[_to] = balances[_to].add(_value);
	    Transfer(_from, _to, _value);
	    return true;
	  }
}
