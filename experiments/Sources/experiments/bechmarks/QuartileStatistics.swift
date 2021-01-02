//
//  QuartileStatistics.swift
//  
//
//  Created by Roman Vyjídáček on 02.01.2021.
//

import Foundation
import FcaKit

public class QuartileStatistics {

    public func run() {
        let url = URL(fileURLWithPath: CommandLine.arguments[2])
        let fileFormat: FileFormat = url.lastPathComponent.contains(".fimi") ? .fimi : .csv
        let context =  try! FormalContext(url: url, format: fileFormat)
        let concepts = FCbO().count(in: context).filter { $0.size > 0 }
        let quartiles = countQuartiles(concepts: concepts)
        let factors = GreCon2().countFactors(in: context)
        let iteration = (1...factors.count).map { "\($0)" }
        let quartile = factors.map { getQuartile(size: $0.size, quartiles: quartiles).description }
        
        print(iteration.joined(separator: ";"))
        print(quartile.joined(separator: ";"))
        
    }
}

