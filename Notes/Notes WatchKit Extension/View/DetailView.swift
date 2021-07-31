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
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            // MARK: - Header
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            } // HSTACK
            .foregroundColor(.accentColor)
            
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
                
                Spacer()
                
                Text("\(count) / \(index)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                
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
