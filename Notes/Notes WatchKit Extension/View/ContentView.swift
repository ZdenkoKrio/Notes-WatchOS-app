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
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        // print data to the console
        //dump(notes)
        
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            try data.write(to: url)
        } catch {
            print("Saving data has failed!")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                // do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
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
            
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i],
                                                               count: notes.count,
                                                               index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                                    
                                Text(notes[i].text)
                                    .lineLimit(1)
                                    .padding(.leading, 4)
                            } // HSTACK
                        } // LOOP
                    } // NAVIGATION
                    .onDelete(perform: delete)
                } // LIST
            } else {
                Spacer()
                
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                
                Spacer()
            } // CONDITION
        } // VSTACK
        .navigationTitle("Notes")
        .onAppear(perform: {
            load()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
