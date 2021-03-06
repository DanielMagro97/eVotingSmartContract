pragma solidity ^0.4.2;
contract Boarding{
    
    mapping (address=>uint) private cardbalance;

    address public transportMalta; //State variable of type address
    uint private rateStudent; //Rates vary from one another
    uint private rateAdult; //Rates are state variables of unsigned integer datatype
    uint private rateElderly;
    uint private rateChild;
    uint private rateGozo;

    event Paid(address customer, uint cost);
 
    function Boarding(uint Student, uint Adult, uint Elderly, uint Child, uint Gozitan) //Constructor to initialize state variables.
    {
        transportMalta = msg.sender; //Sets transportMalta address to the address from where the (external) function call came from.
	    rateStudent = Student;
    	rateAdult = Adult;
    	rateElderly = Elderly;
    	rateChild = Child;
    	rateGozo = Gozitan;
    }
    
    
    function setRate(uint Student, uint Adult, uint Elderly, uint Child, uint Gozitan) returns(bool) 
	{
        
		if (transportMalta==msg.sender) //Only transport malta can modify the rates
		{
            	rateStudent = Student;
    			rateAdult = Adult;
    			rateElderly = Elderly;
    			rateChild = Child;
    			rateGozo = Gozitan;	
            		return true;
		}
		
		else
		{
			return false;
		}
    }
    
    function getRate(string memory cardtype) returns(uint) 
    {
        if(stringsEqual(cardtype, "Student"))
	return (rateStudent);
	
	else if(stringsEqual(cardtype, "Adult"))
	return (rateAdult);
	
	else if(stringsEqual(cardtype, "Elderly"))
	return (rateElderly);

	else if(stringsEqual(cardtype, "Child"))
	return (rateChild);

	else
	return (rateGozo);
    }

    function transaction(string memory cardtype) returns(bool) 
    {
    address receiver = transportMalta; //By default the address of the receiver is that of transport malta.
	uint amount = getRate(cardtype);

	if(msg.sender != transportMalta)
	{
		if (cardbalance[msg.sender] < amount)
		{ 
			return false;
		}
        
	cardbalance[msg.sender] -= amount;
        cardbalance[receiver] += amount;
        Paid(msg.sender, amount); //Logs transaction of boarding
    	}
	
	else
	{
		return false;
	}
    }
    
    function stringsEqual(string memory a, string memory b) internal returns (bool) 
    {
		bytes memory _a = bytes(a);
		bytes memory  _b = bytes(b);
		if (_a.length != _b.length)
			return false;
		
		for (uint i = 0; i< _a.length; i ++)
			if (_a[i] != _b[i])
				return false;
		return true;
	}
}