//
//  Extensions.swift
//  
//
//  Created by Roman Vyjídáček on 18/02/2020.
//

import Foundation
import FcaKit

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

public typealias QuartilesPoints = (q1: Double, q2: Double, q3: Double)

public enum Quartile: Int {
    case q1 = 0
    case q2 = 1
    case q3 = 2
    case q4 = 3
}

func countQuartiles(concepts: [FormalConcept]) -> (q1: Double, q2: Double, q3: Double) {
    let a = concepts.map { Double($0.attributes.count * $0.objects.count) }.sorted()//.map({ "\($0)" }).joined(separator: ";")
    
    var quartiles: [Double] = [0, 0, 0]
    let quotients: [Double] = [1/4, 1/2, 3/4]
    
    for i in 0..<3 {
        let upIndex = Int((Double(a.count) * quotients[i]).rounded(.up))
        let downIndex = upIndex - 1
        
        quartiles[i] = (a[upIndex] + a[downIndex]) / 2
    }
    return (quartiles[0], quartiles[1], quartiles[2])
}

func getQuartile(size: Double, quartiles: (q1: Double, q2: Double, q3: Double)) -> Int {
    if size < quartiles.q1 { return  1 }
    if size >= quartiles.q1 && size < quartiles.q2 { return 2 }
    if size >= quartiles.q2 && size < quartiles.q3 { return 3 }
    return 4
}

func getQuartile(size: Double, quartiles: (q1: Double, q2: Double, q3: Double)) -> Quartile {
    if size < quartiles.q1 { return  .q1 }
    if size >= quartiles.q1 && size < quartiles.q2 { return .q2 }
    if size >= quartiles.q2 && size < quartiles.q3 { return .q3 }
    return .q4
}
