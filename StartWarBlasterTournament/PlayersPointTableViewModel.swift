//
//  PlayersPointTableViewModel.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import Foundation

enum SortType {
    case HighToLow, LowToHigh
    
    func toggle() -> SortType {
        if self == .HighToLow {
            return .LowToHigh
        } else {
            return .HighToLow
        }
    }
}

protocol PlayersPointTableViewModelProtocol {
    func fetchData()
    init(with delegate: PlayersPointTableViewModelDelegate, playerService: PlayersMatchDataServiceProtocol)
    func getNumberOfRowsInSection() -> Int
    func getPlayersList() -> [PlayerDataModel]?
    func getMatchList(_ indexPath: IndexPath) -> [MatchesDataModel]?
    func getCellModelForRowAt(_ indexPath: IndexPath) -> PlayersPointModel?
    func sortDataSource(for sortType: SortType)
    var sortType: SortType { get set }
    var delegate: PlayersPointTableViewModelDelegate? { get set }
}

protocol PlayersPointTableViewModelDelegate: AnyObject {
    func reloadUI()
}

class PlayersPointTableViewModel: PlayersPointTableViewModelProtocol {
    private var playerService: PlayersMatchDataServiceProtocol!
    private var playersDataSource: [PlayersPointModel] = []
    private var playerMatchesMap: [Int: [MatchesDataModel]] = [:]
    
    var sortType: SortType = .HighToLow
    var playersData: [PlayerDataModel]?
    var playersMatches: [MatchesDataModel]?
    weak var delegate: PlayersPointTableViewModelDelegate?
    
    
    func fetchData() {
        playersData = playerService.getPlayersData()
        playersMatches = playerService.getMatchesData()
        prepareDataSource()
    }
    
    required init(with delegate: PlayersPointTableViewModelDelegate, playerService: PlayersMatchDataServiceProtocol = PlayersMatchDataService()) {
        self.delegate = delegate
        self.playerService = playerService
    }
    
    func prepareDataSource() {
        playersMatches?.forEach({ match in
            if var player1Matches = playerMatchesMap[match.player1.id] {
                player1Matches.append(match)
                playerMatchesMap[match.player1.id] = player1Matches
            } else {
                playerMatchesMap[match.player1.id] = [match]
            }
            
            if var player2Matches = playerMatchesMap[match.player2.id] {
                player2Matches.append(match)
                playerMatchesMap[match.player2.id] = player2Matches
            } else {
                playerMatchesMap[match.player2.id] = [match]
            }
        })
        
        
        playersData?.forEach({ player in
            let totalScore: Int = playerMatchesMap[player.id]?.reduce(Int.zero, { score, match in
                return score + match.getPlayerScore(for: player.id)
            }) ?? Int.zero
            
            let playerPoint: Int = playerMatchesMap[player.id]?.reduce(Int.zero, { points, match in
                return points + match.getPlayerPoint(with: player.id).getPoints()
            }) ?? Int.zero
            
            
            let playerPointData = PlayersPointModel(id: player.id,
                                                    icon: player.icon,
                                                    name: player.name,
                                                    points: playerPoint,
                                                    totalScore: totalScore,
                                                    matchList: playerMatchesMap[player.id])
            playersDataSource.append(playerPointData)
        })
        
        sortDataSource(for: .HighToLow)
    }
    
    func sortDataSource(for sortType: SortType) {
        self.sortType = sortType
        if sortType == .HighToLow {
            playersDataSource.sort { player1, player2 in
                if player1.points == player2.points {
                    return player1.totalScore > player2.totalScore
                }
                return player1.points > player2.points
            }
        } else {
            playersDataSource.sort { player1, player2 in
                if player1.points == player2.points {
                    return player1.totalScore < player2.totalScore
                }
                return player1.points < player2.points
            }
        }
        
        delegate?.reloadUI()
    }
    
    func getNumberOfRowsInSection() -> Int {
        playersDataSource.count
    }
    
    func getCellModelForRowAt(_ indexPath: IndexPath) -> PlayersPointModel? {
        if indexPath.row < getNumberOfRowsInSection() {
            return playersDataSource[indexPath.row]
        }
        return nil
    }
    
    func getMatchList(_ indexPath: IndexPath) -> [MatchesDataModel]? {
        if indexPath.row < getNumberOfRowsInSection() {
            let id = playersDataSource[indexPath.row].id
            return playerMatchesMap[id]
        }
        return nil
    }
    
    func getPlayersList() -> [PlayerDataModel]? {
        playersData
    }
}
