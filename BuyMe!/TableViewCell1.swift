
import UIKit

class TableViewCell1: UITableViewCell {

    lazy var TextLabel : UILabel = {
        let Text = UILabel()
        Text.translatesAutoresizingMaskIntoConstraints = false
        Text.font = UIFont.systemFont(ofSize: 17)
        Text.backgroundColor = .systemGray6
        Text.textAlignment = .center
        Text.clipsToBounds = true
        return Text
    } ()
    
    lazy var CheckLabel : UILabel = {
        let Text = UILabel()
        Text.translatesAutoresizingMaskIntoConstraints = false
        Text.font = UIFont.systemFont(ofSize: 17)
        return Text
    } ()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
        accessoryType = .detailButton
    }
    @objc func Detail(){
        
        /*let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TableViewCell
        if cell.TextEnter.text != nil && cell.TextEnter.text!.trimmingCharacters(in: .whitespaces) != "" {
            let item = element()
            item.text =  cell.TextEnter.text! //element(tex: cell.TextEnter.text!, check: false)
            delegate?.addItemDone(_controller: self, didFinishAdding: item)*/
        }

    func initConstraints(){
        self.contentView.addSubview(TextLabel)
        self.contentView.addSubview(CheckLabel)
 
        TextLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        TextLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        TextLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TextLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        CheckLabel.rightAnchor.constraint(equalTo: self.TextLabel.leftAnchor).isActive = true
        CheckLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        CheckLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        CheckLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
            
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}

