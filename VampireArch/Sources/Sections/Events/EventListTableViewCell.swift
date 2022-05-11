//
//  EventListTableViewCell.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class EventListTableViewCell: UITableViewCell {
    static let identifier = "EventListTableViewCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var bookedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        bookedLabel.text = nil
    }
    
    func configure(with config: EventListTableViewCellConfig) {
        nameLabel.text = config.name
        priceLabel.text = config.price
        bookedLabel.text = config.booked
    }
    
}
