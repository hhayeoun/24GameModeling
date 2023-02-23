#lang forge/bsl

sig State {
    next: lone State, -- every state has at most one next state       
    totalValue: one Int --curr total sum
    // numbers: one NumberStack
}

// sig Operator{

// }
abstract sig Number{
    num : one Int 
}

one sig A extends Number{}
one sig B extends Number {}
one sig C extends Number{}
one sig D extends Number{}

// sig NumberStack{
//     num1 : lone A, 
//     num2 : lone B,
//     num3 : lone C,
//     num4 : lone D
// }

pred init[s: State] {
    // If "randomness" exists at the beginning, state a partial or no
    // restriction on count: let Forge decide
        // n1.num != none && n1.num >= 0 && n1.num <= 9 
        // n2.num != none && n2.num >= 0 && n2.num<= 9 
        // n3.num != none && n3.num>= 0 && n3.num <= 9 
        // n4.num != none && n4.num >= 0 && n4.num <= 9

        all n:Number{
             n.num >= 0 && n.num <=9
        }

        s.totalValue = 0 //game has not started yet 


        s.next != none // cannot end here as game must start 
    //generate random four numbers 
    //check for four numbers (can be duplicates (do we need to check that?))
    //check for valid numbers (aka int between 1-9)
    
}

// pred finalState[s:State]{
//     //NumberStack should not have any available numbers as it has all be used 
//     s.numbers.num1 = none && s.numbers.num2 = none && s.numbers.num3 = none && s.numbers.num4 = none 
//     //no more next numbers 
//     s.next = none 
// }

// pred isValidSolution {
//     //returns boolean 
// }