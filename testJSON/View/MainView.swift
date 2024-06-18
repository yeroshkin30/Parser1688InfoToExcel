//
//  MainView.swift
//  testJSON
//
//  Created by oleh yeroshkin on 14.06.2024.
//

import AppKit

final class MainView: NSView {
    enum Event {
        case linkButtonTapped(String)
        case sizeButtonWasTaped([SizeData])
        case createXLFile
    }

    var onEvent: ((Event) -> Void)?

    // MARK: - Private properties

    private var sizeCreationView: SizeCreationView?
    private let textFieldForLink: NSTextField = .init()
    private let buttonLink: NSButton = .init()
    private let createXLButton: NSButton = .init()

    // MARK: - Initialisers

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSizeCreationView(with sizeInfo: [SizeInfo]) {
        sizeCreationView?.removeFromSuperview()
        sizeCreationView = .init(sizes: sizeInfo)
        sizeCreationView?.onSizeDataCreated = { [unowned self] sizeData in
            onEvent?(.sizeButtonWasTaped(sizeData))
        }
        sizeCreationView?.layout(in: self) {
            $0.centerX == centerXAnchor
            $0.centerY == centerYAnchor
            $0.width == 600
        }
    }
}

// MARK: - Private properties

private extension MainView {
    func setupView() {

        setupButton()
        setupTextField()
        setupConstraints()
    }

    func setupTextField() {
        textFieldForLink.placeholderString = "Add link"

    }

    func setupButton() {
        buttonLink.title = "Get data from link"
        buttonLink.action = #selector(buttonTap)

        createXLButton.title = "Create XL file"
        createXLButton.action = #selector(createXL)
    }

    @objc func buttonTap() {
        let linkString = textFieldForLink.stringValue
        onEvent?(.linkButtonTapped(linkString))
    }

    @objc func createXL() {
        onEvent?(.createXLFile)
    }

    func setupConstraints() {
        textFieldForLink.layout(in: self) {
            $0.leading == leadingAnchor + 30
            $0.trailing == trailingAnchor - 30
            $0.height == 50
        }

        buttonLink.layout(in: self) {
            $0.top == textFieldForLink.bottomAnchor + 20
            $0.centerX == centerXAnchor
            $0.height == 50
            $0.bottom == bottomAnchor - 20
        }

        createXLButton.layout(in: self) {
            $0.top == topAnchor + 10
            $0.centerX == centerXAnchor
            $0.height == 50
        }
    }
}
