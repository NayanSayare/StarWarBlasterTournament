//
//  PlayerMatchDetailsViewModel.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import Foundation
protocol PlayerMatchDetailsViewModelProtocol {
    init(with delegate: PlayerMatchDetailsViewModelDelegate, _ selectedPlayerId: Int, _ matchList: [MatchesDataModel], _ playersList: [PlayerDataModel])
    func getNumberOfRowsInSection() -> Int
    func getCellModelForRowAt(_ indexPath: IndexPath) -> PlayerMatchData?

    var delegate: PlayerMatchDetailsViewModelDelegate? { get set }
}

protocol PlayerMatchDetailsViewModelDelegate: AnyObject {
    func reloadUI()
}

class PlayerMatchDetailsViewModel: PlayerMatchDetailsViewModelProtocol {
    private var playerMatchDataSource: [PlayerMatchData] = []
    private var playersData: [PlayerDataModel]?
    private var selectedPlayerId: Int = -1
    private var playerMatchList: [MatchesDataModel] = []
    weak var delegate: PlayerMatchDetailsViewModelDelegate?
    
    required init(with delegate: PlayerMatchDetailsViewModelDelegate,
                  _ selectedPlayerId: Int,
                  _ matchList: [MatchesDataModel],
                  _ playersList: [PlayerDataModel]) {
        self.delegate = delegate
        self.playersData = playersList
        self.playerMatchList = matchList
        self.selectedPlayerId = selectedPlayerId
        
        prepareDataSource()
    }
    
    func prepareDataSource() {
        playerMatchList.forEach({ matchData in
            if let player1 = playersData?.first(where: { $0.id == matchData.player1.id }),
               let player2 = playersData?.first(where: { $0.id == matchData.player2.id }) {
                
                let playerMatchData = PlayerMatchData(player1Name: player1.name,
                                                      player2Name: player2.name,
                                                      player1Score: matchData.getPlayerScore(for: player1.id),
                                                      player2Score: matchData.getPlayerScore(for: player2.id), 
                                                      matchResult: matchData.getPlayerPoint(with: selectedPlayerId))
                playerMatchDataSource.append(playerMatchData)
            }
        })
        
        delegate?.reloadUI()
    }
    
    func getNumberOfRowsInSection() -> Int {
        playerMatchDataSource.count
    }
    
    func getCellModelForRowAt(_ indexPath: IndexPath) -> PlayerMatchData? {
        if indexPath.row < getNumberOfRowsInSection() {
            return playerMatchDataSource[indexPath.row]
        }
        return nil
    }
}
