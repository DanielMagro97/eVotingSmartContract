pragma solidity ^0.4.0;
contract eVoting{
    struct peopleVoted{
        address voterID;
        bool voted;
    }
    struct candidateVotes{
        address candidateID;
        uint numberOfVotes;
    }
    
    // An arbitrary voterID is generated for each voter and randomly assigned,
    // so that a person's vote cannot be traced to a particular/specific person
    peopleVoted[] voters;
    
    // This is a map that stores the number of number n votes the nominee would
    // have obtained during the election. This is done by mapping the nominee
    // with an array of x elements, where n = [1, x] and x is the number of
    // choices a vother has
    candidateVotes[] votes;
    
    // Stores the quota of votes needed to be elected.
    uint quota;
    
    // constructor
    function eVoting(address[] eligibleVoters, address[] candidates, uint p_quota){
        uint i;
        voters.length = eligibleVoters.length;
        for(i=0; i<voters.length; i++){
            voters[i].voterID = eligibleVoters[i];
            voters[i].voted = false;
        }
        votes.length = candidates.length;
        for(i=0; i<voters.length; i++){
            votes[i].candidateID = candidates[i];
            votes[i].numberOfVotes = 0;
        }
        quota = p_quota;
    }
    
    function vote(address voterID, address[] choices){
        uint i;
        uint j;
        for(i=0; i<voters.length; i++){
            if(voters[i].voterID == voterID){
                voters[i].voted = false;
                break;
            }/* else{
                continue;
            } */
        }
        for(i=0; i<choices.length; i++){
            for(j=0; j<votes.length; j++){
                if(votes[j].candidateID == choices[i]){
                    votes[j].numberOfVotes++;
                    break;
                }
            }
        }
    }
    
    function chooseWinner() returns (address){
        uint i;
        uint max = votes[0].numberOfVotes;
        address winner = votes[0].candidateID;
        for(i=1; i<votes.length; i++){
            if(votes[i].numberOfVotes > max){
                max = votes[i].numberOfVotes;
                winner = votes[i].candidateID;
            }
        }
        return winner;
    }
}