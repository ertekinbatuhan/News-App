//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Batuhan Berk Ertekin on 11.05.2024.
//

import XCTest

final class NewsAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testTabBar() throws {
     let app = XCUIApplication()
     app.launch()
    let tabBar = XCUIApplication().tabBars["Tab Bar"]
    tabBar.buttons["Favorites"].tap()
    tabBar.buttons["News"].tap()
    tabBar.buttons["For you"].tap()
    tabBar.buttons["Settings"].tap()
    tabBar.buttons["Home"].tap()
        
    }
    
    func testTableView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables.firstMatch.tap()
    }
    
    func testFavoriteView() throws {
         let app = XCUIApplication()
         app.launch()
         app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        
    }
    
        func testSqlView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["For you"].tap()
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.image, identifier:"technology").element.tap()
        app.navigationBars["Technology"].buttons["Categories"].tap()
        cellsQuery.otherElements.containing(.image, identifier:"science").element.tap()
        app.navigationBars["Science"].buttons["Categories"].tap()
        cellsQuery.otherElements.containing(.image, identifier:"sports").element.tap()
        app.navigationBars["Sports"].buttons["Categories"].tap()
        cellsQuery.otherElements.containing(.image, identifier:"economy").element.tap()
        app.navigationBars["Economy"].buttons["Categories"].tap()
    }
    
        func testSettingsView() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tabBars["Tab Bar"].buttons["Settings"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
