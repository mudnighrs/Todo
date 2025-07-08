import UIKit

class TodoViewController: UITableViewController {
    
    
    

    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // fretrieve data
        if let  items = (defaults.array(forKey: "TodoListArray") as? [String]){
            itemArray=items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = itemArray[indexPath.row]
        
        cell.contentConfiguration = content

        return cell
    }
    
    // this method is triggered whrn user selecdts a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Code to respond to selection
        //let selectedItem = itemArray[indexPath.row]
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        tableView.deselectRow(at: indexPath, animated: true)// first gray then gack to previous color
        
        
    
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todo Item ", message: "", preferredStyle: .alert)
        
        // triggered when add item in  alert is pressed
        let action = UIAlertAction(title: "Add  Item", style: .default) { (action) in
            // what will happen when user clicjks the add new item button on ui alert
            
            // item was added in arrasy but not displayed in table view
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            // add item to table view
            self.tableView.reloadData()
            
            
        }
        // triggererd when alert appears on screen
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item ..."
            textField=alertTextField
          }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
}
