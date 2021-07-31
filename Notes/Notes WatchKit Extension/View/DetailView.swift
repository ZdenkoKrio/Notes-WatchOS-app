//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Zdenko Čepan on 31/07/2021.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            // MARK: - Header
            HeaderView()
            
            // MARK: - Content
            Spacer()

            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // MARK: - Footer
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                    })
                
                Spacer()
                
                Text("\(count) / \(index)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditPresented, content: {
                        CreditsView()
                    })
                
            } // HSTACK
            .foregroundColor(.secondary)
            
        } // VSTACK
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let sampleData: Note = Note(id: UUID(), text: "Hello, World")
    
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
