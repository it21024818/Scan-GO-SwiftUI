# Project Name - Scan&Go 2.0
# Student Id - IT21024818
# Student Name - Dissanayake D.M.D.B

#### 01. Brief Description of Project - Scan&Go is a self-checkout mobile application designed for supermarket users. It allows customers to scan product barcodes, add them to a virtual cart, and pay for their purchases directly on their phones, eliminating the need to wait in traditional checkout lines.
#### 02. Users of the System - Supermarket Customers: The primary users are shoppers who want a faster and more convenient checkout experience.
#### 03. What is unique about your solution - Focus on a clean and user-friendly interface for a smooth shopping experience.
#### 04. Briefly document the functionality of the screens you have (Include screen shots of images)

Screen 1: Login/Registration

![IMG_5369](https://github.com/SE4020/SE4020-Assignment1-it21024818/assets/87381428/5d2a6e7b-ce5f-4f05-887c-13907b1dc44e)
![IMG_5370](https://github.com/SE4020/SE4020-Assignment1-it21024818/assets/87381428/8d0d027b-6354-4630-9944-593690a63a43)

Functionality: Users can either login with existing credentials or create a new account.
UI Components: Text fields for username/password or email/password, buttons for login and registration.

Screen 2: Home Page

![IMG_5366](https://github.com/SE4020/SE4020-Assignment1-it21024818/assets/87381428/4fc36ee7-85d0-4f7f-872d-d6859f3ad109)

Functionality: Displays current promotions and allows access to product scanning.
UI Components: Carousel or list showcasing supermarket promotions, button to access the barcode scanner.

Screen 3: Barcode Scanner

![IMG_5367](https://github.com/SE4020/SE4020-Assignment1-it21024818/assets/87381428/7bebd910-c556-4ccb-ae21-dee57ff4ac7b)

Functionality: Users scan product barcodes using the phone's camera. The app retrieves product information and adds it to the cart upon confirmation.
UI Components: Camera viewfinder, confirmation button to add scanned item.

Screen 4: Cart

![IMG_5528](https://github.com/SE4020/SE4020-Assignment1-it21024818/assets/87381428/2cbe48ac-2e77-4ed9-bf04-10fb328ba393)

Functionality: Users can review scanned items, adjust quantities, and proceed to checkout.
UI Components: List of scanned items with names, prices, quantities (if applicable), edit/remove buttons, total amount.

Screen 6: Profile

Functionality: Users can view their profile details, past orders, and manage account settings.
UI Components: User information (name, email), order history, settings options.

#### 05. Give examples of best practices used when writing code
Error Handling: Implement proper error handling mechanisms to gracefully handle unexpected situations during scanning, payment processing, etc.
```
extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Username", message: "Please enter a valid username.")
    }
}
```

Descriptive Naming Conventions: Use clear and concise variable and function names that reflect their purpose (e.g., scannedProducts, calculateTotal).
```
AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
    guard let self = self else { return }
    
    if let error = error {
        AlertManager.showRegistrationErrorAlert(on: self, with: error)
        return
    }
    
    if wasRegistered {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    } else {
        AlertManager.showRegistrationErrorAlert(on: self)
    }
}
```

Modular Code: Break down the code into well-defined functions and classes for better organization and maintainability.
```
struct CartItem {
    let image: UIImage
    let name: String
    let price: Double
    let description: String
    var quantity: Int
}
```

Code Comments: Add comments to explain complex logic and improve code readability for future reference.
```
// Ensure the detected metadata type is supported (e.g., EAN13, QR)
guard let barcode = metadataObject.stringValue else {
    // If metadata type is not supported, do nothing
    return
}

// Print the scanned barcode to the console
print("Scanned Barcode: \(barcode)")

// Display the scanned barcode on the screen
DispatchQueue.main.async {
    let alertController = UIAlertController(title: "Scanned Barcode", message: barcode, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alertController, animated: true, completion: nil)
}
```

#### 06. UI Components used

~ UIButton: Buttons for login, registration, adding items, checkout, etc.
~ UITextfield: Text fields for username, password, email, etc.
~ UIImageView: To display promotional images on the home screen.
~ UITableView: To display a list of scanned items in the cart screen.
~ UINavigationController: Manages navigation between different screens within the app.

#### 07. Testing carried out

Unit Testing: Focus on testing core functionalities like user login, product information retrieval, and basic calculations. 
```
    func testLogin() throws {
        let expectation = self.expectation(description: "Login")

        let loginUserRequest = LoginUserRequest(email: "testUser@test.com", password: "testPassword")
        authService.signIn(with: loginUserRequest) { error in
            XCTAssertNil(error, "Login should succeed with valid credentials")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoginWithInvalidCredentials() throws {
        let expectation = self.expectation(description: "Invalid Login")

        let loginUserRequest = LoginUserRequest(email: "invalidUser@gmail.com", password: "invalidPassword")
        authService.signIn(with: loginUserRequest) { error in
            XCTAssertNotNil(error, "Login should fail with invalid credentials")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
```

UI Testing: Automate tests to validate user interface elements like button clicks, field validation, error messages, and overall checkout flow. 
```
    func testRegisterFieldValidation() throws {
        let app = XCUIApplication()
        app.launch()

        let usernameField = app.textFields["Username"]
        let emailField = app.textFields["Email Address"]
        let passwordField = app.secureTextFields["Password"]
        let registerButton = app.buttons["Sign Up"]

        // Enter invalid data into the text fields
        usernameField.tap()
        usernameField.typeText("")

        emailField.tap()
        emailField.typeText("invalidEmail")

        passwordField.tap()
        passwordField.typeText("short")

        // Tap the register button
        registerButton.tap()

        // Check if the appropriate error message is displayed
        XCTAssertTrue(app.staticTexts["Please enter a valid username, email, and password."].exists)
    }

    func testLoginErrorMessage() throws {
        let app = XCUIApplication()
        app.launch()

        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Log In"]

        // Enter invalid data into the text fields
        usernameField.tap()
        usernameField.typeText("invalidUser")

        passwordField.tap()
        passwordField.typeText("invalidPassword")

        // Tap the login button
        loginButton.tap()

        // Check if the appropriate error message is displayed
        XCTAssertTrue(app.staticTexts["Invalid username or password."].exists)
    }
```

#### 08. Documentation 

(a) Design Choices

Rationale for UI Design:
~Focused on a minimalistic and intuitive interface for ease of use.
~Placed core functionalities (scanning, cart access) prominently for quick navigation.
~Used clear and consistent icons for buttons and menus.

MVC Architecture: 
~The app utilizes Model-View-Controller (MVC) architecture for separation of concerns. This promotes cleaner code, easier maintenance, and improved testability.
~The Model layer handles data management, product information retrieval, and cart calculations.
~The View layer manages the user interface elements and displays information based on the Model.
~The Controller layer handles user interactions, processes user input, and updates the Model accordingly.

(b) Implementation Decisions

Firebase for Authentication:
~Firebase offers a user-friendly and scalable solution for user login and registration.
~Considered alternatives like custom backend development but Firebase simplified the process.

Third-Party Barcode Scanner Library:
~Integrated a pre-built barcode scanning library to save development time and ensure accuracy.
~Evaluated building a custom scanner but the library offered faster implementation.

(c) Challenges

Balancing Features and Development Time:
~Aimed to include core functionalities within the project timeframe.
~Prioritized features essential for the core self-checkout experience.

Data Security and User Privacy:
~Emphasized secure data storage for user information and purchase history (if applicable).
~Implemented best practices for handling sensitive data according to privacy regulations.

#### 09. Reflection

~Implement additional features like shopping list creation and loyalty program integration.
~Enhance the user interface with animations and micro-interactions for a more polished experience.
~Explore integrating with the supermarket's backend systems for real-time product information and inventory updates.

  

