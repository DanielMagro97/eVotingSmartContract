pragma solidity ^0.4.0;

contract Patient{
    address ID;
    string name;
    string surname;
    string homeAddress;
    string locality;
    bytes32 nationality;
    uint dateOfBirth;
    bool entitlementHolder;
    uint availableFunds; // patient's available funds


    function Patient(string _name, 
                     string _surname, 
                     string _homeAddress,
                     string _locality,
                     bytes32 _nationality,
                     uint _dateOfBirth,
                     bool _entitlementHolder,
                     uint _availableFunds){
        ID = this;
        name = _name;
        surname = _surname;
        homeAddress = _homeAddress;
        locality = _locality;
        nationality = _nationality;
        dateOfBirth = _dateOfBirth;
        entitlementHolder = _entitlementHolder;
        availableFunds = _availableFunds;
    }
    
    /* Checks if the patient has enough funds and deducts these from their
     * avaialbe funds to receive healthcare
     *
     * @param  The amount of funds to be deducted.
     * @return The amount that was deducted.
     */
    function payForHealthCare(uint amount) returns (uint){
        if(amount - availableFunds >= 0){
            amount -= availableFunds;
            return amount;
        }else{
            return 0;
        }
    }
    
    function getID() returns (address){
        return ID;
    }
    
    function getName() returns (string){
        return name;
    }


    function getSurname() returns (string){
        return surname;
    }
    
    function getHomeAddress() returns (string){
        return homeAddress;
    }
    
    function getNationality() returns (bytes32){
        return nationality;
    }    
    
    function getDateOfBirth() returns (uint){
        return dateOfBirth;
    }
    
    function getEntitlementHolder() returns(bool){
        return entitlementHolder;
    }
    
    function getAvailableFunds() returns (uint){
        return availableFunds;
    }
    
}


contract HospitalsAndClinics{
    Patient[] patientList;
    
    // constructor
    function HospitalsAndClinics(Patient[] _patientList){
        patientList = _patientList;
    }
    
    function ServiceApproval(address inputID) returns (bool){
        uint i;
        for(i=0; i<patientList.length; i++){
            if(inputID == patientList[i].getID()){
                if(stringEquals(patientList[i].getNationality(), "Maltese") || patientList[i].getEntitlementHolder()){
                    // accept service
                    return true;
                } else{
                    /* Provide service and deduct required amount 
                     * from AvailableFunds using patient.pay(uint)
                     */
                     
                    // return true/false accordingly
                }
            }
        }
        //This block is only accessed if the patient is not in the list.
        //deny service
        return false;
    }
    
    function stringEquals(bytes32 str1, bytes32 str2) returns (bool){
        if(str1.length == str2.length){
            for(uint i = 0; i < str1.length; i++){
                if(str1[i] != str2[i]){
                    return false;
                }
            }
            return true;
        }
        return false;
    }
}