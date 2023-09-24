//
//  CellTableViewCell.swift
//  DoacaoBrinquedo
//
//  Created by Cátia Souza on 23/09/23.
//

import UIKit


class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label01: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
