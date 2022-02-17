import Cocoa

class JustTextMenuViewController: NSViewController {
  //connect to label
  
  @IBAction func quit(sender: NSButton) {
    NSApplication.shared.terminate(sender)
  }
}

extension JustTextMenuViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> JustTextMenuViewController {
    let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
    let identifier = NSStoryboard.SceneIdentifier(rawValue: "JustTextMenuViewController")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? JustTextMenuViewController else {
      fatalError("Why cant i find JustTextMenuViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
