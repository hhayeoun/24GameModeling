Overview: 
24 is an education math game with the goal of finding a way to manipulate four given numbrs 
from one to nine so that the end result is 24. In the original game of 24, we are able to use 
any four operations (+,-,/,*) to try to make 24. 

For our project, we decided to modify the game of 24 so that users are given four numbers 
from one to ten with only the (+) and (-) operations to try to make 24 given the scope of the 
project if we had attempted the original game. In addition, in the real world, there may be 
'unsolvable' cases given four numbers. However, in our project, we addressed this problem by 
generating four numbers until we can 'hand' users a deck with a solution. 

Here are the given constraints and assumptions for the model: 
- The four numbers generated must be unique (no duplicates) and within 1-10 
- Operators (+ and -) can be used more than once in a given solution 
- We have to use all four given numbers to make 24. You can't use the same number multiple times. 
- We do not need to use both Addition or Subtraction in a given solution 
- We must start with a number and end with a number 
- The order of the digits when given does not need to be preserved. 

Design Choices: 
Overview of Model Design Choices:
There are two states: the UnsolvedState and SolvedState. At a high level, the UnsolvedState is the state in which the user
is given four unique numbers 1-10 that has a solution that produces 24, but the user has to figure out the order of the numbers used and which
operators to use in a specific order to produce 24. The correct order of the numbers is unknown and the operators used
to create 24 is also unknown but within the bounds of addition and subtraction. This state is where the user has to solve the puzzle.
The SolvedState is essentially the answer key. The SolvedState shows the order of the numbers and which operators to use and at what
location to use them at to produce 24. 

We used the default customization.

Using the Steriling Visualizer, UnsolvedState is the state in which the state's numbers points to a NumberStack that contain four NumberValues.
NumberValues is our representation of numbers so that it can keep track of numbers greater than 7 and still be within Forge bit-width.
These four NumberValues should be able to produce a NumberValue that is equivalent to 24 (eights = 3 and remainder = 0) using only Addition
and Subtraction. However, the Operators used will be unknown in this state and therefore the operators will be none. The total will also be 0.

Using the Sterling Visualizer, the SolvedState is the state in which it points to a different NumberStack that contain the same four NumberValues 
from UnsolvedState. However, SolvedState has the numbers in a specific order such that num1 is the first value in the
equation, num2 is second number in the equation, etc. Operators will point to an OperatorStack that will have three specific operators that are 
either Addition or Subtraction. These operators are in a specific order such that op1 is the first operator used, op2 is the second operator used, 
and op3 is the third operator used. The equation should equal to 24 (eights = 3 and remainder = 0. 
The total should also equal 24 (eights = 3 and remainder = 0).



Sigs: 
UnsolvedState & SolvedState: 
We have two sigs which extends from an abstract sig, State. Both states have a stack with four 
numbers between 1-10, a lone stack of three operators, and a total that will hold the value 
that you will get after manipulating the stack of numbers with the stack of operators. The UnsolvedState
instance is passed into Predicate initState and the SolvedState sig gets passed into Predicate finalState. 
We have two states because the three characteristics mentioned above differ depending on whether it is unsolved
or solved. 

Operator & OperatorStack: 
We have two sigs (Addition & Subtraction) which extends from an abstract sig Operator. These two 
sigs represent the two possible operators that can be used to solve for 24. The OperatorStack 
represents a possible combination of Addition & Subtraction that can be used to manipulate the given 
four numbers. 

NumberValue & NumberStack: 
A NumberValue sig is used to represent numbers within this model. Given that Forge has a bounds for 
its bits, we decided to model numbers larger than seven by having a multiple of eight and remainder. 
Eights represents the number of eights that are in a given number and remainder would be the Number
left from the given number divided by eight. In a mathematical expression, given X, eights is X // 8 and remainder is 
X mod 8. The numberstack holds four possible number values that is between 1-10. 

Preds: 
inRangeTen: 
This pred is what is being used to ensure that the four given numbers is between 1-10. 

addHelper: 
This pred is how we are modeling the 'add' functionality as we cannot use the given Forge one
due to bit constraints. We used an 'if/else' condition in the pred to address for changes in bit-width. 
For cases when we add the remainder of the two numbers and it is less than the current remainder, this means that
the remainder has a value greater than 7 has circled back in bit-width. For example, 8 becomes -8, 9 becomes -7, etc.
Therefore, we will add one to the total eights of the two values. Then we add -8 to the total of the two numbers 
remainder for the new value. We will also add the eights of the two values together.
In the case where the sum of the two remainder values is not less than the current remainder, we just sum both the 
eights and remainders together because there will be no overflow of bit-width.

subtractHelper: 
This pred is how we are modeling the 'subtract' functionality as we cannot use the given Forge one
due to bit constraints. The same reasoning for the 'addHelper' can be applied here. If we subtract two numbers 
and the total is less than zero or if after subtracting the value, it is greater than the first number, 
the updated result's eights will be the total of the two numbers subtraction minus one. We do this so that
the remainders will still be positive and is taking account of when the difference is less than -8. 
The remainder will the the total of the two numbers remainder plus seven and then plus one on that value.
In the else case, we just subtract new_num's eights from current's eights and then subtract new_num's
remainder from current's remainder. 

calculateValue: 
This pred takes in two values and an operator. If the operator is addition, it calls 'addHelper,' and otherwise 
subtractHelper is called. 

ValidNumberSet: 
This pred checks if the four numbers generated can create 24. Four numbers and three operators are passed 
in and then we call calculateValue to perform the manipulations necessary with the numbers and operators. 
We will check that the value at the end of these manipulations result in a value 
with eights as 3 and the remainder as 0. This is equalivent to 24.

initState: 
This pred takes in an UnsolvedState instance and sets the total of the state as zero and ensures there 
are is no operator stack in the state, ensuring that there are no operators. In addition, it goes through
the four numbers in the stack to ensure the values are between 1-10, and is a valid numberset to can 
produce 24. If the numbers cannot make 24, we keep generating four numbers until we get a deck with a 
valid solution. 

finalState: 
This pred takes in a SolvedState instance and sets the total of this state to 24 and ensures valid operators 
are set to make the total 24 with the given four numbers. The ValidNumberSet pred is called within this pred 
to make sure we are working with the valid numbers and set of operators with the correct order of the operators. 

Transition: 
This pred compares the two states to make sure they have the same four numbers. We make sure that the order of the number 
stacks are different but consist of the same numbervalues. 


Run Statement: 
We are running the pred TransitionStates (with the correct order for how our preds should be called) for two states (unsolved & solved), 
two operator & number stack for both states and 7 numbervalues (four original values, 3 values from the manipulation of each value with each other, and one total value)

