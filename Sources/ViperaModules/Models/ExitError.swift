import Foundation

public struct ExitError: Error, Equatable {
    public let code: Int32
}
