pragma solidity ^0.4.20;

contract Election{


    address private chairman;
    string public electionName;
    Candidate[] private candidatesList; 
    mapping(address=>Voter) private voters;
    bool isElectionOngoing;
    
    event ShowEnrolledCandidate(string candidateName);
    event ElectionResult(string name, uint voteCount);
    event Alert(string msg);
    
    
    struct Candidate{
        
        string candidateName;
        uint voteCount;
        
    }
    
    struct Voter{
        
        bool voted;
        uint voteIndex;

    }
    
    
    /**
        Owner Function constraint:
        This function will only be accessible to the Chairman
    */
    modifier restrictedAccess{
        
        // Check if current user is a chairman otherwise show error
        require(chairman == msg.sender);
        require(chairman == msg.sender);
        // to make sure require constraint is executed before execution of the function
        _; 
        
    }
    
    /**
        @dev Election constructor
        @param _electionName Name of the election
    */
    function Election(string _electionName) public{
        
        chairman = msg.sender;
        electionName = _electionName;
        
    }
    
    /**
        @dev Add a new candidate
        @param _candidateName name of the candidate

    */
    function enrollCandidate(string _candidateName) public restrictedAccess{
        
        require(!isElectionOngoing);
        
        // May need to place a check to see if candidate is already enrolled
        candidatesList.push(Candidate(_candidateName,0));
        
    }
    
    /**
        Display list of enrolled candidates. show an error message if there are no enrolled candidates
    */
    function showCandidates() public{
        
        require(candidatesList.length > 0);
        
        // TODO: create a library for concatinating strings for better presentation of candidate Listing. too bad solidity does not support that off the shelf yet :(
        for(uint i = 0 ; i < candidatesList.length ; i++){
                
            //Create an event to display candidate name
            ShowEnrolledCandidate(candidatesList[i].candidateName);

        }
        
    }
    
    /**
        @dev Initiate election if its not already
    */
    function initiateElection() public restrictedAccess{
        
        require(!isElectionOngoing);
        require(candidatesList.length > 0);
        
        isElectionOngoing = true;
        Alert("Election has been initiated.");
        
    }
    
    /**
        @dev Endelection and show results
    */
    function endElection() public restrictedAccess{
        
        require(isElectionOngoing);
        
        //TODO: Improvement case: An election has to start before it can be terminated
        isElectionOngoing = false;

        for(uint i =0; i< candidatesList.length; i++){
            
            ElectionResult(candidatesList[i].candidateName, candidatesList[i].voteCount);
            
        }
        
    }
    
    /**
        @dev Vote! Vote! Vote!
        @param voteIndex of Candiate to Vote. starting with 0
    */
    function vote(uint voteIndex) public {
        
        require(isElectionOngoing);
        require(!voters[msg.sender].voted);
        
        voters[msg.sender].voted = true;
        voters[msg.sender].voteIndex = voteIndex;
        
        candidatesList[voteIndex].voteCount ++;
        
    }
    
    
    
}