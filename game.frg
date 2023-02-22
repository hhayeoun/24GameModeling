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
    //generate random four numbers 
    //check for four numbers (can be duplicates (do we need to check that?))
    //check for valid numbers (aka int between 1-9)
}

pred isValidSolution {
    //returns boolean 
}