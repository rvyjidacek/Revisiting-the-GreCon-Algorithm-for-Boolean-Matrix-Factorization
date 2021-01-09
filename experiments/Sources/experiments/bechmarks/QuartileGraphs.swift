//
//  QuartileGraphs.swift
//  
//
//  Created by Roman Vyjídáček on 02.01.2021.
//

import Foundation
import FcaKit

public class QuartileGraphs {
    
    public func run() {
        let url = URL(fileURLWithPath: CommandLine.arguments[2])
        let fileFormat: FileFormat = url.lastPathComponent.contains(".fimi") ? .fimi : .csv
        let context = try! FormalContext(url: url, format: fileFormat)
        let concepts = FCbO().count(in: context)
        let quartiles = countQuartiles(concepts: concepts)
        
        let inputs: [Set<Quartile>] = [
            [.q4, .q3, .q2, .q1],
            [.q4],
            [.q4, .q3],
            [.q4, .q3, .q2],
        ]
        
        let inputType = ["GreCon2", "GreCon2 (Q4)", "GreCon2 (Q4 $\\cup$ Q3)", "GreCon2 (Q4 $\\cup$ Q3 $\\cup$ Q2)"]
            
        for i in 0..<inputs.count {
            var outputs: String = ""
            let inputConcepts = concepts.filter { inputs[i].contains(getQuartile(size: $0.size, quartiles: quartiles)) }
            let factors = GreCon2().countFactorization(using: inputConcepts, in: context) as! [FormalConcept]
            let coverage = dataForCoverageGraph(factors: factors, context: context, algorithmName: inputType[i])
            
            
            outputs.append(coverage)
            print(outputs, terminator: "")
        }
        
    }
    
    func dataForCoverageGraph(factors: [FormalConcept], context: FormalContext, algorithmName: String) -> String {
        var result = ""
        var totalCoverage: [Int] = []
        let contextRelation = CartesianProduct(context: context)
        let covered = CartesianProduct(rows: context.objectCount,
                                       cols: context.attributeCount)
        
        
        result.append(contentsOf: "\(algorithmName);0;")
        for factor in factors {
            let cover = contextRelation.intersected(factor.cartesianProduct).count
        
            for tuple in factor.cartesianProduct {
                contextRelation.remove(tuple)
            }
            
            totalCoverage.append((totalCoverage.last ?? 0) + cover)
            //totalCoverage.append(cover.)
    //        covered.union(factor.cartesianProduct)
    //        totalCoverage = covered.intersected(contextRelation).count
    //        result.append(contentsOf: ";\(totalCoverage)")
            
        }
        result.append(totalCoverage.map { "\($0)" }.joined(separator: ";"))
        result.append("\n")
        return result
    }
    
}
