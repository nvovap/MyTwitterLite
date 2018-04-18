//
//  LiteTwitterUITests.swift
//  LiteTwitterUITests
//
//  Created by Vladimir Nevinniy on 4/17/18.
//  Copyright © 2018 Vladimir Nevinniy. All rights reserved.
//

import XCTest


class LiteTwitterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()

        
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"The Birds Nest")/*[[".cells.containing(.staticText, identifier:\"17 апреля 2018 г.\")",".cells.containing(.staticText, identifier:\"@Bmore_BirdsNest\")",".cells.containing(.staticText, identifier:\"The Birds Nest\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Add to favorite"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Favorites"].tap()
        
        

        tabBarsQuery.buttons["More"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"The Birds Nest")/*[[".cells.containing(.staticText, identifier:\"17 апреля 2018 г.\")",".cells.containing(.staticText, identifier:\"@Bmore_BirdsNest\")",".cells.containing(.staticText, identifier:\"The Birds Nest\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*//*@START_MENU_TOKEN@*/.buttons["Delete from favorite"]/*[[".cells.buttons[\"Delete from favorite\"]",".buttons[\"Delete from favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
                
    }
    
}
