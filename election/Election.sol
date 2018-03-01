pragma solidity ^0.4.0;

contract Election{
    
    address public owner;
    string public name;
    mapping(address=>Voter) public voters;
    Candidate[] public candidates;
    uint auctionEnd;
    event ElectionResult(string name, uint voteCount);
    
    struct Candidate{
        
        string name;
        uint voteCount;
        
    }
    
    struct Voter{
        
        bool voted;
        uint voteIndex;
        uint weight;
        
    }
    
    function Election(string _name, uint durationInMinutes, string candidate1, string candidate2){
        
        owner = msg.sender;
        name=_name;
        auctionEnd = now + (durationInMinutes * 1 minutes);
        
        candidates.push(Candidate(candidate1,0));
        candidates.push(Candidate(candidate2,0));
        
    }
    
    function authorize(address voter){
        
        require(msg.sender == owner);
        require(!voters[voter].voted);
        
        voters[voter].weight = 1;
        
    }
    
    function vote(uint voteIndex){
        
        require(now < auctionEnd);
        require(!voters[msg.sender].voted);
        
        voters[msg.sender].voted = true;
        voters[msg.sender].voteIndex = voteIndex;
        
        candidates[voteIndex].voteCount += voters[msg.sender].weight;
        
    }
    
    function end(){
        
        require(msg.sender == owner);
        require(now >= auctionEnd);
        
        for(uint i =0; i< candidates.length; i++){
            
            ElectionResult(candidates[i].name, candidates[i].voteCount);
            
        }
        
    }
    
    
}