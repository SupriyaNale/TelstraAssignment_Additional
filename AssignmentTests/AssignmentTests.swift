//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Yash on 11/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    
    var viewControllerObj: ViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewControllerObj = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        XCTAssertNotNil(viewControllerObj, "ViewController not initiated properly")
        
        viewControllerObj?.performSelector(onMainThread: #selector(viewControllerObj?.loadView), with: nil, waitUntilDone: true)
        viewControllerObj?.performSelector(onMainThread: #selector(viewControllerObj?.viewDidLoad), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - UITableView Testcases
    func testThatViewConformsToTableViewDelegate() {
        XCTAssertTrue(viewControllerObj!.conforms(to: UITableViewDelegate.self), "ViewController conforms to UITableViewDelegate")
    }
    
    func testThatViewConformsToTableViewDataSources() {
        XCTAssertTrue(viewControllerObj!.conforms(to: UITableViewDataSource.self), "ViewController conforms to UITableViewDataSources")
    }
    
    func testThatViewLoads() {
        XCTAssertNotNil(viewControllerObj, "ViewController View not initiated properly")
    }
    
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(viewControllerObj?.tableView, "TableView not initiated")
    }

    
}
