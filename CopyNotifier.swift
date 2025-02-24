import Cocoa

class CopyNotifier: NSObject {
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    private var eventMonitor: Any?
    
    override init() {
        super.init()
        print("CopyNotifier: Initializing...")
        setupStatusItem()
        setupPopover()
        registerHotKey()
        print("CopyNotifier: Initialization complete")
    }
    
    private func setupStatusItem() {
        print("CopyNotifier: Setting up status item...")
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.title = "📋"  // Using an emoji instead of system image for better compatibility
            print("CopyNotifier: Status item setup complete")
        } else {
            print("CopyNotifier: Failed to setup status item button")
        }
    }
    
    private func setupPopover() {
        print("CopyNotifier: Setting up popover...")
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 100, height: 40)
        popover?.behavior = .transient
        
        let viewController = NSViewController()
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        let label = NSTextField(labelWithString: "Copy")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alignment = .center
        label.font = NSFont.systemFont(ofSize: 16, weight: .medium)
        
        view.addSubview(label)
        viewController.view = view
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        popover?.contentViewController = viewController
        print("CopyNotifier: Popover setup complete")
    }
    
    private func registerHotKey() {
        print("CopyNotifier: Registering hotkey monitor...")
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            print("CopyNotifier: Key event detected - keyCode: \(event.keyCode), modifiers: \(event.modifierFlags)")
            if event.modifierFlags.contains(.command) && event.keyCode == 8 { // 8 is the key code for 'C'
                print("CopyNotifier: Command+C detected!")
                DispatchQueue.main.async {
                    self?.showPopover()
                }
            }
        }
        
        if eventMonitor != nil {
            print("CopyNotifier: Hotkey monitor registered successfully")
        } else {
            print("CopyNotifier: Failed to register hotkey monitor")
        }
    }
    
    private func showPopover() {
        print("CopyNotifier: Attempting to show popover...")
        if let button = statusItem?.button {
            popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            print("CopyNotifier: Popover shown")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.popover?.close()
                print("CopyNotifier: Popover closed")
            }
        } else {
            print("CopyNotifier: Failed to show popover - button not found")
        }
    }
    
    deinit {
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            print("CopyNotifier: Hotkey monitor removed")
        }
    }
}
