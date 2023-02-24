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

sig NumberValue{
    eights: one Int,
    remainder: one Int
}


abstract sig Operator{}
one sig Multiply,Divide,Subtract,Add extends Operator{}

sig NumberStack{
    num1 : one NumberValue, 
    num2 : one NumberValue,
    num3 : one NumberValue,
    num4 : one NumberValue
}


//---------CHECKING VALID NUMBERVALUES ARE UNIQUE AND IN RANGE-------------//

pred inRange(num:NumberValue) {
    // n.eights > 3 implies n.remainder >= 0
    (num.eights > 0 and num.eights < 3 and num.remainder >= 0) 
    or (num.eights = 3 and num.remainder = 0) 
    or (num.eights = 0 and num.remainder > 0)
}

pred differentNumValuesHelper[num1:NumberValue, num2:NumberValue] {
    not((num1.eights = num2.eights) and (num1.remainder = num2.remainder))
}

pred uniqueValues[num1:NumberValue, num2: NumberValue, num3: NumberValue, num4:NumberValue] {
    differentNumValuesHelper[num1, num2]
    differentNumValuesHelper[num1, num3]
    differentNumValuesHelper[num1, num4]
    differentNumValuesHelper[num2, num3]
    differentNumValuesHelper[num2, num4]
    differentNumValuesHelper[num3, num4]
}

pred validNumbers[num1:NumberValue, num2: NumberValue, num3: NumberValue, num4:NumberValue] {
    uniqueValues[num1, num2, num3, num4]
    inRange[num1]
    inRange[num2]
    inRange[num3]
    inRange[num4]
}


//Helper functions to calculate total
//TODO: Multiplication -- need to figure out how to carry over from remainder to eights if necessary
//TODO: Divide -- need to keep in mind if it an actual divisble
//TODO: Subtract
fun 24add(current:NumberValue, new_num:NumberValue): NumberValue {
    let output = NumberValue
    
}

fun calculate(current: Int, new_num: Int, operator : Operator): Int {
    (operator = Multiply => multiply[current, new_num] else (
        operator = Divide => divide[current, new_num] else (
            operator = Subtract => subtract[current, new_num] else (
                add[current,new_num]))))
}


//TODO: create a predicate to check if the four numbers given actually has a solution to produce 24
pred ValidNumberSet[num1,num2,num3,num4:Int] {
    //have to check if it is possible to create 24 from the numbers

    some op1,op2,op3 : Operator | {
        // let first_result = calculate[num1,num2, op1],
        // let second_result = calculate[first_result, num3, op2],
        // let third_result = calculate[second_result, num4, op2]
        // third_result = 18
        // calculate[calculate[calculate[num1,num2, op1],num3, op2],num2, op1] = 7
    }
}



//inital state
pred initState[u: UnsolvedState, n1,n2,n3,n4: NumberValue] {
    some num: NumberValue {
        num.eights = 0
        num.remainder = 0
        u.total = num
    }
    
    //makes sure that the numbers are unique and in range
    validNumbers[n1, n2, n3, n4]

    //TODO: Insert Predicate to Check Number Validity to 24
    //ValidNumberSet[a1,a2,a3,a4]

    //sets the numstack value to that
    u.numbers.num1 = n1
    u.numbers.num2 = n2
    u.numbers.num3 = n3
    u.numbers.num4 = n4

    //operators are None
    some o: OperatorStack {
        u.operators = o
        o.op1 = none
        o.op2 = none
        o.op3 = none
    }
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
        -- constrains on the initial state
        initState[init,num1,num2,num3,num4]
        -- constraints on the final state
        // finalState[final]
        -- all of the transitions between initial to final state are valid
        // canTransition[init, final]

        }
    }
}

run {
  TransitionStates 
  } for 2 State, 1 OperatorStack, 1 NumberStack, 7 NumberValue