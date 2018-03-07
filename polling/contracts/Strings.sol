pragma solidity ^0.4.18;

library Strings {
    
    /* info: The constant modifier is being replaced by view and pure. With view you cannot modify the contract storage,
     but you can access the storage. With pure you cannot access the contract storage. For example contract getters are views, 
     and utility libraries that do not access conctract storage but only its parameters can be declared as pure */
    
    function concat(string baseString, string value) internal pure returns (string) {
        
        // covert base string in bytes
        bytes memory baseStringBytes = bytes(baseString);
        // conver value into bytes
        bytes memory valueBytes = bytes(value);
        
        string memory tempValue = new string(baseStringBytes.length + valueBytes.length);
        // Create a new bytes array euqals to commulative length of baseStringBytes and valueBytes
        bytes memory resultString = bytes(tempValue);
        
        // iterator for baseStringBytes and valueBytes
        uint i;
        // iterator for resultString
        uint j;
        
        for (i = 0 ; i < baseStringBytes.length ; i ++) {
            
            // copy baseStringBytes index value into resultString index
            resultString[j] = baseStringBytes[i];
            j++;
        }
        
        for (i = 0 ; i < valueBytes.length ; i ++) {
            
            // copy valueBytes index value into resultString index
            resultString[j] = valueBytes[i];
            j++;
        }
        
        return string(resultString);
    }
    
    function isEmpty(string baseString) internal pure returns (bool) {
        bytes memory baseStringBytes = bytes(baseString);
        return baseStringBytes.length == 0;
    }
    
}

