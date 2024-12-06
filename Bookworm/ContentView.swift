//
//  ContentView.swift
//  Bookworm
//
//  Created by Mark Santoro on 12/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
            SortDescriptor(\Book.title),
            SortDescriptor(\Book.author)
        ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                                
                              }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
           
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) {book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen){
                AddBookView()
            }
            
        }
        
        
        
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            modelContext.delete(book)
            
        }
    }
}

#Preview {
    ContentView()
}
