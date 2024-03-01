//
//  PlayersPointTableViewCell.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit

struct PlayersPointModel {
    var id: Int
    var icon: String
    var name: String
    var points: Int
    var totalScore: Int
    var matchList: [MatchesDataModel]?
}

class PlayersPointTableViewCell: UITableViewCell {
    static let reusableIdentifier: String = "PlayersPointTableViewCell"
    
    @IBOutlet weak var imgPlayerIcon: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureCell(with dataModel: PlayersPointModel) {
        if let url = URL(string: dataModel.icon) {
            imgPlayerIcon.setImage(with: url)
        }
        
        lblPlayerName.text = dataModel.name
        lblPlayerPoints.text = "\(dataModel.points)"
    }
}
