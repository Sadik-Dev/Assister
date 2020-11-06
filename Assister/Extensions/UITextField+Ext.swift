import UIKit

enum LinePosition {
    case top
    case bottom
}

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor(named: "primary")?.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
