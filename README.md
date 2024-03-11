## Contents
- [Requirements](#requirements)
- [Configuring DixaMessenger](#configuring-dixamessenger)
    - [Log level](#log-level)
    - [Push Environment](#push-environment)
- [Authentication](#authentication)
- [Launching the Messenger](#launching-the-messenger)
- [Unread messages](#unread-messages)
- [Push notification handling](#push-notification-handling)
- [Supporting nfo files](#supporting-nfo-files)

## Requirements
- iOS 15+

## Installation
The Dixa Messenger SDK can be installed using Swift package manager, cocoa pods or by manually downloading and adding it to the project.

### Swift package manager (preferred)

In Xcode add a package dependency to your project with the following URL: 
```
"https://github.com/dixahq/ios-messenger"
```

### Cocoapods

In your pod file, add: 
```
pod 'DixaMessengerKit', :git => 'https://github.com/dixahq/ios-messenger', :branch => 'main'
```

### Manual
The XCFramework can be downloaded from our [release page](https://github.com/dixahq/ios-messenger/releases). The unzipped XCFramework needs to be placed on the Framewrok searchpath of your Xcode project, and imported into the project, then configured to `Embed and sign`.

## Configuring DixaMessenger

Our suggestion for configuring the DixaMessenger, is to do so in the AppDelegate.
The following is an example of how it could be done:
```swift
import DixaMessenger

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Creates a new DixaConfiguration and configures the DixaMessenger client
        let config = DixaConfiguration()
            .logLevel(.all)
            .apikey("<api-key-goes-here>")
        #if DEBUG
            // If you would like to have pushnotifications when developing your application
            // you can set the push environment to .sandbox - the default is .production
            // To receive push messages, remember to upload your push-certificate to dixa.com
            .pushEnvironment(.sandbox)
        #endif

        Messenger.configure(config)
        
        return true
    }
}
```

## Configuration API
```swift
/// Creates a new configuration
DixaConfiguration(token: String, logLevel: LogLevel, pushEnvironment: PushEnvironment)

/// Creates a new empty configuration - minimum requirement to be set is apiKey
DixaConfiguration()

/// Creates a new Configuration with the supplied messenger token
/// - Parameter token: Token to be used to identify the Client
/// - Returns: Configuration
DixaConfiguration().apikey(_: String) -> DixaConfiguration

/// Creates a new Configuration with the supplied log level
/// - Parameter logLevel: Log level to be used when launching the Client
/// - Returns: Configuration
DixaConfiguration().logLevel(_: LogLevel) -> DixaConfiguration

/// The environment determines whether the SDK is targeting Production or Sandbox when sending push notifications
/// - Parameter environment: Environment to send push notifications to
/// - Returns: Configuration
DixaConfiguration().pushEnvironment(_: PushEnvironment) -> DixaConfiguration

/// The `supportedLaguages` array overrides the language settings from the Agent Interface.
/// This setting only affects the conversation language, not the UI language. The UI language is automatically set based on the system settings.
/// - Parameter supportedLanguages: a list of conversation languages supported by the SDK (two letter language code)
/// - Returns: Configuration
DixaConfiguration().supportedLanguages(_: [String]) -> DixaConfiguration

/// Configures the Messenger
/// - Parameter config: Configuration to configure the Client
Messenger.configure(_: DixaConfiguration)

```

Example:
```swift
// One line configuration
DixaConfiguration(token: "<api-key-goes-here>", logLevel: .error, pushEnvironment: .sandbox)

// Note that the Configuration is a value type, and a new is returned when calling a convenience modifier
DixaConfiguration()
    .apiKey("<api-key-goes-here>")
    .logLevel(.error)
    .pushEnvironment(.sandbox) // default .production
    .supportedLanguages(["en", "da"])
```

### Log level
The messenger provides you with different options for logging information to the console.
By default, no messages is logged to console
```swift
/// This logging level will not print any messages
case none
/// Prints only the logs about critical events (e.g. invalid API key).
case error
/// Prints only the logs for warnings and critical events (e.g. failed to send a message). Includes ERROR logs.
case warning
/// Prints all the logs about all valuable events (e.g. message sent), includes WARNING and ERROR logs.
case all
```

example
```swift
config.logLevel(.error)
```

### Push Environment
By default, the push environment is set to `.production`, however, if you'd like you can set the pushEnvironment to `.sandbox` if you need to test push notifications while running your app in debug mode.

example
```swift
config.pushEnvironment(.sandbox)
```

## Authentication
You can decide to have your users identified. There are two types of authentication:

**Claimed**
Authentication is done using a username and email that the users provide.

```swift
/// Update the user credentials associated with the DixaMessenger
///
/// This can safely be called multiple times with the same username and email,
/// only if the username and/or email has changed the conversations will be wiped.
/// Note, that there's no validation on the email address
/// - Parameters:
///   - username: username to identify the user
///   - email: email to identify the user
Messenger.updateUserCredentials(username: String, email: String)

/// Removes stored credentials, if there's stored credentials
Messenger.clearUserCredentials()
```

**Verified**
Authentication is done using a JWE token, that is signed with one of the private keys, configured in the Dixa Messenger Dashboard. This token needs to be specified programatically, as opposed to the **Claimed** authentication where the SDK will ask the user to input their username and email.

```swift
/// Update the user authentication jwe-token
/// - Parameters:
///   - token: jwe token
Messenger.verifyUser(token: String)

/// Removes jwe-token, if it is stored.
Messenger.clearVerificationToken()
```

## Launching the Messenger
The Dixa Messenger is compatible with both UIKit and SwiftUI, allowing you to select the most appropriate function based on your UI framework. 
You need to create a button within the host application that, when pressed, will trigger the opening of the support interface.

**SwiftUI**

```swift
/// Creates a MessengerView as SwiftUI component.
///
/// - Returns: A `MessengerView` instance. Use this when you want to access the `MessengerView` directly.
///
/// Call this method as content to  .fullScreenCover modifier of your hosting view.
Messenger.openMessenger()
```

example
```swift
import SwiftUI
import DixaMessenger

struct YourHostingView: View {

    // MARK: - States
    @State var openMessenger: Bool = false

    var body: some View {
        VStack {
            Button {
                openMessenger.toggle()
            } label: {
                Text("Contact Support")
            }
        }
        .fullScreenCover(isPresented: $openMessenger) {
            Messenger.openMessenger()
        }
    }
}

#Preview {
    YourHostingView()
}
```


**UIKit**

All you need to do, is to supply a view controller from where the messenger should be presented.
The completion is called when the completion of  `.present(_: UIViewController, completion: (() -> Void)?)` is called.
```swift
/// Presents the messenger as a Modal presentation
///
/// Call openMessenger, when the user has tapped on a button to launch the Messenger Client.
/// The presentation style will be .fullScreen
/// - Parameter presentationController: The view controller from which the Messenger Client is to be presented
Messenger.openMessenger(from: UIViewController, completion: (() -> Void)? = nil)
```

## Unread messages
The SDK offers an option for the hosting application to show how many unread messages there is.
You can add yourself as a listener by calling the API like
```swift
Messenger.unreadMessagesCountListener(completion: @escaping (_ count: Int) -> Void)
```

## Push notification handling
To have DixaMessenger handle push messages, it requires that you do some footwork, since DixaMessenger doesn't automatically listens for notifications.

First of all, create a push certificate and upload this in the your Dixa account.

In the app, when you get a push token, forward that to the DixaMessenger
```swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messenger.pushNotification.register(deviceToken: deviceToken)
}
```

In your `UNUserNotificationCenterDelegate` implementation, let DixaMessenger check if the received notification is intended for the Messenger.
All checks that DixaMessenger does, to verify whether the notification is intended for the Messenger, is done in-app.
If the Notification was intended for the Messenger, it returns true when you call `Messenger.pushNotification.process(notification: , rootViewController: )` otherwise false.
Make sure to provide a ViewController from which it makes sense to present the Messenger in full-screen

As well, DixaMessenger contains some logic for when to show, or not show a notification `Messenger.pushNotification.presentNotification(, withCompletionHandler: )` will return true if the message was intended for the Messenger and false otherwise. 
If the notification wasn't intended for the messenger, you can handle the notification yourself.

```swift
extension YourNotificationHandlingObject: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        if !Messenger.pushNotification.process(notification: response.notification, rootViewController: someViewController) {
            // this notification wasn't intended for the DixaMessenger - please handle it :o)
        }
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if !Messenger.pushNotification.presentNotification(notification, withCompletionHandler: completionHandler) {
            // this notification wasn't intended for the DixaMessenger - please handle it :o)
            completionHandler([])
        }
    }
}
```

## Push notification API
```swift
/// Registers the deviceToken with DixaMessenger
Messenger.pushNotification.register(deviceToken: Data)

/// Processes the notification
///
/// If the notification could be processed by the DixaMessenger the return value is true, otherwise false
/// - Parameter notification: Notification to be processed by the SDK
/// - Parameter rootViewController: A view controller to launch the SDK from, if it's not already visible
/// - Returns: true if the notification was intended for the SDK and it could be processed otherwise false
Messenger.pushNotification.process(notification: UNNotification, rootViewController: UIViewController) -> Bool

/// Show a notification while the app is in foreground
///
/// If the notification is intended for the DixaMessenger the return value is true, otherwise false.
/// DixaMessenger will call the completionHandler, if the notification was intended for the SDK
/// - Parameters:
///   - notification: Notification to potentially be shown to the user
///   - completionHandler: Callback to UNNotificationCenter
/// - Returns: true if the notification was intended for the SDK and it could be processed otherwise false
Messenger.pushNotification.presentNotification(_: UNNotification, withCompletionHandler:(UNNotificationPresentationOptions) -> Void
    ) -> Bool)
```

## Uploading photos

To enable file uploads from iOS your app needs to add the `NSPhotoLibraryUsageDescription` key and description to the Info.plist file. 

