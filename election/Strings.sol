pragma solidity ^0.4.20;

library Strings {
    
    function concat(string baseString, string value) internal returns (string){
        
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
        
        for(i = 0 ; i < baseStringBytes.length ; i ++){
            
            // copy baseStringBytes index value into resultString index
            resultString[j] = baseStringBytes[i];
            j++;
        }
        
        for(i = 0 ; i < valueBytes.length ; i ++){
            
            // copy valueBytes index value into resultString index
            resultString[j] = valueBytes[i];
            j++;
        }
        
        return string(resultString);
    }
    
    function isEmpty(string baseString) internal returns (bool){
        bytes memory baseStringBytes = bytes(baseString);
        return baseStringBytes.length == 0;
    }
    
}

