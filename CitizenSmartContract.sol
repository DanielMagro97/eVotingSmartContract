pragma solidity ^0.4.2;

contract Citizen{
    address id;
    string name;
    string surname;
    string addressLine1;
    string addressLine2;
    string locality;
    string nationality;
    uint dateOfBirth;
 
    function Citizen(string _name, 
                     string _surname, 
                     string _addressLine1,
                     string _addressLine2,
                     string _locality,
                     string _nationality,
                     uint _dateOfBirth){
    
        id = this;
        name = _name;
        surname = _surname;
        addressLine1 = _addressLine1;
        addressLine2 = _addressLine2;
        locality = _locality;
        nationality = _nationality;
        dateOfBirth = _dateOfBirth;
    }
    
    /** Edits the record by specifying the data and the field to edit.
     * 
     *  @param data The new data for the field
     *  @param field The field to be edited
     */
    function editRecord(string data, string field){
        if (stringEquals(field, "name")) {
            name = data;
        } else if (stringEquals(field, "surname")) {
            surname = data;
        } else if (stringEquals(field, "addressLine1")) {
            addressLine1 = data;
        } else if (stringEquals(field, "addressLine2")) {
            addressLine2 = data;
        } else if (stringEquals(field, "locality")) {
            locality = data;
        } else if (stringEquals(field, "nationality")) {
            nationality = data;
        } else {
            throw;
        }
    }
    
    function getRecord() returns (address, string, string, string, string, string, string, uint){
        return (id, name, surname, addressLine1, addressLine2, locality, nationality, dateOfBirth);
    }
    
    function stringEquals(string str1, string str2) returns (bool){
        if(bytes(str1).length == bytes(str2).length){
            for(uint i = 0; i < bytes(str1).length; i++){
                if(bytes(str1)[i] != bytes(str2)[i]){
                    return false;
                }
            }
            return true;
        }
        return false;
    }
}