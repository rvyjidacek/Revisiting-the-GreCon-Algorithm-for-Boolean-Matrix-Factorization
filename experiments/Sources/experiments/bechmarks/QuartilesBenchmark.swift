//
//  QuartilesBenchmark.swift
//  
//
//  Created by Roman Vyjídáček on 02.01.2021.
//

import Foundation
import FcaKit


public class QuartilesBenchmark: Benchmark {
    
    
    public override func run() {
        for url in urls {
            times(for: url)
        }
    }
    
    private func times(for url: URL) {
        let fileFormat: FileFormat = url.lastPathComponent.contains(".fimi") ? .fimi : .csv
        let context = try! FormalContext(url: url, format: fileFormat)
        let concepts = FCbO().count(in: context)
        let quartiles = countQuartiles(concepts: concepts)
        
        let inputs: [Set<Quartile>] = [
            [.q4],
            [.q4, .q3],
            [.q4, .q3, .q2],
            [.q4, .q3, .q2, .q1]
        ]
        
        var outputs: [String] = []
        print(url.lastPathComponent.replacingOccurrences(of: ".fimi", with: ""), terminator: " & ")
        
        for quartileSet in inputs {
            let inputConcepts = concepts.filter { quartileSet.contains(getQuartile(size: $0.size, quartiles: quartiles)) }
            let measureResult = measure { () -> [FormalConcept] in
                return GreCon2().countFactorization(using: inputConcepts, in: context)
            }
            
            outputs.append(String(format: "$%.2f \\pm %.2f$", measureResult.averageTime, measureResult.deviation, measureResult.closureResult.count))
        }
        
        print(outputs.joined(separator: " & "), terminator: "")
        print(" \\\\")
    }
    
}
