//
//  main.swift
//  Dir
//
//  Created by Tibor Bödecs on 2019. 02. 28..
//

import Foundation
import Dir
import SPM

// MARK: - create work dir & default template

let scriptName = "vipera"
let homeDir = Dir()
let workDir = try homeDir.add(scriptName, isHidden: true)
let templatesSource = Dir.current.child("Templates")

try templatesSource.copy(to: workDir.child("Templates"), force: true)

// MARK: - build & copy executable

let spm = SPM(path: ".")
try spm.run(.build, flags: [.config(.release)])
let buildPath = try spm.run(.build, flags: [.config(.release), .showBinaryPath])

let destination = Dir(path: "/usr/local/bin").child(scriptName)
let source = Dir(path: buildPath).child(scriptName)

try source.copy(to: destination, force: true)
try source.chmod(0o755)

