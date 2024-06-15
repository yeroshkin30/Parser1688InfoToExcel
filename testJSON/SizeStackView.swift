//
//  SizeDataView.swift
//  testJSON
//
//  Created by oleh yeroshkin on 14.06.2024.
//

import AppKit

struct SizeData {
    let sizeValue: String
    let productLength: String?
    let shoulderLength: String?
    let bust: String?
    let waist: String?
    let hips: String?
    let sleeve: String?
}

final class SizeStackView: NSStackView {

    // MARK: - Private properties
    private let label: NSTextField = .init()
    private let productLength: NSTextField = .init()
    private let shoulderLength: NSTextField = .init()
    private let bust: NSTextField = .init()
    private let waist: NSTextField = .init()
    private let hips: NSTextField = .init()
    private let sleeve: NSTextField = .init()

    private lazy var textViews = [
        label,
        productLength,
        shoulderLength,
        bust,
        waist,
        hips,
        sleeve
    ]

    // MARK: - Initialisers

    private let sizeValue: String

    init(size: String) {
        self.sizeValue = size
        super.init(frame: .zero)
        wantsLayer = true
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getSizeData() -> SizeData {
        .init( sizeValue: label.stringValue,
               productLength: productLength.stringValue,
               shoulderLength: shoulderLength.stringValue,
               bust: bust.stringValue,
               waist: waist.stringValue,
               hips: hips.stringValue,
               sleeve: sleeve.stringValue
        )
    }
}

// MARK: - Private properties

private extension SizeStackView {
    func setupView() {
        distribution = .fillEqually
        spacing = 10
        orientation = .horizontal
        layer?.backgroundColor = NSColor.white.cgColor
        setupTextViews()
        setupConstraints()
    }

    func setupTextViews() {
        textViews.forEach {
            addArrangedSubview($0)
            $0.backgroundColor = .lightGray.withAlphaComponent(0.3)
            $0.alignment = .center
        }
        label.stringValue = sizeValue
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        label.isSelectable = false
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {

    }
}
