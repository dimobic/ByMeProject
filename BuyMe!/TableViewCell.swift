//
//  TableViewCell.swift
//  BuyMe!
//
//  Created by Dima Chirukhin on 09.03.2021.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {

    var placeholder: String? {
    didSet {
             guard let item = placeholder else {return}
            TextEnter.placeholder = item
        }
    }
    
    func text() -> String {
        return TextEnter.text!
    }
    
   lazy var TextEnter : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17)
        field.returnKeyType = .done
        field.autocapitalizationType = .sentences
        field.backgroundColor = .systemGray6
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.clipsToBounds = true
        field.autocorrectionType = .no
    field.enablesReturnKeyAutomatically = true 
        return field
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        TextEnter.resignFirstResponder()
        return true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()

    }

    func initConstraints(){
        self.contentView.addSubview(TextEnter)
 
        TextEnter.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        TextEnter.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        TextEnter.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextEnter.widthAnchor.constraint(equalToConstant: 200).isActive = true
        TextEnter.delegate = self

    }
            
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}

