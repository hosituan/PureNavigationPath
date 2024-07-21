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
            BookCategoryView(navigationModel: navigationModel)
        }
        .navigationViewStyle(.stack)
    }
}

struct BookCategoryView: View {
    @ObservedObject var navigationModel: NavigationModel
    var body: some View {
        List(BookCategory.allCases) { category in
            HStack {
                Image(uiImage: category.image ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                Text(category.title)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                navigationModel.path.append(category)
            }
        }
        .navigationDestination(type: BookCategory.self, destination: { category in
            
        })
        .navigationTitle("Book categories")
    }
}
struct BookListView: View {
    var body: some View {
        VStack {
            
        }
        .navigationTitle("Book list")
    }
}

struct BookDetailView: View {
    var body: some View {
        VStack {
            
        }
        .navigationTitle("Book detail")
    }
}

enum BookCategory: String, CaseIterable, Identifiable, Hashable {
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
}

#Preview {
    ContentView()
}
