//
//  ContentView.swift
//  Example
//
//  Created by Ho Si Tuan on 21/07/2024.
//

import SwiftUI
import PureNavigationPath

class NavigationModel: ObservableObject {
    @Published var path = NavigationPath()
}

struct ContentView: View {
    @StateObject private var navigationModel = NavigationModel()
    var body: some View {
        NavigationStack(path: $navigationModel.path) {
            BookCategoryView()
                .environmentObject(navigationModel)
        }
        .navigationViewStyle(.stack)
    }
}

struct BookCategoryView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        List(BookCategory.allCases) { category in
            Button(action: {
                navigationModel.path.append(category)
            }, label: {
                HStack {
                    Image(uiImage: category.image ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    Text(category.title)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
            })
        }
        .navigationDestination(type: BookCategory.self, destination: { category in
            BookListView(category: category)
                .environmentObject(navigationModel)
        })
        .navigationDestination(type: Book.self, destination: { book in
            BookDetailView(book: book)
                .environmentObject(navigationModel)
        })
        .navigationTitle("Book categories")
    }
}

struct BookListView: View {
    var category: BookCategory
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        List(category.books) { book in
            Button(action: {
                navigationModel.path.append(book)
            }, label: {
                VStack(alignment: .leading) {
                    Text(book.name ?? "")
                        .bold()
                        .font(.title2)
                    Text(book.author ?? "")
                        .italic()
                }
                .padding()
            })
        }
        .navigationTitle(category.title)
    }
}

struct BookDetailView: View {
    var book: Book
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        VStack {
            Text(book.name ?? "")
            Button(action: {
                navigationModel.path.popToRoot()
            }, label: {
                Text("Pop to root")
            })
            Button(action: {
                navigationModel.path.pop()
            }, label: {
                Text("Pop")
            })
        
        }
        .navigationTitle(book.name ?? "Book detail")
    }
}

enum BookCategory: String, CaseIterable, Identifiable, Hashable, Codable {
    var id: String { self.rawValue }
    case new
    case favorite
    case reading
    case complete
    var title: String {
        switch self {
        case .new: "New books"
        case .favorite: "Favorite"
        case .reading: "Reading"
        case .complete: "Completed"
        }
    }
    var image: UIImage? {
        switch self {
        case .new: UIImage(systemName: "wand.and.stars.inverse")
        case .favorite: UIImage(systemName: "star")
        case .reading: UIImage(systemName: "book")
        case .complete: UIImage(systemName: "books.vertical.fill")
        }
    }

    var books: [Book] {
        [
            Book.mock,
            Book.mock,
            Book.mock,
            Book.mock,
            Book.mock,
        ]
    }
}

struct Book: Codable, Identifiable, Hashable {
    var id: String
    var name: String?
    var author: String?
    var page: Int?
    
    static var mock: Book {
        mockBooks.randomElement() ?? Book(id: UUID().uuidString)
    }
}

extension Book {
    static var mockBooks: [Book] {
        [
            Book(id: UUID().uuidString, name: "To Kill a Mockingbird", author: "Harper Lee", page: 281),
            Book(id: UUID().uuidString, name: "1984", author: "George Orwell", page: 328),
            Book(id: UUID().uuidString, name: "The Great Gatsby", author: "F. Scott Fitzgerald", page: 180),
            Book(id: UUID().uuidString, name: "Moby Dick", author: "Herman Melville", page: 635),
            Book(id: UUID().uuidString, name: "Pride and Prejudice", author: "Jane Austen", page: 279),
            Book(id: UUID().uuidString, name: "The Catcher in the Rye", author: "J.D. Salinger", page: 277),
            Book(id: UUID().uuidString, name: "The Hobbit", author: "J.R.R. Tolkien", page: 310),
            Book(id: UUID().uuidString, name: "Fahrenheit 451", author: "Ray Bradbury", page: 249),
            Book(id: UUID().uuidString, name: "Brave New World", author: "Aldous Huxley", page: 268),
            Book(id: UUID().uuidString, name: "The Odyssey", author: "Homer", page: 500)
        ]
    }
}



#Preview {
    ContentView()
}
