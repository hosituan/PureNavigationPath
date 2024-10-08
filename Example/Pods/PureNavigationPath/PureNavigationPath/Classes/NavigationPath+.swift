import SwiftUI
import Foundation

public extension NavigationPath {
    static var resolvedItemTypes: [String: Codable.Type] = [:]
    static func register<T: Codable>(_ types: T.Type...) {
        types.forEach { type in
            resolvedItemTypes[String(describing: type)] = type
        }
    }
    
    var resolvedItems: [Codable] {
        guard let codable = self.codable,
              let json = try? JSONEncoder().encode(codable),
              let containner = try? JSONDecoder().decode(NavigationItemContainer.self, from: json)
        else { return [] }
        return containner.items
    }
    
    mutating func pop(to item: Codable) {
        if let index = resolvedItems.firstIndex(where: {
            compare(item, $0)
        }) {
            self.removeLast(index)
        }
    }
    
    mutating func popToRoot() {
        self.removeLast(self.count)
    }

    mutating func pop() {
        self.removeLast()
    }
    
    private func compare(_ item1: Codable, _ item2: Codable) -> Bool {
        let isSameType = type(of: item1) == type(of: item2)
        let isSameValue = (try? JSONEncoder().encode(item1)) == (try? JSONEncoder().encode(item2))
        return isSameType && isSameValue
    }
    
    private struct NavigationItemContainer: Decodable {
        let items: [Codable]
        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            var items = [Codable]()
            let appName = (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "") + "."
            while !container.isAtEnd {
                let typeString = try container.decode(String.self).replacingOccurrences(of: appName, with: "").replacingOccurrences(of: "Swift.", with: "")
                let jsonString = try container.decode(String.self)
                if let jsonData = jsonString.data(using: .utf8) {
                    if let itemType = NavigationPath.resolvedItemTypes[typeString] {
                        let decodedItem = try JSONDecoder().decode(itemType, from: jsonData)
                        items.append(decodedItem)
                    }
                }
            }
            self.items = items
        }
    }
}
