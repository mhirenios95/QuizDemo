//
//  Common.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import Foundation
import UIKit

let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class Common {
    
    static let shared = Common()
     func showAlert(message:String, vc: UIViewController) {
        let alert = UIAlertController(title: "Quiz", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
     func viewController(_ name: String, onStoryboard storyboardName: String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name)
    }

    func addrightViewTextfield(textField:UITextField) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ico_downArrow"), for: .normal)
        button.isUserInteractionEnabled = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        textField.rightView = button
        textField.rightViewMode = .always
    }

}


//MARK: Design class
extension UIView {
    func setBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8
    }
}
extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}


