#lang forge/bsl

sig State {
    next: lone State, -- every state has at most one next state       
    totalValue: one int, --curr total sum
    numbers: one NumberStack
}

sig Operator{

}

sig NumberStack{
    num1 = lone int, 
    num2 = lone int,
    num3 = lone int,
    num4 = lone int
}

pred init[s: State, n:NumberStack] {
    // If "randomness" exists at the beginning, state a partial or no
    // restriction on count: let Forge decide
        n.num1 != none && n.num1 >= 0 && n.num1 <= 9 
        n.num2 != none && n.num2 >= 0 && n.num2 <= 9 
        n.num3 != none && n.num3 >= 0 && n.num3 <= 9 
        n.num4 != none && n.num4 >= 0 && n.num4 <= 9

        totalValue = 0 //game has not started yet 
        

        s.next != none // cannot end here as game must start 
    //generate random four numbers 
    //check for four numbers (can be duplicates (do we need to check that?))
    //check for valid numbers (aka int between 1-9)
}

pred finalState[s:State]{
    //NumberStack should not have any available numbers as it has all be used 
    s.numbers.num1 = none && s.numbers.num2 = none && s.numbers.num3 = none && s.numbers.num4 = none 
    //no more next numbers 
    s.next = none 
}

pred isValidSolution {
    //returns boolean 
}