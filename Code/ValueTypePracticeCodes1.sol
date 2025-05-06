// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1: Booleans

// Add two boolean variables
// 1.	Create two public boolean storage variables on the contract: a and b.
// 2.	Store true in the variable a and false in the value b.




contract Contract {
   
     bool public a = true;
    bool public b = false;
}

// 2: Unsigned Integers

// Create Unsigned Integers!
// Let's create three public storage unsigned integers in our Contract: a, b, and sum.
// 1.	Define the variable a as an uint8 with an initial value between 0 and 255.
// 2.	Define the variable b as an uint16 with a value of at least 256.
// 3.	The variable sum should be a uint256 with the sum of the values stored in a and b.



contract Contract1 {
    uint8 public a = 100;
    uint16 public b = 500;
    uint256 public sum = uint256(a) + uint256(b);
}

// 3.Signed Integers

// 1.	Create three public storage integers a, b, and difference.
// 2.	Declare the variables a and b as int8. One of the values must be positive, the other must be negative.
// 3.	Declare the variable difference as a int16 which is the absolute difference between a and b.

contract Contract2 {
     int8 public a = 30;
    int8 public b = -10;
     int16 public difference = a >= b ? int16(a - b) : int16(b - a);
}

// 4.String Literals
// Hello World 
// It's time to do Hello World in Solidity! 
// 1.	Create a public bytes32 storage variable msg1 which stores a string literal "Hello World".
// 2.	Create a public string storage variable msg2 which stores a string literal that requires over 32 bytes to store.


contract Contract4 {
    bytes32 public msg1 = "Hello World";
    string public msg2 = "This is a longer message that exceeds thirty-two bytes.";
}

// 5.Enum
// Make Some Food!
// In the enum provided you'll see there are four types of Foods 

// Take the values and store them in food1, food2, food3, and food4


contract Contract5 {
    enum Foods { Apple, Pizza, Bagel, Banana }

	Foods public food1 = Foods.Apple ;
	Foods public food2 = Foods.Pizza ;
	Foods public food3 = Foods.Bagel;
	Foods public food4 = Foods.Banana;
}

