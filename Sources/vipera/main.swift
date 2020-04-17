import Foundation
import Dir

let printer = Printer()

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

let dirManager = DirectoryManager()

let moduleName = CommandLine.arguments[1].capitalizedFirstLetter()
let scriptName = URL(fileURLWithPath: CommandLine.arguments.first!).lastPathComponent

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
} else {
    moduleParentDirectory = currentDir
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
    try createModuleComponent(from: templateDir.url, to: moduleDir.url)

    printer.print(message: .moduleCreated(moduleName: moduleName, isTemplateLocal: localTemplateDir != nil))
} catch {
    printer.print(error)
    exit(-1)
}


printer.print(message: .footer)

