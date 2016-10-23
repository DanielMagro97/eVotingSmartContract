pragma solidity ^0.4.2;

contract Boarding{
    
    mapping (address=>uint) of cardbalance;

    address public transportMalta; //State variable of type address
    uint private rateStudent; //Rates vary from one another
    uint private rateAdult; //Rates are state variables of unsigned integer datatype
    uint private rateElderly;
    uint private rateChild;
    uint private rateGozo;

    event Paid(address customer, uint cost);
 
    function Citizen(uint Student, uint Adult, uint Elderly, uint Child, uint Gozitan) //Constructor to initialize state variables.
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
    
    function getRate(string cardtype) returns(uint) 
    {
        if(cardtype == "Student")
	return (rateStudent);
	
	else if(cardtype == "Adult")
	return (rateAdult);
	
	else if(cardtype == "Elderly")
	return (rateElderly);

	else if(cardtype == "Child")
	return (rateChild);

	else()
	return (rateGozo);
    }

    function transaction(uint amount, string cardtype) returns(bool) 
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
}