//
//  main.swift
//  Dir
//
//  Created by Tibor Bödecs on 2019. 02. 28..
//

import Foundation
import Dir
import SPM

let installDir = "/usr/local/bin"
let templateDir = "Template"
let scriptName = "vipera"
let homeDir = Dir()
let workDir = try homeDir.add(scriptName, isHidden: true)

// copy template
let templateSource = Dir.current.child(templateDir)
try templateSource.copy(to: workDir, force: true)

// MARK: - build & deploy executable
let spm = SPM(path: ".")
try spm.run(.build, flags: [.config(.release)])
let buildPath = try spm.run(.build, flags: [.config(.release), .showBinaryPath])


let destination = Dir(path: installDir).child(scriptName)
let source = Dir(path: buildPath).child(scriptName)

try destination.delete()

try source.copy(to: destination, force: true)
try source.chmod(0o755)


