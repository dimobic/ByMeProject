import UIKit


class ViewController: UIViewController, addItemControllerDelegate {
    func addItemDone(_controller: ViewController2, didFinishAdding item: element) {
        Item.append(item)
        tableView.reloadData()
        saveItems ()
        navigationController?.popViewController(animated: true)
    }
    
    func editItemDone(_controller: ViewController2, didFinishAdding item: element) {
        if let Index = Item.firstIndex(of: item) {
            Item[Index].text = item.text
            tableView.reloadData()
        }
        saveItems ()
        navigationController?.popViewController(animated: true)
    }
    
    func addItemCancel(_controller: ViewController2) {
        _controller.navigationController?.popViewController(animated: true)
    }
   
    let tableView = UITableView()

    @objc func AddItem(){
         let viewController = ViewController2()
        viewController.delegate = self
         self.navigationController?.pushViewController(viewController, animated: true)
    }
    override func loadView() {
        super.loadView()
        setupTableView()
        navigationItem.title = "CheckList"
        loadItems()
        //tableView.isEditing = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddItem))
  }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(TableViewCell1.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func documentDirect () -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath () -> URL{
        return documentDirect()	.appendingPathComponent("CheckList.plist")
    }
    func saveItems () {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(Item)
            try data.write ( to :  dataFilePath(), options: Data.WritingOptions.atomic)
        }
        catch {
            print("Error encoding item array!")
        }
    }
    func loadItems ()  {
        let path = dataFilePath()
        if let data = try? Data( contentsOf: path) {
            let decoder = PropertyListDecoder()
            do{
                Item = try decoder.decode([element].self, from: data)
            }
            catch {
                print("Error decoding item array!")
            }
        }
    }
    
}
//------------------------------------------------------------------
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath) != nil{
            if  Item[indexPath.row].checkmark == false {
                Item[indexPath.row].checkmark = true
            } else {
                Item[indexPath.row].checkmark = false
            }
            saveItems ()
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let viewController = ViewController2()
        viewController.delegate = self
        viewController.ItemToEdit = Item[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        if tableView.isEditing {
        return.none
        } else{
            return .delete
        }
    }
    */
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Удалить"
    }
}
//-----------------------------------------------------------------------------------
extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell1
        let item = Item[indexPath.row]
        if  Item[indexPath.row].checkmark == true {
            cell.CheckLabel.text = "👌🏻 ✔️"
        } else {
            cell.CheckLabel.text = ""
        }
        cell.TextLabel.text = item.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        Item.remove(at: indexPath.row)
        saveItems ()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    /*func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        /*let movedObject = self.arr[sourceIndexPath.row]
        arr.remove(at: sourceIndexPath.row)
        arr.insert(movedObject, at: destinationIndexPath.row)*/
        
        let movedObject = items.shared.item[sourceIndexPath.row]
        items.shared.del(index: sourceIndexPath.row)
        //chanItem(nameItem: movedObject["name"] as! String, compl : movedObject["com"] as! Bool,sum : movedObject["sum"] as! String ,at: destinationIndexPath.row)7931
    }
    */
}


