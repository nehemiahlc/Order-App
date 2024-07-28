//
//  MenuDetailViewController.swift
//  OrderApp
//
//  Created by Nehemiah Chandler on 7/24/24.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var detailTextLabel: UILabel!
    @IBOutlet var addToOrderButton: UIButton!
    
    let menutItem: MenuItem
    
    init?(coder: NSCoder, menuItem: MenuItem){
    self.menutItem = menuItem
    super.init(coder: coder)
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MenuController.shared.updateUserActivity(with: .menuItemDetail(menutItem))
    }
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            self.addToOrderButton.transform =
            CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform =
            CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
        MenuController.shared.order.menuItems.append(menutItem)
    }
    func updateUI() {
        nameLabel.text = menutItem.name
        priceLabel.text = menutItem.price.formatted(.currency(code: "usd"))
        detailTextLabel.text = menutItem.detailText
        
        Task.init {
            if let image = try? await
                MenuController.shared.fetchImage(from: menutItem.imageURL) {
                imageView.image = image
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
