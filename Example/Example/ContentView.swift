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
        VStack {
            NavigationStack(path: $navigationModel.path) {
                ViewA() // Root
                    .environmentObject(navigationModel)
            }
            .navigationViewStyle(.stack)
            VStack(alignment: .leading) {
                Text("Navigation stack")
                    .bold()
                Divider()
                ForEach(navigationModel.path.resolvedItems.indices, id: \.self) { index in
                    Text(String(reflecting: navigationModel.path.resolvedItems[index]))
                    Divider()
                }
            }
            .padding()
        }
    }
}

struct ViewA: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        List(BookCategory.allCases) { category in
            Button(action: {
                navigationModel.path.append(BookCategory.new)
            }, label: {
                HStack {
                    Image(uiImage: category.image ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    Text("Go to B")
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
            ViewB(category: category)
                .environmentObject(navigationModel)
        })
        .navigationDestination(type: Book.self, destination: { book in
            ViewC(book: book)
                .environmentObject(navigationModel)
        })
        .navigationDestination(type: String.self, destination: { path in
            ViewD(path: path)
                .environmentObject(navigationModel)
        })
        .navigationDestination(type: Int.self, destination: { intPath in
            ViewE(intPath: intPath)
                .environmentObject(navigationModel)
        })
        .navigationTitle("View A")
    }
}

struct ViewB: View {
    var category: BookCategory
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                navigationModel.path.append(Book.mock)
            }, label: {
                Text("Go to C")
            })
            Button(action: {
                navigationModel.path.pop()
            }, label: {
                Text("Pop")
            })
            Button(action: {
                navigationModel.path.popToRoot()
            }, label: {
                Text("Pop to root")
            })
            Spacer()
            HStack {
                Spacer()
            }
        }
        .navigationTitle("View B")
    }
}

struct ViewC: View {
    var book: Book
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                navigationModel.path.append("ViewD")
            }, label: {
                Text("Go to D")
            })
            Button(action: {
                navigationModel.path.pop()
            }, label: {
                Text("Pop")
            })
            Button(action: {
                navigationModel.path.popToRoot()
            }, label: {
                Text("Pop to root")
            })

            Spacer()
            HStack {
                Spacer()
            }
        }
        .padding()
        .navigationTitle("View C")
    }
}

struct ViewD: View {
    var path: String
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                navigationModel.path.append(1)
            }, label: {
                Text("Go to E")
            })
            Button(action: {
                navigationModel.path.pop(to: BookCategory.new)
            }, label: {
                Text("Pop to B")
            })
            Button(action: {
                navigationModel.path.pop()
            }, label: {
                Text("Pop")
            })
            Button(action: {
                navigationModel.path.popToRoot()
            }, label: {
                Text("Pop to root")
            })
            Spacer()
            HStack {
                Spacer()
            }
        }
        .navigationTitle("View D")
    }
}


struct ViewE: View {
    var intPath: Int
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                navigationModel.path.pop(to: Book.mock)
            }, label: {
                Text("Pop to C")
            })
            Button(action: {
                navigationModel.path.pop(to: "ViewD")
            }, label: {
                Text("Pop to ViewD path")
            })
            Button(action: {
                navigationModel.path.pop()
            }, label: {
                Text("Pop")
            })
            Button(action: {
                print(navigationModel.path.resolvedItems)
                navigationModel.path.popToRoot()
            }, label: {
                Text("Pop to root")
            })
            Spacer()
            HStack {
                Spacer()
            }
        }
        .navigationTitle("View E")
    }
}

enum BookCategory: String, CaseIterable, Identifiable, Hashable, Codable {
    var id: String { String(describing: self) }
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
}

struct Book: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var author: String
    var page: Int
    static var mock: Book = Book(id: UUID().uuidString, name: "To Kill a Mockingbird", author: "Harper Lee", page: 281)
}



#Preview {
    ContentView()
}
