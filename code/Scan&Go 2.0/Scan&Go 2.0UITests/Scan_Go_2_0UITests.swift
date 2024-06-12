//
//  Scan_Go_2_0UITests.swift
//  Scan&Go 2.0UITests
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import XCTest

final class Scan_Go_2_0UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch() // Ensure your app is launched before each test
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testLoginSuccess() throws {
        // Navigate to the Login screen if not already there
        XCTAssertTrue(app.navigationBars["Login"].exists)

        // Fill in email and password fields
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("testpassword")

        // Tap on the sign in button
        let signInButton = app.buttons["Sign in"]
        XCTAssertTrue(signInButton.exists)
        signInButton.tap()

        // Assert that the next screen is loaded after successful login
        XCTAssertTrue(app.navigationBars["NextScreen"].exists) // Replace "NextScreen" with the identifier of the next screen
    }

    func testLoginFailure() throws {
        // Navigate to the Login screen if not already there
        XCTAssertTrue(app.navigationBars["Login"].exists)

        // Fill in incorrect email and password fields
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("invalid@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("invalidpassword")

        // Tap on the sign in button
        let signInButton = app.buttons["Sign in"]
        XCTAssertTrue(signInButton.exists)
        signInButton.tap()

        // Assert that appropriate error message is displayed
        XCTAssertTrue(app.staticTexts["Invalid email or password."].exists)
    }
    
    func testRegistrationSuccess() throws {
        // Navigate to the Register screen if not already there
        XCTAssertTrue(app.navigationBars["Sign up"].exists)

        // Fill in registration fields
        let fullNameTextField = app.textFields["Full Name"]
        XCTAssertTrue(fullNameTextField.exists)
        fullNameTextField.tap()
        fullNameTextField.typeText("John Doe")

        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("testpassword")

        // Tap on the sign up button
        let signUpButton = app.buttons["Sign up"]
        XCTAssertTrue(signUpButton.exists)
        signUpButton.tap()

        // Assert that the success message is displayed after successful registration
        XCTAssertTrue(app.staticTexts["Registration successful! Please log in."].exists)
    }

    func testRegistrationFailure() throws {
        // Navigate to the Register screen if not already there
        XCTAssertTrue(app.navigationBars["Sign up"].exists)

        // Fill in registration fields with invalid data
        let fullNameTextField = app.textFields["Full Name"]
        XCTAssertTrue(fullNameTextField.exists)
        fullNameTextField.tap()
        fullNameTextField.typeText("")

        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("invalidemail")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("short")

        // Tap on the sign up button
        let signUpButton = app.buttons["Sign up"]
        XCTAssertTrue(signUpButton.exists)
        signUpButton.tap()

        // Assert that appropriate error message is displayed
        XCTAssertTrue(app.staticTexts["Invalid email or password."].exists)
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
