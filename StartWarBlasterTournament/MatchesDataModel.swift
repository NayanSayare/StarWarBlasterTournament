//
//  MatchesDataModel.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit

enum MatchResult {
    case LOSS, DRAW, WIN
    
    func getPoints() -> Int {
        switch self {
        case .WIN:  return 3
        case .DRAW: return 1
        case .LOSS: return 0
        }
    }
    
    func getBgColor() -> UIColor {
        switch self {
        case .WIN:  return .green
        case .DRAW: return .white
        case .LOSS: return .red
        }
    }
}

struct MatchesDataModel: Decodable {
    let match: Int
    let player1: PlayersMatchDataModel
    let player2: PlayersMatchDataModel
    
    var isDrawMatch: Bool {
        player1.score == player2.score
    }
    
    var winnerPlayerId: Int {
        if player1.score > player2.score {
            return player1.id
        }
        return player2.id
    }
    
    func getPlayerScore(for id: Int) -> Int {
        if id == player1.id {
            return player1.score
        }
        return player2.score
    }
    
    func getPlayerPoint(with id: Int) -> MatchResult {
        if isDrawMatch {
            return .DRAW
        } else if id == winnerPlayerId {
            return .WIN
        } else {
            return .LOSS
        }
    }
}

struct PlayersMatchDataModel: Decodable {
    let id: Int
    let score: Int
}
