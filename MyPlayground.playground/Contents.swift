//: Playground - noun: a place where people can play

import UIKit

var number = 19

var isPrime = true

if number == 1{
    isPrime = false
}
else if number != 2 && number != 1 {
    for var i = 2; i < number; i += 1 {
        if number % i == 0 {
            isPrime = false
            break
        }
    }
}

print(isPrime)