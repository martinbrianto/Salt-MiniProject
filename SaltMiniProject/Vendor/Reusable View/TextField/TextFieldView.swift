//
//  TextFieldView.swift
//  Salma
//
//  Created by gratianus.brianto on 21/04/22.
//

import UIKit
import RxSwift


public struct Textfield {
    let title: String
    let placeholder: String
    let textContentType: UITextContentType
}

@IBDesignable public class TextFieldView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfieldBackground: UIView!
    @IBOutlet weak var textfieldView: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Variable
    public var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                textfieldBackground.layer.borderWidth = 1
                textfieldBackground.layer.borderColor = UIColor(named: "Red")?.cgColor
                textfieldBackground.backgroundColor = UIColor(named: "Error50")
                errorMessageLabel.text = errorMessage
                errorMessageLabel.isHidden = false
            } else {
                textfieldBackground.layer.borderWidth = 0
                textfieldBackground.backgroundColor = UIColor(named: "PlaceholderBg")
                errorMessageLabel.isHidden = true
            }
        }
    }
    
    @IBInspectable public var title: String = "Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable public var placeholder: String = "Placeholder" {
        didSet {
            textfieldView.placeholder = placeholder
        }
    }
    
    public var text: String {
        get {
            return textfieldView.text ?? ""
        }
    }
    
    @IBInspectable public var textContentType: UITextContentType = .emailAddress {
        didSet {
            textfieldView.textContentType = textContentType
            if textContentType == .password {
                textfieldView.isSecureTextEntry = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
