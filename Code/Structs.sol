// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// 1: Vote Storage
// Create a Vote
// 1.	Create a new struct called Vote that contains two properties: a Choices choice and an address voter.
// 2.	Then create a public storage variable called vote which is of the Vote type.
// 3.	Finally, in the createVote function create a new instance of Vote and store it in the storage variable vote. Use the choice passed in as an argument and the msg.sender for the vote properties.

contract Contract {
    // Enum to represent Yes or No choices
    enum Choices { Yes, No }

    // Struct to store vote details: choice and voter address
    struct Vote {
        Choices choice;
        address voter;
    }

    // Public state variable to store the vote
    Vote public vote;

    // External function to create a vote
    function createVote(Choices choice) external {
        // Create a new Vote and store it in the state variable
        vote = Vote(choice, msg.sender);
    }
}




// 2: Vote Memory
// Return Memory Vote
// 1.	Create an external, view function called createVote which takes Choices value as a parameter and returns an instance of type Vote.
// 2.	This function should use the Choices value and the msg.sender as the values to create the vote.



contract Contract1 {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    // External function that creates a vote and returns it in memory
    function createVote(Choices choice) external view returns (Vote memory) {
        // Create a Vote in memory and return it
        return Vote(choice, msg.sender);
    }
}

// 3: Vote Array
// Vote Array
// 1.	Create a public storage array of the Vote struct called votes.
// 2.	In the createVote function use the choice parameter and the msg.sender to create a new vote and push it onto the array of votes.


contract Contract2 {
    enum Choices { Yes, No }
    
    // Define the Vote struct
    struct Vote {
        Choices choice;
        address voter;
    }
    
    // Public storage array to store votes
    Vote[] public votes;

    // External function to create a vote and add it to the array
    function createVote(Choices choice) external {
        // Create a new Vote with the choice and msg.sender (voter's address)
        votes.push(Vote(choice, msg.sender));
    }
}


// 4: Choice Lookup
// Find Vote
// 1.	Create an external, view function hasVoted which takes an address and returns a bool indicating if the address has cast a vote or not.
// 2.	Create an external, view function findChoice which takes an address and returns a Choices value indicating the choice on the vote cast by the address. For this function there is no need to worry about the case where a vote was not cast.



contract Contract3 {
    enum Choices { Yes, No }
    
    // Define the Vote struct
    struct Vote {
        Choices choice;
        address voter;
    }
    
    // Public storage array to store votes
    Vote[] public votes;

    // External function to create a vote and add it to the array
    function createVote(Choices choice) external {
        // Create a new Vote with the choice and msg.sender (voter's address)
        votes.push(Vote(choice, msg.sender));
    }

    // External view function to check if an address has voted
    function hasVoted(address _address) external view returns (bool) {
        return findVoteByAddress(_address) != -1;
    }

    // External view function to find the choice of an address
    function findChoice(address _address) external view returns (Choices) {
        int index = findVoteByAddress(_address);
        require(index != -1, "Address has not voted");
        return votes[uint(index)].choice;
    }

    // Internal helper function to find the index of a vote by address
    function findVoteByAddress(address _address) internal view returns (int) {
        for (int i = 0; i < int(votes.length); i++) {
            if (votes[uint(i)].voter == _address) {
                return i;
            }
        }
        return -1;  // Address not found, meaning no vote was cast
    }
}

// 5: Single Vote
// Vote Once
// 1.	Each address should only be allowed to call createVote once.
// 2.	If they try again, the call should be reverted. 



contract Contract4 {
    enum Choices { Yes, No }
    
    // Define the Vote struct
    struct Vote {
        Choices choice;
        address voter;
    }
    
    // Public storage array to store votes
    Vote[] public votes;

    // External function to create a vote and add it to the array
    function createVote(Choices choice) external {
        // Ensure the address hasn't already voted
        require(findVoteByAddress(msg.sender) == -1, "Address has already voted");
        
        // Create a new Vote with the choice and msg.sender (voter's address)
        votes.push(Vote(choice, msg.sender));
    }

    // External view function to check if an address has voted
    function hasVoted(address _address) external view returns (bool) {
        return findVoteByAddress(_address) != -1;
    }

    // External view function to find the choice of an address
    function findChoice(address _address) external view returns (Choices) {
        int index = findVoteByAddress(_address);
        require(index != -1, "Address has not voted");
        return votes[uint(index)].choice;
    }

    // Internal helper function to find the index of a vote by address
    function findVoteByAddress(address _address) internal view returns (int) {
        for (int i = 0; i < int(votes.length); i++) {
            if (votes[uint(i)].voter == _address) {
                return i; // Return the index if the address has voted
            }
        }
        return -1;  // Address not found, meaning no vote was cast
    }
}

// 6: Change Vote

// Change Vote
// 1.	Create an external function called changeVote which takes a Choices argument and changes the choice on the existing vote for the msg.sender.
// 2.	If they do not have an existing vote, revert the call. 



contract Contract5 {
    enum Choices { Yes, No }
    
    // Define the Vote struct
    struct Vote {
        Choices choice;
        address voter;
    }
    
    // Public storage array to store votes
    Vote[] public votes;

    // External function to create a vote and add it to the array
    function createVote(Choices choice) external {
        // Ensure the address hasn't already voted
        require(findVoteByAddress(msg.sender) == -1, "Address has already voted");
        
        // Create a new Vote with the choice and msg.sender (voter's address)
        votes.push(Vote(choice, msg.sender));
    }

    // External function to allow users to change their vote
    function changeVote(Choices newChoice) external {
        // Ensure the address has already voted
        int index = findVoteByAddress(msg.sender);
        require(index != -1, "Address has not voted");

        // Change the existing vote to the new choice
        votes[uint(index)].choice = newChoice;
    }

    // External view function to check if an address has voted
    function hasVoted(address _address) external view returns (bool) {
        return findVoteByAddress(_address) != -1;
    }

    // External view function to find the choice of an address
    function findChoice(address _address) external view returns (Choices) {
        int index = findVoteByAddress(_address);
        require(index != -1, "Address has not voted");
        return votes[uint(index)].choice;
    }

    // Internal helper function to find the index of a vote by address
    function findVoteByAddress(address _address) internal view returns (int) {
        for (int i = 0; i < int(votes.length); i++) {
            if (votes[uint(i)].voter == _address) {
                return i; // Return the index if the address has voted
            }
        }
        return -1;  
    }
}




