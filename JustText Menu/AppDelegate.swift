import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
  let popover = NSPopover()
  var eventMonitor: EventMonitor?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    if let button = statusItem.button {
      button.image = NSImage(named: NSImage.Name(rawValue: "StatusBarButtonImage"))
      button.action = #selector(AppDelegate.togglePopover(_:))
    }
    
    popover.contentViewController = JustTextMenuViewController.freshController()
    
    eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
      if let strongSelf = self, strongSelf.popover.isShown {
        strongSelf.closePopover(sender: event)
      }
    }
  }
  
  @objc func togglePopover(_ sender: Any?) {
    if popover.isShown {
      closePopover(sender: sender)
    } else {
      showPopover(sender: sender)
    }
  }

  func showPopover(sender: Any?) {
    if let button = statusItem.button {
      popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      eventMonitor?.start()
    }
  }

  func closePopover(sender: Any?) {
    popover.performClose(sender)
    eventMonitor?.stop()
  }

  func constructMenu() {
    let menu = NSMenu()

    menu.addItem(NSMenuItem(title: "Quit JustText Menu", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

    statusItem.menu = menu
  }

}
