//
//  SegmentElementTests.swift
//  Formalist
//
//  Created by Indragie Karunaratne on 2016-06-07.
//  Copyright © 2016 Seed Platform, Inc. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import Formalist

class SegmentElementTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    private func segmentElementWithSelectedIndex(index: Int, value: FormValue<Int> = FormValue(0)) -> SegmentElement<Int> {
        let segments = [
            Segment(content: .Title("Segment 1"), value: 0),
            Segment(content: .Image(imageWithName("circle")), value: 1)
        ]
        value.value = index
        let element = SegmentElement(title: "Segment Element", segments: segments, selectedValue: value) {
            $0.titleLabel.textAlignment = .Center
            $0.titleLabel.textColor = .redColor()
            $0.segmentedControl.tintColor = .greenColor()
        }
        return element
    }
    
    func testRenderWithFirstSegmentSelected() {
        let element = segmentElementWithSelectedIndex(0)
        let elementView = renderElementForTesting(element)
        FBSnapshotVerifyView(elementView)
    }
    
    func testRenderWithSecondSegmentSelected() {
        let element = segmentElementWithSelectedIndex(1)
        let elementView = renderElementForTesting(element)
        FBSnapshotVerifyView(elementView)
    }
    
    func testUpdateViewByUpdatingValue() {
        let value = FormValue(0)
        let element = segmentElementWithSelectedIndex(0, value: value)
        let elementView = element.render() as! SegmentElementView
        value.value = 1
        XCTAssertEqual(1, elementView.segmentedControl.selectedSegmentIndex)
    }
}
