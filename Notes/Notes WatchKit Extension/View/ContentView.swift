//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Zdenko Čepan on 31/07/2021.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    // MARK: - Functions
    func save() {
        // print data to the console
        dump(notes)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Note", text: $text)
                
                Button {
                    // MARK: - Action
                    // Only run the button's action when text field isn't empty
                    guard text.isEmpty == false else { return }
                    
                    let note: Note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                } // BUTTON
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //.buttonStyle(BorderedButtonStyle(tint: .accentColor))
            } // HSTACK
            
            Spacer()
            
            Text("\(notes.count)")
        } // VSTACK
        .navigationTitle("Notes")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
