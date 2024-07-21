import SwiftUI
import Foundation

public extension View {
    func navigationDestination<D: Codable, C>(type: D.Type, @ViewBuilder destination: @escaping (D) -> C) -> some View where D : Hashable, C : View {
        self.navigationDestination(for: type, destination: destination).onAppear {
            NavigationPath.register(type)
        }
    }
}
