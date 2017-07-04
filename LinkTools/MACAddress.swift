import Foundation

class MACAddress: Equatable {

  var humanReadable: String {
    return isValid ? formatted : "??:??:??:??:??:??"
  }

  var formatted: String {
    return String(sanitized.characters.enumerated().map() {
      $0.offset % 2 == 1 ? [$0.element] : [":", $0.element]
    }.joined().dropFirst())
  }

  var prefix: String {
    return formatted.components(separatedBy: ":").prefix(3).joined(separator: ":")
  }

  var isValid: Bool {
    return formatted.characters.count == 17
  }

  var isInvalid: Bool {
    return !isValid
  }

  private var sanitized: String {
    return raw.lowercased().components(separatedBy: nonHexCharacters).joined()
  }

  private var raw: String
  private lazy var nonHexCharacters = CharacterSet(charactersIn: "0123456789abcdef").inverted

  init(_ raw: String) {
    self.raw = raw
  }

}

func ==(lhs: MACAddress, rhs: MACAddress) -> Bool {
  return lhs.formatted == rhs.formatted
}