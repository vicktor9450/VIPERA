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

let moduleName = CommandLine.arguments[1].capitalizedFirstLetter()
let scriptName = URL(fileURLWithPath: CommandLine.arguments.first!).lastPathComponent

let currentDir = Dir.current
let homeDir = Dir()
let workDir = homeDir.child(scriptName, isHidden: true)
var templateDir = workDir

let localTemplateDir = currentDir.child(scriptName, isHidden: true)
if localTemplateDir.isExistingDirectory {
    templateDir = localTemplateDir
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
    let moduleDir = try currentDir.add(moduleName)
    try createModuleComponent(from: templateDir.url, to: moduleDir.url)

    printer.print(message: .moduleCreated(moduleName: moduleName, isTemplateLocal: localTemplateDir.isExistingDirectory))
} catch {
    printer.print(error)
}


printer.print(message: .footer)

