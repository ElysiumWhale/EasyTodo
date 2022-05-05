import Foundation

extension String {
    static let empty = ""
    static let zero = "0"

    static let serverDateMask = "yyyy-MM-dd"
    static let displayDateMask = "dd.MM.yyyy"
}

extension Date {
    func formatted(with mask: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = mask
        return formatter.string(from: self)
    }
}
