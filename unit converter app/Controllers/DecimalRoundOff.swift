//
//  DecimalRoundOff.swift
//  unit converter app
//
//  Created by Ahmed Abokor on 13/03/18.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
