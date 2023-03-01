#lang forge/bsl

//DEFINITIONS
abstract sig State {
    numbers: one NumberStack,  //four numbers
    operators: lone OperatorStack, //three operators unsolved state, the operators are None
    total: one NumberValue //total value int
}

one sig UnsolvedState, SolvedState extends State{}


sig OperatorStack{
    op1 : one Operator,
    op2: one Operator,
    op3: one Operator
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


//VALIDITY OF NUMBERS
//checks that the NumberValue should be between 1- 10
pred inRangeTen(num:NumberValue) {
    num.eights = 1 or num.eights = 0
    num.eights = 1 implies num.remainder >= 0 and num.remainder <= 2
    num.eights = 0 implies num.remainder > 0
}


//OPERATOR HELPERS
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


//Use addHelper if Addition and subtractHelper if Subtraction
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


//TESTING STATES
//Sets the total = 0, operators = None, and makes sure that the numberstack has values that can produce 24
pred initState[u: UnsolvedState] {

    //set the total to 0
    some num: NumberValue {
        num.eights = 0
        num.remainder = 0
        u.total = num
    }

    //operators are None
    u.operators = none
    
    //Predicate to Check Number Validity to 24 and set numbers (unordered)
    some disj n1,n2,n3,n4:NumberValue {
        some t: NumberValue, o:OperatorStack, o1,o2,o3:Operator {
            //makes sure that the numbers given numbers are from 1 - 10 
            inRangeTen[n1]
            inRangeTen[n2]
            inRangeTen[n3]
            inRangeTen[n4]

            //check that they can produce 24
            ValidNumberSet[n1,n2,n3,n4,t,o1,o2,o3]

            //set the numbers to a random ordering
            some disj r1, r2, r3, r4:NumberValue {
                (r1 = n1 or r1 = n2 or r1 = n3 or r1 = n4)
                and (r2 = n1 or r2 = n2 or r2 = n3 or r2 = n4)
                and (r3 = n1 or r3 = n2 or r3 = n3 or r3 = n4)
                and (r4 = n1 or r4 = n2 or r4 = n3 or r4 = n4)

                u.numbers.num1 = r1
                u.numbers.num2 = r2
                u.numbers.num3 = r3
                u.numbers.num4 = r4
            }
        }
    }
}

//makes sure the operators are not none and that the validnumberset outputs to 24
pred finalState[s: SolvedState] {
    some disj n1,n2,n3,n4:NumberValue {
        some t: NumberValue, o:OperatorStack, o1,o2,o3:Operator {
        //makes sure that the numbers given numbers are from 1 - 10 
            ValidNumberSet[n1,n2,n3,n4,t,o1,o2,o3]
            s.numbers.num1 = n1
            s.numbers.num2 = n2
            s.numbers.num3 = n3
            s.numbers.num4 = n4
            o.op1 = o1
            o.op2 = o2
            o.op3 = o3
            s.operators = o
            s.total = t
        }
    }
}

//compares the two states to make sure that they have the same NumberValues for their stack
pred Transition[u:UnsolvedState, s:SolvedState] {
    //number stacks are different
    u.numbers != s.numbers

    //even though the number stacks are different, they consist of the same values
    some disj r1, r2, r3, r4:NumberValue {
        (r1 = u.numbers.num1  or r1 = u.numbers.num2 or r1 = u.numbers.num3 or r1 = u.numbers.num4)
        and (r2 = u.numbers.num1  or r2 = u.numbers.num2 or r2 = u.numbers.num3 or r2 = u.numbers.num4)
        and (r3 = u.numbers.num1  or r3 = u.numbers.num2 or r3 = u.numbers.num3 or r3 = u.numbers.num4)
        and (r4 = u.numbers.num1  or r4 = u.numbers.num2 or r4 = u.numbers.num3 or r4 = u.numbers.num4)

        s.numbers.num1 = r1
        s.numbers.num2 = r2
        s.numbers.num3 = r3
        s.numbers.num4 = r4
    }
}


pred TransitionStates {
    some init:UnsolvedState, final: SolvedState {
            initState[init]
            Transition[init, final]
            finalState[final]
    }
}

run {
  TransitionStates 
  } for 2 State, 2 OperatorStack, 2 NumberStack, 7 NumberValue