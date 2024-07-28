//
//  MenuItemCell.swift
//  OrderApp
//
//  Created by Nehemiah Chandler on 7/28/24.
//

import Foundation
import UIKit

class MenuItemCell: UITableViewCell {
    var itemName: String? = nil
    {
        didSet {
            if oldValue != itemName {
                setNeedsUpdateConfiguration()
            }
        }
    }
    var price: Double? = nil
    {
        didSet {
            if oldValue != price {
                setNeedsUpdateConfiguration()
            }
        }
    }
    var image: UIImage? = nil
    {
        didSet {
            if oldValue != image {
                setNeedsUpdateConfiguration()
            }
        }
    }
        
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = defaultContentConfiguration().updated(for: state)
        content.text = itemName
        content.secondaryText = price?.formatted(.currency(code: "usd"))
        content.prefersSideBySideTextAndSecondaryText = true
        
        if let image = image {
            content.image = image
            content.imageProperties.maximumSize = CGSize(width: 60, height: 60) // Adjust size as needed
        } else {
            content.image = UIImage(systemName: "photo.on.rectangle")
        }
        self.contentConfiguration = content
    }
}
