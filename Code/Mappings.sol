// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// 1: Add Member
// Members Mapping
// 1.	Create a public mapping called members which maps an address to a bool. The bool will indicate whether or not the address is currently a member!
// 2.	Create an external function called addMember which takes an address and adds it as a member. You can do this by storing true in the data location



contract Contract {
    // Public mapping to track if an address is a member
    mapping(address => bool) public members;

    // External function to add an address as a member
    function addMember(address _member) external {
        members[_member] = true;
    }
}


// 2: Is Member
// Is Member
// Create an external, view function called isMember which takes an address and returns a bool indicating whether or not the address is a member.



contract Contract1 {
    // Public mapping to track if an address is a member
    mapping(address => bool) public members;

    // External function to add an address as a member
    function addMember(address _member) external {
        members[_member] = true;
    }

    // External view function to check if an address is a member
    function isMember(address _addr) external view returns (bool) {
        return members[_addr];
    }
}

// 3: Remove Member
// Remove Member
// Create an external function called removeMember that will take an address and set its corresponding value in the members mapping to false.



contract Contract2 {
    // Public mapping to track if an address is a member
    mapping(address => bool) public members;

    // External function to add an address as a member
    function addMember(address _member) external {
        members[_member] = true;
    }

    // External view function to check if an address is a member
    function isMember(address _addr) external view returns (bool) {
        return members[_addr];
    }

    // External function to remove an address as a member
    function removeMember(address _member) external {
        members[_member] = false;
    }
}


// 4: Map Structs
// User Mapping Tokens
// Let's create a new token where every new user will receive 100 tokens!
// 1.	Create a public mapping called users that will map an address to a User struct.
// 2.	Create an external function called createUser. This function should create a new user and associate it to the msg.sender address in the users mapping.
// 3.	The balance of the new user should be set to 100 and the isActive boolean should be set to true.



contract Contract3 {
    // Define the User struct
    struct User {
        uint balance;
        bool isActive;
    }

    // Public mapping from address to User
    mapping(address => User) public users;

    // Function to create a new user
    function createUser() external {
        // Revert if the user already exists (is active)
        require(!users[msg.sender].isActive, "User already exists");

        // Create a new user with 100 tokens and set isActive to true
        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }
}


// 5: Map Structs 2
// Transfer Amount
// 1.	Create an external function called transfer which takes two parameters: an address for the recipient and a uint for the amount.
// 2.	In this function, transfer the amount specified from the balance of the msg.sender to the balance of the recipient address.



contract Contract4 {
    // Define the User struct
    struct User {
        uint balance;
        bool isActive;
    }

    // Public mapping from address to User
    mapping(address => User) public users;

    // Function to create a new user
    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    // Function to transfer tokens from msg.sender to another user
    function transfer(address _to, uint _amount) external {
        // Ensure both sender and recipient are active users
        require(users[msg.sender].isActive, "Sender is not an active user");
        require(users[_to].isActive, "Recipient is not an active user");

        // Ensure sender has enough balance
        require(users[msg.sender].balance >= _amount, "Insufficient balance");

        // Perform the transfer
        users[msg.sender].balance -= _amount;
        users[_to].balance += _amount;
    }
}

// 6: Nested Maps
// Make Connections
// 1.	Create a public mapping called connections which will map an address to a mapping of an address to a ConnectionTypes enum value.
// 2.	In theconnectWith function, create a connection from the msg.sender to the other address.



contract Contract5 {
    // Enum to define connection types
    enum ConnectionTypes { 
        Unacquainted,
        Friend,
        Family
    }

    // Public nested mapping from address => address => ConnectionTypes
    mapping(address => mapping(address => ConnectionTypes)) public connections;

    // Function to set a connection from msg.sender to another address
    function connectWith(address other, ConnectionTypes connectionType) external {
        connections[msg.sender][other] = connectionType;
    }
}



