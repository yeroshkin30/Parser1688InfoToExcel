//
//  main.swift
//  testJSON
//
//  Created by oleh yeroshkin on 12.06.2024.
//

import AppKit


// 1
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// 2
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
