
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// VOTING CONTRACT
// 1: Proposal

//  Proposals
// 1.	Create a public array of type Proposal and call it proposals.
// 2.	Create an external function newProposal which takes two arguments:
// o	An address argument which will be the target address of the proposal. We'll send some calldata to this address.
// o	A bytes argument which will be the calldata to eventually send to the smart contract when the proposal is executed.
// 3.	In the newProposal function create a new Proposal with the arguments passed in and the yes/no vote counts are initialized at 0.
// 4.	Add the new Proposal to the proposals array.


contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // Public array to store proposals
    Proposal[] public proposals;

    // External function to create a new proposal
    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }
}


// 2: Cast a Vote
// Cast Vote
// 1.	Create an external function castVote which takes a uint proposalId and a bool which indicates whether the vote supports the proposal (true for yes, false for no).
// 2.	For each vote cast, update the yesCount and noCount in the referenced proposal accordingly.



contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // Public array to store proposals
    Proposal[] public proposals;

    // External function to create a new proposal
    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }

    // External function to cast a vote
    function castVote(uint proposalId, bool support) external {
        // Ensure the proposalId is valid
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }
    }
}

// 3: Multiple Votes
// Vote Changing
// 1.	Modify the castVote function to allow voters to change their vote on a particular proposal.



contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // Public array to store proposals
    Proposal[] public proposals;

    // Track how each address voted on each proposal
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    // Create a new proposal
    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }

    // Allow vote casting with vote changing
    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];

        // If the user already voted
        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = voteChoice[proposalId][msg.sender];

            // Only adjust if vote has changed
            if (previousVote != support) {
                if (previousVote) {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                } else {
                    proposal.noCount -= 1;
                    proposal.yesCount += 1;
                }
                voteChoice[proposalId][msg.sender] = support;
            }
        } else {
            // First time voting
            if (support) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }
            hasVoted[proposalId][msg.sender] = true;
            voteChoice[proposalId][msg.sender] = support;
        }
    }
}

// 4: Voting Events
// Proposal Created & Vote Cast Events
// 1.	Create an event ProposalCreated which takes a single argument: a uint proposal ID. Emit this event whenever a new Proposal struct is created.
// 2.	Create an event VoteCast which takes two arguments: a uint proposal ID and an address for the voter's address. Emit this event any time a new vote is cast.



contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // Public array to store proposals
    Proposal[] public proposals;

    // Track how each address voted on each proposal
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    // === Events ===
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    // Create a new proposal
    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    // Allow vote casting with vote changing
    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];

        // If the user already voted
        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = voteChoice[proposalId][msg.sender];

            // Only adjust if vote has changed
            if (previousVote != support) {
                if (previousVote) {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                } else {
                    proposal.noCount -= 1;
                    proposal.yesCount += 1;
                }
                voteChoice[proposalId][msg.sender] = support;
                emit VoteCast(proposalId, msg.sender);
            }
        } else {
            // First time voting
            if (support) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }
            hasVoted[proposalId][msg.sender] = true;
            voteChoice[proposalId][msg.sender] = support;
            emit VoteCast(proposalId, msg.sender);
        }
    }
}

// 4: Voting Events
// Proposal Created & Vote Cast Events
// 1.	Create an event ProposalCreated which takes a single argument: a uint proposal ID. Emit this event whenever a new Proposal struct is created.
// 2.	Create an event VoteCast which takes two arguments: a uint proposal ID and an address for the voter's address. Emit this event any time a new vote is cast.


contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // Public array to store proposals
    Proposal[] public proposals;

    // Track how each address voted on each proposal
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    // === Events ===
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    // Create a new proposal
    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    // Allow vote casting with vote changing
    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = voteChoice[proposalId][msg.sender];

            // If vote changed, adjust counts
            if (previousVote != support) {
                if (previousVote) {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                } else {
                    proposal.noCount -= 1;
                    proposal.yesCount += 1;
                }
                voteChoice[proposalId][msg.sender] = support;
            }
        } else {
            // First time voting
            if (support) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }
            hasVoted[proposalId][msg.sender] = true;
            voteChoice[proposalId][msg.sender] = support;
        }

        // Always emit event
        emit VoteCast(proposalId, msg.sender);
    }
}


// 5: Members


// Members
// 1.	Create a public constructor which takes an array of address. These addresses, plus the deployer of the function, should all be allowed to create new proposals and vote on those proposals.
// 2.	If anyone else attempts to create a proposal or vote, the call should be reverted. 



contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    // List of all proposals
    Proposal[] public proposals;

    // Mapping to store whether an address is a member
    mapping(address => bool) public isMember;

    // Track how each address voted on each proposal
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    // === Events ===
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    // Constructor that takes in allowed member addresses
    constructor(address[] memory members) {
        isMember[msg.sender] = true; // Deployer is always a member

        for (uint i = 0; i < members.length; i++) {
            isMember[members[i]] = true;
        }
    }

    // Only allow members to create proposals
    function newProposal(address _target, bytes calldata _data) external {
        require(isMember[msg.sender], "Not a registered member");

        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    // Only allow members to vote
    function castVote(uint proposalId, bool support) external {
        require(isMember[msg.sender], "Not a registered member");
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = voteChoice[proposalId][msg.sender];

            if (previousVote != support) {
                if (previousVote) {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                } else {
                    proposal.noCount -= 1;
                    proposal.yesCount += 1;
                }
                voteChoice[proposalId][msg.sender] = support;
            }
        } else {
            if (support) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }
            hasVoted[proposalId][msg.sender] = true;
            voteChoice[proposalId][msg.sender] = support;
        }

        emit VoteCast(proposalId, msg.sender);
    }
}

// 6: Execute
// Execute
// Let's make our minimum voting threshold be 10 participants. Once 10 members have voted yes on a proposal, execute it.
// 1.	Update the castVote function to execute the proposal when the 10 yes votes have been registered.
// 2.	Execute the vote by sending the data to the target address using the call syntax.


contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed; 
    }

    Proposal[] public proposals;
    mapping(address => bool) public isMember;
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);
    event ProposalExecuted(uint proposalId, bool success, bytes result); // New event

    constructor(address[] memory members) {
        isMember[msg.sender] = true;
        for (uint i = 0; i < members.length; i++) {
            isMember[members[i]] = true;
        }
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(isMember[msg.sender], "Not a registered member");

        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0,
            executed: false
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        require(isMember[msg.sender], "Not a registered member");
        require(proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = voteChoice[proposalId][msg.sender];
            if (previousVote != support) {
                if (previousVote) {
                    proposal.yesCount -= 1;
                    proposal.noCount += 1;
                } else {
                    proposal.noCount -= 1;
                    proposal.yesCount += 1;
                }
                voteChoice[proposalId][msg.sender] = support;
            }
        } else {
            if (support) {
                proposal.yesCount += 1;
            } else {
                proposal.noCount += 1;
            }
            hasVoted[proposalId][msg.sender] = true;
            voteChoice[proposalId][msg.sender] = support;
        }

        emit VoteCast(proposalId, msg.sender);

        // Execute proposal if it reaches 10 yes votes
        if (proposal.yesCount >= 10 && !proposal.executed) {
            proposal.executed = true;
            (bool success, bytes memory result) = proposal.target.call(proposal.data);
            emit ProposalExecuted(proposalId, success, result);
        }
    }
}


