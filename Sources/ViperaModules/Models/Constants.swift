import Foundation

public struct Constants {
    public static let version: String = "2.1.0"
    public static let scriptName: String = URL(fileURLWithPath: CommandLine.arguments.first!).lastPathComponent
}
