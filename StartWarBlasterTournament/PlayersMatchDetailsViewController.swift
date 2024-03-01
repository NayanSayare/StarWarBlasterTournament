//
//  PlayersMatchDetailsViewController.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit

class PlayersMatchDetailsViewController: UIViewController {
    static func getInstance(with matchList: [MatchesDataModel],
                            playersDataList: [PlayerDataModel],
                            playerDataModel: PlayersPointModel) -> PlayersMatchDetailsViewController {
        let vc: PlayersMatchDetailsViewController = PlayersMatchDetailsViewController(nibName: "PlayersMatchDetailsViewController", bundle: nil)
        vc.matchList = matchList
        vc.playersList = playersDataList
        vc.playerDataModel = playerDataModel
        return vc
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tblPlayersMatch: UITableView!
    
    private var playerDataModel: PlayersPointModel!
    private var matchList : [MatchesDataModel] = []
    private var playersList: [PlayerDataModel] = []
    var viewModel: PlayerMatchDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.topItem?.title = playerDataModel.name
        viewModel = PlayerMatchDetailsViewModel(with: self, playerDataModel.id, matchList, playersList)
        setUpTableView()
    }
    
    func setUpTableView() {
        tblPlayersMatch.delegate = self
        tblPlayersMatch.dataSource = self
        
        tblPlayersMatch.register(UINib(nibName: "PlayerMatchPlayedTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: PlayerMatchPlayedTableViewCell.reusableIdentifier)
    }
    
    @IBAction func didTapOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PlayersMatchDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let rowModel = viewModel.getCellModelForRowAt(indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PlayerMatchPlayedTableViewCell.reusableIdentifier, for: indexPath) as? PlayerMatchPlayedTableViewCell {
                cell.selectionStyle = .none
                cell.configureCell(with: rowModel)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension PlayersMatchDetailsViewController: PlayerMatchDetailsViewModelDelegate {
    func reloadUI() {
        tblPlayersMatch.reloadData()
    }
}
