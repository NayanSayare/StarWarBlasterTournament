//
//  PlayersPointTableViewController.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit

class PlayersPointTableViewController: UIViewController {
    static func getInstance() -> PlayersPointTableViewController {
        let vc: PlayersPointTableViewController = PlayersPointTableViewController(nibName: "PlayersPointTableViewController", bundle: nil)
        return vc
    }
    
    
    @IBOutlet weak var tblPlayersPoint: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var viewModel: PlayersPointTableViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = "Star Wars Blaster Tournament"
        viewModel = PlayersPointTableViewModel(with: self)
        viewModel.fetchData()
        setUpTableView()
    }
    
    func setUpTableView() {
        tblPlayersPoint.delegate = self
        tblPlayersPoint.dataSource = self
        
        tblPlayersPoint.register(UINib(nibName: "PlayersPointTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: PlayersPointTableViewCell.reusableIdentifier)
    }
    
    @IBAction func didTapOnSort(_ sender: Any) {
        viewModel.sortDataSource(for: viewModel.sortType.toggle())
    }
}

extension PlayersPointTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let rowModel = viewModel.getCellModelForRowAt(indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PlayersPointTableViewCell.reusableIdentifier, for: indexPath) as? PlayersPointTableViewCell {
                cell.selectionStyle = .none
                cell.configureCell(with: rowModel)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let playerMatchList = viewModel.getMatchList(indexPath),
           let playerDataModel = viewModel.getCellModelForRowAt(indexPath),
           let playersList = viewModel.getPlayersList() {
            
            let vc: PlayersMatchDetailsViewController = PlayersMatchDetailsViewController.getInstance(with: playerMatchList,
                                                                                                      playersDataList: playersList,
                                                                                                      playerDataModel: playerDataModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension PlayersPointTableViewController: PlayersPointTableViewModelDelegate {
    func reloadUI() {
        tblPlayersPoint.reloadData()
    }
}
