import Cocoa

// Create and configure the application
print("Starting application...")
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// Set activation policy to regular to ensure the app can receive events
app.setActivationPolicy(.accessory)

print("Application configured, running main loop...")
app.run()

class AppDelegate: NSObject, NSApplicationDelegate {
    var copyNotifier: CopyNotifier?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("Application did finish launching")
        copyNotifier = CopyNotifier()
        
        // Request permissions for accessibility
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessibilityEnabled = AXIsProcessTrustedWithOptions(options)
        
        print("Accessibility permissions status: \(accessibilityEnabled)")
        
        if !accessibilityEnabled {
            print("⚠️ Please grant accessibility permissions in System Preferences")
            let alert = NSAlert()
            alert.messageText = "Accessibility Permissions Required"
            alert.informativeText = "Please grant accessibility permissions in System Preferences > Security & Privacy > Privacy > Accessibility"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Open System Preferences")
            alert.addButton(withTitle: "Quit")
            
            let response = alert.runModal()
            if response == .alertFirstButtonReturn {
                NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))
            }
            NSApplication.shared.terminate(nil)
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        print("Application will terminate")
    }
}
