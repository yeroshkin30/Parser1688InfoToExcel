//
//  SizeDataStackView.swift
//  testJSON
//
//  Created by oleh yeroshkin on 14.06.2024.
//


import AppKit

final class SizeCreationView: NSView {

    var onSizeDataCreated: (([SizeData]) -> Void)?

    // MARK: - Private properties

    private let stackView: NSStackView = .init()
    private let sizesInfo: [SizeInfo]
    private var stackViews: [SizeStackView] = []
    private let createSizeDataButton: NSButton = .init()

    // MARK: - Initialisers

    init(sizes: [SizeInfo]) {
        self.sizesInfo = sizes
        super.init(frame: .zero)
        wantsLayer = true
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private properties

private extension SizeCreationView {
    func setupView() {
        layer?.backgroundColor = .white
        layer?.cornerRadius = 15
        layer?.borderColor =  NSColor.gray.cgColor
        layer?.borderWidth = 3
        setupSizeDataButton()
        setupStackView()
        setupConstraints()
    }

    func setupSizeDataButton() {
        createSizeDataButton.title = "Create Size Data"
        createSizeDataButton.contentTintColor = NSColor.darkGray
        createSizeDataButton.action = #selector(createSize)
    }

    @objc func createSize() {
        let sizeData = stackViews.map { $0.getSizeData() }
        onSizeDataCreated?(sizeData)
    }

    func setupStackView() {
        stackView.orientation = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        for sizeInfo in self.sizesInfo {
            let stack: SizeStackView = .init(sizeInfo: sizeInfo)
            stackView.addArrangedSubview(stack)
            stackViews.append(stack)
            stack.layout {
                $0.leading == stackView.leadingAnchor
                $0.trailing == stackView.trailingAnchor
            }
        }
    }

    func setupConstraints() {
        let margin: CGFloat = 15
        stackView.layout(in: self) {
            $0.top == topAnchor + margin
            $0.leading == leadingAnchor + margin
            $0.trailing == trailingAnchor - margin
        }
        createSizeDataButton.layout(in: self) {
            $0.top == stackView.bottomAnchor + margin
            $0.centerX == centerXAnchor
            $0.bottom == bottomAnchor - margin
            $0.height == 30
        }
    }
}
