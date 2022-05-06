import Foundation

extension String {
    static let empty = ""
    static let zero = "0"

    static let serverDateMask = "yyyy-MM-dd"
    static let displayDateMask = "dd.MM.yyyy"
}

extension NSAttributedString {
    static func attributed(_ string: String,
                           shouldUseAttributes: Bool,
                           attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        shouldUseAttributes
            ? NSAttributedString(string: string)
            : NSAttributedString(string: string, attributes: attributes)
    }
}

extension Date {
    func formatted(with mask: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = mask
        return formatter.string(from: self)
    }
}
