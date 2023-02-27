#lang forge/bsl

//DEFINITIONS
abstract sig State {
    numbers: one NumberStack,  //four numbers
    operators: one OperatorStack, //three operators unsolved state, the operators are None
    total: one NumberValue //total value int
}

one sig UnsolvedState, SolvedState extends State{}


sig OperatorStack{
    op1 : lone Operator,
    op2: lone Operator,
    op3: lone Operator
}

//Sig to represent numbers greater than 7
sig NumberValue{
    eights: one Int,
    remainder: one Int
}

//Limited operators to either subtraction or addition
abstract sig Operator{}
one sig Addition extends Operator{}
one sig Subtraction extends Operator{}
//one sig Multiply,Divide extends Operator{}

//4 numbers within the stack
sig NumberStack{
    num1 : one NumberValue, 
    num2 : one NumberValue,
    num3 : one NumberValue,
    num4 : one NumberValue
}


//---------CHECKING VALID NUMBERVALUES ARE AND IN RANGE-------------//

//checks that the NumberValue should be between 1- 10
pred inRangeTen(num:NumberValue) {
    (num.eights = 1 and num.remainder >= 0 and num.remainder <= 2) 
    or (num.eights = 0 and num.remainder > 0) 
}


//Adds two NumberValues together. Increases the result.eight by 1, if remainder sum > 7
pred addHelper[current:NumberValue, new_num:NumberValue, result:NumberValue] {
    (add[current.remainder,new_num.remainder] < current.remainder) implies {
        result.eights = add[add[current.eights,new_num.eights],1]
        result.remainder = add[add[current.remainder, new_num.remainder], -8]
    } else{
        result.remainder = add[current.remainder,new_num.remainder]
        result.eights = add[current.eights,new_num.eights]
    }
}

//Subtracts two NumberValues together. Subtracts 1 from the eights, if the difference greater than the start
pred subtractHelper[current:NumberValue, new_num:NumberValue, result:NumberValue] {
    ((subtract[current.remainder,new_num.remainder] < 0) or (subtract[current.remainder,new_num.remainder] > current.remainder)) implies {
        result.eights = subtract[subtract[current.eights,new_num.eights],1]
        result.remainder = add[add[subtract[current.remainder, new_num.remainder], 7], 1]
    } else {
        result.eights = subtract[current.eights,new_num.eights]
        result.remainder = subtract[current.remainder, new_num.remainder]
    }
}

//TODO: Multiplication -- need to figure out how to carry over from remainder to eights if necessary
// 7 * 7 = 7 + 7 + 7 + 7 + --> 49 --> NumberValue(eights = 6, remainder = 1)


//TODO: Divide -- need to keep in mind if it an actual divisble
//


//-------------------------IGNORE BELOW------------//
/*
pred multiplyHelper[current:NumberValue, new_num:NumberValue, result:NumberValue] {
    result.remainder = multiply[current.remainder, new_num.remainder]
}


fun multiplyHelper2(current:NumberValue, new_num:NumberValue): NumberValue {
    let new_total = NumberValue {
        new_num <= 0 => new_total else multiplyHelper2[addHelperTwo[current,new_num], subtract[new_num, 1]]
    }
}


fun addHelperTwo(current:NumberValue, new_num:NumberValue): NumberValue {
    let result = NumberValue {
        add[current.remainder,new_num.remainder] < current.remainder
        => {
            result.eights = add[add[current.eights,new_num.eights],1]
            result.remainder = add[add[current.remainder, new_num.remainder], -8]
            result
            }
        else {
            result.remainder = add[current.remainder,new_num.remainder]
            result.eights = add[current.eights,new_num.eights]
            result
        }
    }
}
*/


//-----------------------------------------IGNORE ABOVE-----------------//


pred calculateValue[num1,num2,result:NumberValue,op:Operator] {
    (op = Addition) implies {
        addHelper[num1,num2,result]
    } else{
        subtractHelper[num1,num2,result]
    }
}

//Check if the four numbers given actually has a solution to produce 24
pred ValidNumberSet[num1,num2,num3,num4,total:NumberValue,o1,o2,o3:Operator] {
    some result1,result2,result3:NumberValue | {
        //calculates the results using the number and operators provided
        calculateValue[num1,num2,result1,o1]
        calculateValue[result1,num3,result2,o2]
        calculateValue[result2,num4,result3,o3]

        //end result should equal 24 and set total = 24
        result3.eights = 3
        result3.remainder = 0
        total = result3
    }
    
}


//inital state
pred initState[u: UnsolvedState, n1,n2,n3,n4,t: NumberValue, o:OperatorStack, o1,o2,o3:Operators] {
    //TODO: UNcomment this when finished testing valid24 numbers
    // some num: NumberValue {
    //     num.eights = subtract[-8, 8]
    //     num.remainder = 0
    //     u.total = num
    // }
    
    //makes sure that the numbers given numbers are from 1 - 10 
    inRangeTen[n1]
    inRangeTen[n2]
    inRangeTen[n3]
    inRangeTen[n4]

    //TODO: Insert Predicate to Check Number Validity to 24
    ValidNumberSet[n1,n2,n3,n4,t,o1,o2,o3]

    //sets the numstack value to that
    u.numbers.num1 = n1
    u.numbers.num2 = n2
    u.numbers.num3 = n3
    u.numbers.num4 = n4
    u.total = t

    o.op1 = o1
    o.op2 = o2
    o.op3 = o3

    //Uncomment this when finished testing that the operators go to 24
    //operators are None
    // some o: OperatorStack {
    //     u.operators = o
    //     o.op1 = o1
    //     o.op2 = o2
    //     o.op3 = o3
    // }
}

pred finalState[s: SolvedState] {
    //assume numbers are from initState by using the Transition predicate
    //operators need to be in the correct position so that it totals to 24. We will use 18 temporarily
    // some o: OperatorStack, o1,o2,o3:Operator {
}

pred Transition[u:UnsolvedState, s:SolvedState] {
    //check to see if all the numbers are the same (don't have to be the same order though)
    //solved state has operators
    //solved state has no next
    //solved state has operators that ensure that it produces 24 -- need to call another predicate 
}


pred TransitionStates {
    // TODO: Fill me in!
    some init:UnsolvedState, final: SolvedState {
        some disj num1,num2,num3,num4:NumberValue {
            some t:NumberValue, o:OperatorStack, op1,op2,op3: Operator{
                 -- constrains on the initial state
            initState[init,num1,num2,num3,num4,t,o,op1,op2,op3]
            -- constraints on the final state
            // finalState[final]
            -- all of the transitions between initial to final state are valid
            // canTransition[init, final]
            }
       
        }
    }
}

run {
//   allNumbersInRange
  TransitionStates 
  } for 2 State, 1 OperatorStack, 1 NumberStack, 6 NumberValue