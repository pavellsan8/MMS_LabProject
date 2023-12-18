import UIKit

class CustomerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var totalQuantity: Int = 0
    var totalPrice: Double = 0.0
    var arr: [dataItem] = []
    
    @IBOutlet weak var namaCustomer: UILabel!
    @IBOutlet weak var tableViewCustomer: UITableView!
    @IBOutlet weak var quantityNumber: UILabel!
    @IBOutlet weak var priceNumber: UILabel!
    
    var nama: String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductsTableViewCell
        cell.itemTitleProduct.text = arr[indexPath.row].titleProduct
        cell.itemCategoryProduct.text = arr[indexPath.row].categoryProduct.rawValue
        cell.itemDetailProduct.text = arr[indexPath.row].description
        cell.itemPriceProduct.text = "$\(String(describing: arr[indexPath.row].priceProduct))"
        cell.itemImageProduct.image = UIImage(named: arr[indexPath.row].imageProduct)
        cell.quantityField.tag = indexPath.row
        cell.quantityField.addTarget(self, action: #selector(quantityFieldDidChange(_:)), for: .editingChanged)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func initData(){
        arr.append(dataItem(priceProduct: 300, titleProduct: "God Of War : Ragnarok", categoryProduct: CategoryGame.adventure, description: "Adventure story games about Gods", imageProduct: "godofwar"))
        arr.append(dataItem(priceProduct: 250, titleProduct: "Red Dead Redemption 2", categoryProduct: CategoryGame.adventure, description: "Open world game for you who want to be cowboy", imageProduct: "rdr2"))
        arr.append(dataItem(priceProduct: 500, titleProduct: "The Last Of Us", categoryProduct: CategoryGame.horror, description: "Survival story games in the zombie apocalypse", imageProduct: "tlou"))
        arr.append(dataItem(priceProduct: 200, titleProduct: "Uncharted 4", categoryProduct: CategoryGame.adventure, description: "Adveture story games and parkour mode", imageProduct: "uncharted4"))
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            initData()
            tableViewCustomer.dataSource = self
            tableViewCustomer.delegate = self
            namaCustomer.text = "Hello, User \(nama ?? "")"
            updateTotalQuantityLabel()
            quantityNumber.text = String(totalQuantity)
            priceNumber.text = String(totalPrice)
        }
        
        @objc func quantityFieldDidChange(_ textField: UITextField) {
            if let quantity = Int(textField.text ?? ""), quantity >= 0 {
                arr[textField.tag].productQuantity = quantity
                updateTotalQuantityLabel()
            }
        }

        func updateTotalQuantityLabel() {
            totalQuantity = arr.reduce(into: 0) { $0 + $1.productQuantity}
            quantityNumber.text = "\(totalQuantity)"
        }
    
    @IBAction func checkoutProductButton(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(identifier: "checkout_view") {
            let checkView = nextView as! CheckoutViewController
            navigationController?.setViewControllers([checkView], animated: true)
        }
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Attention", message: "Are you sure want to logout?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) {
            (action) in self.logoutBtn()
        }
        let no = UIAlertAction(title: "Cancel", style: .destructive)
                
        alert.addAction(no)
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
    func logoutBtn() {
        if let nextView = storyboard?.instantiateViewController(identifier: "rootView") {
            let rootView = nextView as! ViewController
            navigationController?.setViewControllers([rootView], animated: true)
        }
    }
}
