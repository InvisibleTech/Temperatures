//
//  ContentView.swift
//  Temperatures
//
//  Created by John Ferguson on 8/29/20.
//  Copyright © 2020 Invisible Tech. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    enum Units: String, CaseIterable, Identifiable {
        case celsius
        case fahrenheit
        case kelvin
        
        var id: String { self.rawValue }
    }
    
    @State private var fromValue = ""
    @State private var fromUnits = Units.fahrenheit.id
    @State private var toUnits = Units.celsius.id
    
    var conversion: Double {
        let fromAsNum = Double(fromValue) ?? 0.0
        print("\(fromUnits)  ==> \(toUnits)")
        if fromUnits == toUnits {
            return fromAsNum
        }
        
        switch (fromUnits, toUnits) {
            case (Units.fahrenheit.id, Units.celsius.id):
                return (fromAsNum - 32.0) * 5.0/9.0
            case (Units.celsius.id, Units.fahrenheit.id):
                return (fromAsNum * 9.0/5.0) + 32.0
            case (Units.celsius.id, Units.kelvin.id):
                return fromAsNum + 273.15
            case (Units.kelvin.id, Units.celsius.id):
                return fromAsNum - 273.15
            case (Units.fahrenheit.id, Units.kelvin.id):
                return (fromAsNum - 32.0) * 5.0/9.0 + 273.15
            case (Units.kelvin.id, Units.fahrenheit.id):
                return (fromAsNum - 273.15) * 9.0/5.0 + 32.0
            default:
                return 0.0
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert from")) {
                    TextField("Input to convert", text: $fromValue)
                        .keyboardType(.decimalPad)
                    Picker(selection: $fromUnits, label: Text("Units"))  {
                        ForEach(Units.allCases) { units in
                            Text(units.rawValue.capitalized)
                        }
                    
                    }
                }
                Section(header: Text("Convert to")) {
                    Picker(selection: $toUnits, label: Text("Units")) {
                        ForEach(Units.allCases) {units in
                            Text(units.rawValue.capitalized)
                        }
                    }
                    Section(header: Text("Result")) {
                        Text("\(conversion, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("Temperatures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
