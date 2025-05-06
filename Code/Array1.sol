// 1: Fixed Sum
// Find the Sum
// 1.  Create a pure, external function sum which takes a fixed size array of five unsigned integers.
// 2.  Find the sum of the unsigned integers and return it as a uint.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract Contract {
    function sum(uint[5] memory numbers) external pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
        return total;
    }
}

// 2: Dynamic Sum
// Sum Dynamic Array
// 1.  Create a pure, external function sum which takes a dynamic size array of unsigned integers.
// 2.  Find the sum of the unsigned integers and return it as a uint.
// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.20;

contract Contract1 {
    function sum(uint[] calldata numbers) external pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
        return total;
    }
}

// 3: Filter to Storage

// Filter Even Numbers
// 1.  Create a public, dynamic sized array of unsigned integers as a state variable called evenNumbers.
// 2.  Create an external function called filterEven which takes an dynamic size array of unsigned integers as its only argument. Find all of the even numbers in this array and push them into the evenNumbers storage array.






contract Contract2 {
    uint[] public evenNumbers;

   
    function filterEven(uint[] memory numbers) external {
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers.push(numbers[i]); 
            }
        }
    }
}

// 4: Filter to Memory
// Filter Even Numbers
// 1.  Create a pure, external function called filterEven which takes an dynamic size array of unsigned integers as its only argument.
// 2.  Find all the even numbers and add them to a new array in memory. This array should contain only the even numbers.
// 3.  Return this new array.


contract Contract3 {

    // Pure external function to filter even numbers from an input array
    function filterEven(uint[] memory numbers) external pure returns (uint[] memory) {
        uint evenCount = 0;
        
        // First, count how many even numbers there are
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenCount++;
            }
        }
        
        // Create a new memory array with the size of even numbers count
        uint[] memory evenNumbers = new uint[](evenCount);
        uint index = 0;
        
        // Now, fill the evenNumbers array with the even numbers
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers[index] = numbers[i];
                index++;
            }
        }
        
        return evenNumbers;
    }
}

// 5: Stack Club 1
// Add Members 
// 1.  Create a dynamic sized array of addresses called members
// 2.  Create an external function addMember which has a single parameter: an address for a new member. Add this address to the members array.
// 3.  Create a public view function isMember that takes an address and returns a bool indicating whether the address is a member or not.



contract StackClub {
    address[] public members;

    function addMember(address newMember) external {
        members.push(newMember);
    }

    function isMember(address _address) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _address) {
                return true;
            }
        }
        return false;
    }
}
// 6: Stack Club 2
// Remove Members
// 1.  Create a constructor which will add the deployer address as the first member of the stack club.
// 2.  Create a removeLastMember function which will remove the last member added to the club.
//  Function Security
// 3.  Ensure that the removeLastMember function can only be called by an existing member
// 4.  Ensure that addMember can only be called by an existing member


contract StackClub2 {
    address[] public members;

    constructor() {
        members.push(msg.sender);
    }

    function addMember(address newMember) external {
        require(isMember(msg.sender), "Only existing members can add new members.");
        members.push(newMember);
    }

    function isMember(address _address) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _address) {
                return true;
            }
        }
        return false;
    }

    function removeLastMember() external {
        require(isMember(msg.sender), "Only existing members can remove members.");
        require(members.length > 1, "Cannot remove the last member.");
        members.pop();
    }
}