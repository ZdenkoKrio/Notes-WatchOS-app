//
//  SettingsView.swift
//  Notes WatchKit Extension
//
//  Created by Zdenko Čepan on 31/07/2021.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var value: Float = 1.0
    
    // MARK: - Functions
    func update() {
        lineCount = Int(value)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Settings")
            
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            Slider(value: Binding(get: {
                self.value
            }, set: { newValue in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
        } //VSTACK
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
