//
//  main.swift
//  Dir
//
//  Created by Tibor Bödecs on 2019. 02. 28..
//

import Foundation
import Dir
import SPM

let installTemplates = CommandLine.arguments.contains("--with-templates")
let installXCodeTemplates = CommandLine.arguments.contains("--with-xcode-templates")

let installDir = "/usr/local/bin"
let templatesDir = "Templates"
let scriptName = "vipera"
let xc = "Xcode"
let xcDir = Dir(path: "~/Library/Developer/Xcode/Templates/File Template")
let homeDir = Dir()
let workDir = try homeDir.add(scriptName, isHidden: true)

if installTemplates {
    let templatesSource = Dir.current.child(templatesDir).child(scriptName)
    let targetDir = workDir.child(templatesDir)
    try targetDir.create(withIntermediateDirectories: true, attributes: nil)
    try templatesSource.copy(to: targetDir, force: true)
}

if installXCodeTemplates {
    let templatesSource = Dir.current.child(templatesDir).child(xc)
    let targetDir = xcDir.child(scriptName.uppercased())
    try targetDir.create(withIntermediateDirectories: true, attributes: nil)
    try templatesSource.copy(to: targetDir, force: true)
}

// MARK: - build & deploy executable
let spm = SPM(path: ".")
try spm.run(.build, flags: [.config(.release)])
let buildPath = try spm.run(.build, flags: [.config(.release), .showBinaryPath])

let destination = Dir(path: installDir).child(scriptName)
let source = Dir(path: buildPath).child(scriptName)

try source.copy(to: destination, force: true)
try source.chmod(0o755)


