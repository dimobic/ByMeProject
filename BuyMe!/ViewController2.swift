//
//  ViewController2.swift
//  BuyMe!
//
//  Created by Dima Chirukhin on 06.03.2021.
//

import UIKit

protocol addItemControllerDelegate : class {
    func addItemCancel ( _controller: ViewController2)
    func addItemDone( _controller: ViewController2, didFinishAdding item: element)
    func editItemDone( _controller: ViewController2, didFinishAdding item: element)

}

class ViewController2: UIViewController, UITextFieldDelegate {
    let tableView = UITableView()
    weak var delegate :  addItemControllerDelegate! = nil
    let placeholderData = ["Name", "Surname", "Email", "Phone number", "Password", "Repeat password"]
    var ItemToEdit : element?

    @objc func CancelTap(){
        self.navigationController?.popViewController(animated: true)
        delegate.addItemCancel(_controller: self)
    }
    @objc func DoneTap(){
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TableViewCell
        if cell.TextEnter.text != nil && cell.TextEnter.text!.trimmingCharacters(in: .whitespaces) != "" {
            
            if ItemToEdit != nil {
                ItemToEdit!.text = cell.TextEnter.text!
                delegate?.editItemDone(_controller: self, didFinishAdding: ItemToEdit!)
            } else {
                let item = element()
                item.text =  cell.TextEnter.text!
                delegate?.addItemDone(_controller: self, didFinishAdding: item)
            }
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        view.backgroundColor = .white
        if ItemToEdit != nil {
            navigationItem.title = "EditItem"
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: 0, section: 0)) as! TableViewCell
            cell.TextEnter.text = ItemToEdit!.text
        } else {
            navigationItem.title = "AddNew"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DoneTap))
        //navigationItem.leftBarButtonItem?.isEnabled = false
        
        
    }
    
 
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
 
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
//----------------------------------------------------------------------------------
extension ViewController2: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        return nil
    }

}
//-----------------------------------------------------------------------------------
extension ViewController2: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.placeholder = placeholderData[indexPath.row]
        if indexPath.row == 0 {
            cell.TextEnter.becomeFirstResponder()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
