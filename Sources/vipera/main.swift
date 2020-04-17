import Foundation
import Dir

func main() {
    let printer = Printer()
    let dirManager = DirectoryManager()
    
    if CommandLine.arguments.contains("--version") {
        printer.print(message: .version)
        exit(0)
    }
    
    if CommandLine.arguments.contains("--help") || CommandLine.arguments.contains("-h") {
        printer.print(message: .help)
        exit(0)
    }
    
    guard CommandLine.arguments.count > 1 else {
        printer.print(message: .help)
        exit(0)
    }
    
    var readArguments: [String] = [CommandLine.arguments.first!]
    
    let currentDir = dirManager.currentDir()
    let localTemplateDir = dirManager.localTemplateDir()
    let templateDir = localTemplateDir ?? dirManager.globalTemplateDir()
    
    let moduleParentDirectory: Dir
    if let pathArgumentIndex = CommandLine.arguments.firstIndex(of: "--path") ?? CommandLine.arguments.firstIndex(of: "-p") {
        guard let path = CommandLine.arguments[safeIndex: pathArgumentIndex + 1] else {
            printer.print(message: .invalidUsageOfPath)
            exit(-1)
        }
        do {
            moduleParentDirectory = try dirManager.createChildDir(path: path)
        } catch {
            printer.print(error)
            exit(-1)
        }
        readArguments.append(contentsOf: ["--path", "-p", path])
    } else {
        moduleParentDirectory = currentDir
    }
    
    guard let moduleName = CommandLine.arguments.first(where: { !readArguments.contains($0) })?.capitalizedFirstLetter() else {
        printer.print(message: .moduleNameNotFound)
        exit(-1)
    }
    
    let userName = getGitUserName() ?? "VIPERA Generator"
    let date = getFormattedDate()
    let projectName = getProjectName(from: currentDir.url) ?? moduleName
    
    let params = [
        "module": moduleName,
        "project": projectName,
        "author": userName,
        "date": date,
    ]
    
    do {
        let moduleDir = try moduleParentDirectory.add(moduleName)
        try createModuleComponent(from: templateDir.url, to: moduleDir.url, withParams: params)
        
        printer.print(message: .moduleCreated(moduleName: moduleName, isTemplateLocal: localTemplateDir != nil))
    } catch {
        printer.print(error)
        exit(-1)
    }
    
    printer.print(message: .footer)
}

main()
