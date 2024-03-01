//
//  PlayerMatchPlayedTableViewCell.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit
struct PlayerMatchData {
    var player1Name: String
    var player2Name: String
    var player1Score: Int
    var player2Score: Int
    var matchResult: MatchResult
}
class PlayerMatchPlayedTableViewCell: UITableViewCell {
    static let reusableIdentifier: String = "PlayerMatchPlayedTableViewCell"
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblMatchScore: UILabel!
    @IBOutlet weak var lblPlayer1Name: UILabel!
    @IBOutlet weak var lblPlayer2Name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with dataModel: PlayerMatchData) {
        viewContainer.backgroundColor = dataModel.matchResult.getBgColor()
        lblPlayer1Name.text = dataModel.player1Name
        lblPlayer2Name.text = dataModel.player2Name
        
        lblMatchScore.text = "\(dataModel.player1Score) - \(dataModel.player2Score)"
    }
    
}
