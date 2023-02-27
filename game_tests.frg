#lang forge/bsl
open "game.frg"

test suite for inRangeTen{
    //eight = 0 and remainder = 2 
    example twoIsInRange is {some num:NumberValue |inRangeTen[num]} for{
       NumberValue = `n1  
       eights = `n1 -> 0 
       remainder = `n1 -> 2 
    }

    example eightIsInRange is {some num: NumberValue | inRangeTen[num]} for{
        NumberValue = `n 
        eights = `n -> 1 
        remainder = `n -> 0
    }
    example ElevenIsNotInRange is not {some num: NumberValue | inRangeTen[num]} for {
        NumberValue = `n
        eights = `n -> 1 
        remainder = `n -> 3
    }
}

test suite for addHelper{
    example TwentyCorrectAddition is {some num1,num2,total: NumberValue | addHelper[num1,num2,total]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 1 + `n2 -> 1 + `result -> 2
        remainder = `n1 -> 2 + `n2 -> 2 + `result -> 4
    }

    example testSevenIsRecognized is {some num1, num2, total: NumberValue | addHelper[num1,num2,total]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 1 
        remainder = `n1 -> 7 + `n2 -> 1 + `result -> 0
    }

    //testing to make sure numbers out of bounds cannot be added 
    example OutOfBoundsTest is not {some num1, num2, total: NumberValue | addHelper[num1, num2, total]} for {
        #Int = 5 
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 1
        remainder = `n1 -> 8 + `n2 -> 1 + `result -> 1
    }
}

test suite for subtractHelper{
    example correctSubtraction is {some n1, n2, result: NumberValue | subtractHelper[n1,n2,result]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 7 + `n2 -> 1 + `result -> 6
    }

    example noNegativeSubstraction is not {some n1, n2, result: NumberValue | subtractHelper[n1,n2,result]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 ->  2+ `n2 -> 3 + `result -> -1
    }

    example resultInZero is {some n1, n2, result: NumberValue | subtractHelper[n1,n2,result]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 0 + `n2 -> 0 + `result -> 0
    }

    //n1 = 26, n2 = 17, result 9 
    example differentEightsSubtractProperly is {some n1,n2, result: NumberValue | subtractHelper[n1,n2,result]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 3 + `n2 -> 2 + `result -> 1
        remainder = `n1 -> 2 + `n2 -> 1 + `result -> 1
    }
}


// pred calculateValue[num1,num2,result:NumberValue,op:Operator] {
//     (op = Addition) implies {
//         addHelper[num1,num2,result]
//     } else{
//         subtractHelper[num1,num2,result]
//     }
// }

test suite for calculateValue{
    example correctAddValue is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Addition | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 1 + `n2 -> 1 + `result -> 2
    }

    example incorrectAddValue is not {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Addition | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 1 + `n2 -> 1 + `result -> 3

    } 

    example correctSubtractValue  is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Subtraction | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 1 + `n2 -> 1 + `result -> 0

    }

    example incorrectSubtractValue  is not {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Subtraction | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 3 + `n2 -> 1 + `result -> 0

    }

}


// pred ValidNumberSet[num1,num2,num3,num4,total:NumberValue,o1,o2,o3:Operator] {
//     some result1,result2,result3:NumberValue | {
//         //calculates the results using the number and operators provided
//         calculateValue[num1,num2,result1,o1]
//         calculateValue[result1,num3,result2,o2]
//         calculateValue[result2,num4,result3,o3]

//         //end result should equal 24 and set total = 24
//         result3.eights = 3
//         result3.remainder = 0
//         total = result3
//     }
    
// }

test suite for ValidNumberSet{
    example inBoundsNumberSet is {some n1,n2,n3,n4,total: NumberValue, o1,o2,o3: Addition| ValidNumberSet[n1,n2,n3,n4,total,o1,o2,o3]} for {
        NumberValue = `n1 + `n2 + `n3+ `n4 + `result
        eights = `n1 ->1 + `n2 -> 1 + `n3  -> 0 + `n4 -> 0 + `result -> 3
        remainder = `n1 -> 2 + `n2 -> 0 + `n3 -> 2 + `n4 -> 4 + `result -> 0

    }

}


