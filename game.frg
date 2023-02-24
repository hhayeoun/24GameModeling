#lang forge/bsl

//DEFINITIONS
abstract sig State {
    numbers: one NumberStack,  //four numbers
    operators: one OperatorStack, //three operators unsolved state, the operators are None
    total: one Int //total value int    
}

sig UnsolvedState extends State{}
sig SolvedState extends State{}


sig OperatorStack{
    op1 : lone Operator,
    op2: lone Operator,
    op3: lone Operator
}


abstract sig Operator{}
sig Multiply,Divide,Subtract,Add extends Operator{}

sig NumberStack{
    num1 : one Int, 
    num2 : one Int,
    num3 : one Int,
    num4 : one Int
}


 // 1 * 2 + 3 - 4 = 3  option 1 //default  -- UnsolvedState
 // 4 * 3 + 2 - 1 = 11 option 2 //make sure that the number stack is still the same  --SolvedState


//TODO: create a predicate to check if the four numbers given actually has a solution to produce 24
    //ValidNumbers predicate
    // if it does, set 

//inital state
pred initState {

    some u: UnsolvedState | {

    

    //total = 0
    u.total = 0

    //each number in the number stacks have to be 0 - 9
    u.numbers.num1 >= 0 and u.numbers.num1 <= 7
    u.numbers.num2 >= 0 and u.numbers.num2 <= 7
    u.numbers.num3 >= 0 and u.numbers.num3 <= 7
    u.numbers.num4 >= 0 and u.numbers.num4 <= 7
    
    //each number has to be unique
    // #{row, col: Int | b.board[row][col] = X}
    // // 1 --> 2, 3, 4   2--> 3, 4     3--> 4
    // all a1, a2 | {
    //     a1 != a2
    // }


    //operators are None
    // some o : Operator | {
    //     u.operators = o
    //     o.op1 = none
    //     o.op2 = none
    //     o.op3 = none
    // }


    //nums (not sure if valid or not)
    some a1, a2, a3, a4: Int | {
    //     //TODO: NumbersValid[a1, a2, a3, a4]
    //     //u.numbers.num1 = a1
    //     //u.numbers.num2 = a2
    //     //u.numbers.num3 = a3
    //     //u.numbers.num4 = a4
        
        //temporary
        a1 = 6
        a2 = 6
        a3 = 5
        a4 = 4 //3 + 4 + 9 + 8 = 24
    }
}


    //create the SolvedState (partially solved)
    //pass the operators and the numbers
}

pred Transition[u:UnsolvedState, s:SolvedState] {
    //check to see if all the numbers are the same (don't have to be the same order though)

    //solved state has operators

    //solved state has no next

    //solved state has operators that ensure that it produces 24 -- need to call another predicate 
}






/*

1. Determine the structures for 
    - creating a valid set of four numbers such that it is possible to generate 24
    - create a valid solution using the operators that will showcase how to generate 24
2. Create


*/

// pred init[s: State, n:NumberStack] {
//     // If "randomness" exists at the beginning, state a partial or no
//     // restriction on count: let Forge decide
//         n.num1 != none && n.num1 >= 0 && n.num1 - 2 <= 7 //maximum value = 7 ; ask about later
//         n.num2 != none && n.num2 >= 0 && n.num2 <= 9 
//         n.num3 != none && n.num3 >= 0 && n.num3 <= 9 
//         n.num4 != none && n.num4 >= 0 && n.num4 <= 9
//     //generate random four numbers 
//     //check for four numbers (can be duplicates (do we need to check that?))
//     //check for valid numbers (aka int between 1-9)
// }

// pred isValidSolution {
//     //returns boolean 
// }

run {
  initState 
  }