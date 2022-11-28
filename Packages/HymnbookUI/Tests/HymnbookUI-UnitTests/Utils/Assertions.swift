import SnapshotTesting
import SwiftUI
import UIKit

public func assertSnapshot<Value: View>(
    screen value: Value,
    record recording: Bool = false,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let sut = UIHostingController(rootView: value)

    let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    assertSnapshot(matching: sut, as: .image(on: .iPhone13Pro), record: recording, file: file, testName: testName, line: line)
    assertSnapshot(matching: sut, as: .image(on: .iPhone13Pro, traits: traitDarkMode), record: recording, file: file, testName: testName, line: line)
    assertSnapshot(matching: sut, as: .image(on: .iPhone13Pro(.landscape)), record: recording, file: file, testName: testName, line: line)
    assertSnapshot(matching: sut, as: .image(on: .iPadPro12_9(.landscape)), record: recording, file: file, testName: testName, line: line)
}
