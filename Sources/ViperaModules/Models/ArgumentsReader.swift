import Foundation

final public class ArgumentsReader {
    private let versionArgDescriptors: Set<String> = ["--version"]
    private let helpArgDescriptors: Set<String> = ["--help", "-h"]
    private let pathArgDescriptors: Set<String> = ["--path", "-p"]
    
    public init() {}
    
    // MARK: - Public
    public func passedArguments(in commandLineArguments: [String] = CommandLine.arguments) -> Set<Argument> {
        var stringArguments = commandLineArguments
        if stringArguments.first == Constants.scriptName {
            stringArguments.removeFirst()
        }
        var arguments: Set<Argument> = []
        
        if indexOfArgument(from: versionArgDescriptors, in: stringArguments) != nil {
            arguments.insert(.version)
            stringArguments.removeAll(where: { versionArgDescriptors.contains($0) })
        }
        
        if indexOfArgument(from: helpArgDescriptors, in: stringArguments) != nil {
            arguments.insert(.help)
            stringArguments.removeAll(where: { helpArgDescriptors.contains($0) })
        }
        
        if let firstPath = self.dropFirstPathComponents(from: &stringArguments) {
            arguments.insert(firstPath)
            while self.dropFirstPathComponents(from: &stringArguments) != nil {}
        }
        
        if let argIndex = stringArguments.firstIndex(where: { $0.first != "-" }) {
            let moduleName = stringArguments[argIndex]
            arguments.insert(.moduleName(moduleName))
            stringArguments.remove(at: argIndex)
        }
        
        stringArguments.forEach {
            arguments.insert(.unknown($0))
        }
        return arguments
    }
    
    // MARK: - Private functions
    private func dropFirstPathComponents(from stringArguments: inout [String]) -> Argument? {
        guard let argIndex = indexOfArgument(from: pathArgDescriptors, in: stringArguments) else { return nil }
        let returnPath: Argument
        if let path = stringArguments[safeIndex: argIndex + 1] {
            returnPath = .path(path)
            stringArguments.remove(at: argIndex + 1)
        } else {
            returnPath = .path(nil)
        }
        stringArguments.remove(at: argIndex)
        return returnPath
    }
    
    private func indexOfArgument(from argDescriptors: Set<String>, in stringArguments: [String]) -> Int? {
        stringArguments.firstIndex(where: { argDescriptors.contains($0) })
    }
}

