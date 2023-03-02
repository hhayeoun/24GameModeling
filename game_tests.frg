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

    example TenIsInRange is {some num: NumberValue | inRangeTen[num]} for{
        NumberValue = `n 
        eights = `n -> 1 
        remainder = `n -> 2
    }

    example NegativeEightsIsNotInRange is not {some num: NumberValue | inRangeTen[num]} for{
        NumberValue = `n 
        eights = `n -> -3 
        remainder = `n -> 2
    }

    example NegativeRemainderIsNotInRange is not {some num: NumberValue | inRangeTen[num]} for{
        NumberValue = `n 
        eights = `n -> 0 
        remainder = `n -> -4
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

    example testEightsAndRemainderIsRecognized is {some num1, num2, total: NumberValue | addHelper[num1,num2,total]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 2 + `n2 -> 1 + `result -> 4 
        remainder = `n1 -> 7 + `n2 -> 2 + `result -> 1
    }

    example testNoCarryValueIsRecognized is {some num1, num2, total: NumberValue | addHelper[num1,num2,total]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0 
        remainder = `n1 -> 2 + `n2 -> 4 + `result -> 6
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

    example correctCarrySubtraction is {some n1, n2, result: NumberValue | subtractHelper[n1,n2,result]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 1 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 1 + `n2 -> 7 + `result -> 2
    }

    example noNegativeRemainderSubstraction is {some n1, n2, result: NumberValue | subtractHelper[n1,n2,result]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> -1
        remainder = `n1 ->  2 + `n2 -> 3 + `result -> 7
    }

    example noNegativeSubstraction is not {some n1, n2, result: NumberValue | subtractHelper[n1,n2,result]} for {
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 ->  2 + `n2 -> 3 + `result -> -1
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

    example correctAddValue2 is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Addition | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 5 + `n2 -> 2 + `result -> 7
    } 

    example correctAddValueOverflow is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Addition | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 1
        remainder = `n1 -> 5 + `n2 -> 7 + `result -> 4
    } 

    example correctSubtractValue  is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Subtraction | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 1 + `n2 -> 1 + `result -> 0

    }

    example incorrectSubtractValue  is not {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Subtraction | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 7 + `n2 -> 1 + `result -> 4
    }

    example incorrectSubtractValue2 is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Subtraction | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0
        remainder = `n1 -> 2 + `n2 -> 1  + `result -> 1
    }

    example correctSubtractValueOverflow is {some n1: NumberValue, n2: NumberValue, result: NumberValue, op: Subtraction | calculateValue[n1,n2,result, op]} for{
        NumberValue = `n1 + `n2 + `result 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> -1
        remainder = `n1 -> 1 + `n2 -> 5 + `result -> 4

    }
}

test suite for ValidNumberSet{
    example inBoundsAdditionNumberSet is {some n1,n2,n3,n4,total: NumberValue, o1,o2,o3: Addition| ValidNumberSet[n1,n2,n3,n4,total,o1,o2,o3]} for {
        NumberValue = `n1 + `n2 + `n3+ `n4 + `result + `result2 + `result3 
        eights = `n1 ->1 + `n2 -> 1 + `result -> 2 +  `n3  -> 0 + `result2 -> 2 + `n4 -> 0 + `result3 -> 3
        remainder = `n1 -> 2 + `n2 -> 0 + `result -> 2 + `n3 -> 2 + `result2 -> 4 + `n4 -> 4 + `result3 -> 0
    }

    example inBoundsAdditionAndSubtraction is {some n1,n2,n3,n4,total: NumberValue, o1,o2: Addition, o3: Subtraction| ValidNumberSet[n1,n2,n3,n4,total,o1,o2,o3]} for {
        NumberValue = `n1 + `n2 + `n3+ `n4 + `result + `result2 + `result3 
        eights = `n1 -> 1 + `n2 -> 1 + `result -> 2 + `n3 -> 0 + `result2 -> 3 + `n4 -> 0 + `result3 -> 3 
        remainder = `n1 -> 2 + `n2 -> 0 + `result -> 2 + `n3 -> 7 + `result2 -> 1 + `n4 -> 1 + `result3 -> 0
    }

    example inValidAdditionCombination is not {some n1,n2,n3,n4,total: NumberValue, o1,o2,o3: Addition| ValidNumberSet[n1,n2,n3,n4,total,o1,o2,o3]} for{
        NumberValue = `n1 + `n2 + `n3+ `n4 + `result + `result2 + `result3 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0 + `n3 -> 0 +`result2 -> 1 + `n4 -> 0 + `result3 -> 1 
        remainder = `n1 -> 1 + `n2 -> 2 + `result -> 3 + `n3 -> 3 + `result2 -> 1 + `n4 -> 4 + `result3 -> 5 
    }

    example inValidAdditionSubtractionCombination is not {some n1,n2,n3,n4,total: NumberValue, o1,o3:Addition, o2: Subtraction | ValidNumberSet[n1,n2,n3,n4,total,o1,o2,o3]} for{
        NumberValue = `n1 + `n2 + `n3+ `n4 + `result + `result2 + `result3 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0 + `n3 -> 0 +`result2 -> 0 + `n4 -> 0 + `result3 -> 0
        remainder = `n1 -> 2 + `n2 -> 1 + `result -> 3 + `n3 -> 3 + `result2 -> 0 + `n4 -> 4 + `result3 -> 4
    }

    example inValidNegativeCombination is not {some n1,n2,n3,n4,total: NumberValue, o1,o3, o2: Subtraction | ValidNumberSet[n1,n2,n3,n4,total,o1,o2,o3]} for{
        NumberValue = `n1 + `n2 + `n3+ `n4 + `result + `result2 + `result3 
        eights = `n1 -> 0 + `n2 -> 0 + `result -> 0 + `n3 -> 0 +`result2 -> 0 + `n4 -> 0 + `result3 -> 0
        remainder = `n1 -> 7 + `n2 -> 1 + `result -> 6 + `n3 -> 3 + `result2 -> 3 + `n4 -> 4 + `result3 -> -1
    }
}
