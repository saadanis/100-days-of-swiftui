//
//  ContentView.swift
//  Convertence
//
//  Created by Saad Anis on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    @State var inputValue: Double = 0.0
    @State var selectedInputUnit: String = "Celsius"
    @State var selectedOutputUnit: String = "Fahrenheit"
    var outputValue: Double {
        if selectedInputUnit == selectedOutputUnit {
            return inputValue
        }
        
        var inputInCelsius = inputValue
        
        if selectedInputUnit == "Fahrenheit" {
            inputInCelsius = (inputValue - 32) * 5 / 9
        } else if selectedInputUnit == "Kelvin" {
            inputInCelsius = inputValue - 273.15
        }
        
        if selectedOutputUnit == "Fahrenheit" {
            return (inputInCelsius * 9 / 5) + 32
        } else if selectedOutputUnit == "Kelvin" {
            return inputInCelsius + 273.15
        }
        return inputInCelsius
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Value", value: $inputValue, format: .number)
                }
                
                Section("Units") {
                    Picker("Input", selection: $selectedInputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    Picker("Output", selection: $selectedOutputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                
                Section("Output") {
                    Text(outputValue.formatted())
                }
            }
            .navigationTitle("Convertence")
        }
    }
}

#Preview {
    ContentView()
}
