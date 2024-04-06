import SwiftUI

struct ContentView: View {
    @State private var bill: String = ""
    @State private var tip: Double = 15.0
    @State private var persons: Double = 2.0
    @State private var amtDue: Double? = 0
    @State private var isEditing = false
    @State private var tipAmtSelected = false
    @State private var numPersonsSelected = false
    
    let tipAmounts = [5.0, 10.0, 15.0, 20.0, 25.0]
    let noAmtWarning = "You haven't entered your bill amount"
    
    func calculateTip() {
        let billAmt = Double(bill) ?? 0
        amtDue = ((billAmt) + ((billAmt) * (tip / 100))) / persons
    }
    
    var body: some View {
        VStack {
            Text(String(format: "%.2f per person", amtDue ?? 0))
                .font(.largeTitle)
                .padding()
            
            if bill.isEmpty && (tipAmtSelected || numPersonsSelected) {
                Text(noAmtWarning)
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            } else {
                Text("")
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
            
            TextField("Enter Bill Amount", text: $bill)
                .textFieldStyle(.roundedBorder)
                .padding()
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .onChange(of: bill) { _ in
                    calculateTip()
                }
            
            Spacer()
            
            Text("Choose tip percentage")
                .font(.title2)
            
            Picker("Tip Amount", selection: $tip) {
                ForEach(tipAmounts, id: \.self) { value in
                    Text("\(Int(value))")
                        .fontWeight(value == tip ? .bold : .regular)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: tip) { _ in
                calculateTip()
                tipAmtSelected = true
            }
            
            Spacer()
            
            Text("How many persons are splitting?")
                .font(.title2)
            
            Slider(
                value: $persons,
                in: 1...20,
                step: 1
            ) {
                
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("20")
            } onEditingChanged: { editing in
                isEditing = editing
                numPersonsSelected = true
                calculateTip()
            }
            
            Text("\(Int(persons)) \(persons == 1 ? "person" : "persons")")
                .font(.title3)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
