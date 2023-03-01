Overview: 
24 is an education math game with the goal of finding a way to manipulate four given numbrs 
from one to nine so that the end result is 24. In the original game of 24, we are able to use 
any four operations (+,-,/,*) to try to make 24. 

For our project, we decided to modify the game of 24 so that users are given four numbers 
from one to ten with only the (+) and (-) operations to try to make 24 given the scope of the 
project if we had attempted the original game. In addition, in the real world, there may be 
'unsolvable' cases given four numbers. However, in our project, we addressed this problem by 
generating four numbers until we can 'hand' users a deck with a solution. 

Design Choices: 

Sigs: 
Unsolved & SolvedState: 
We have two sigs which extends from an abstract sig, State. Both states have a stack with four 
numbers between 1-10, a stack of possible operators, and a total that will hold the value 
that you will get after manipulating the stack of numbers iwth the stack of operators. The UnsolvedState
instane is passed into Predicate initState and the SolvedState sig gets passed into Predicate finalState. 
We have two states because the three characteristics mentioned above differ depending on whether it is unsolved
or solved. 

Operator & OperatorStack: 
We have two sigs (Addition & Subtraction) which extends from an abstract sig Operator. These two 
sigs represent the two possible operators that can be used to solve for 24. The OperatorStack 
represents a possible combination of Addtion & Subtraction that can be used to manipulate the given 
four numbers. 

NumberValue & NumberStack: 
A NumberValue sig is used to represent numbers within this model. Given that Forge has a bounds for 
its bits, we decided to model numbers larger than seven by having a character of eights and remainder. 
Eights represents the number of times we can divide a given number by eight and remainder would be the Number
left from that division. The numberstack holds four possible number values that is between 1-10. 

Preds: 
inRangeTen: 
This pred is what is being used to ensure that the four given numbers is between 1-10. 

addHelper: 
This pred is how we are modeling the 'add' functionality as we cannot use the given Forge one
due to bit constraints. We used an 'if/else' condition in the pred to address for changes in bit-width. 
For cases when we add the remainder of the two numbers and it is less than the current remainder, we will 
add one to the total eights of the two values and add -8 to the total of the two numbers 
remainder for the new value. 

subtractHelper: 
This pred is how we are modeling the 'subtract' functionality as we cannot use the given Forge one
due to bit constraints. The same reasoning for the 'addHelper' can be applied here. If we subtract two numbers 
and the total is less than zero or if after subtracting the value, it is greater than the first number, 
the new result's eights will be the total of the two numbers subtraction minus one. The remainder will the 
the total of the two numbers remainder plus seven and hten plus one on that value. 

calculateValue: 
This pred takes in two values and an operator. If the operator is addition, it calls 'addHelper,' and otherwise 
subtractHelper is called. 

ValidNumberSet: 
This pred checks if the four numbers generated can create 24. Four numbers and three operators are passed 
in and then we call calculateValue to perform the manipulations necessary with the numebrs and operators. 
We will check that the value at the end of these manipulations result in a value 
with eights as 3 and the remainder as 0. 

initState: 
This pred takes in an UnsolvedState instance  and sets the total of the state as zero and ensures there 
are no operators in the state. In addition, it goes through the four numbers in the stack to ensure the values 
are between 1-10, and is a valid numberset. If the numbers cannot make 24, we keep generating four numbers 
until we get a deck with a valid solution. 

finalState: 
This pred takes in a SolvedState instance and sets the total of this state to 24 and ensures valid operators 
are set to make the total of 24 with the given four numbers. The ValidNumberSet pred is called within this pred 
to make sure we are working with the valid numbers and set of operators (with the correct order of the operators). 

Transition: 
This pred compares the two states to make sure they have the same four numbers. We make sure that the order of the number 
stacks are different but consist of the same numbervalues. 


Run Statement: 
We are running the pred TransitionStates (with the correct order for how our preds should be called) for two states (unsolved & solved), 
two operator & number stack for both states and 7 numbervalues (four original values, 3 values from the manipulation of each value with each other, and one total value)

