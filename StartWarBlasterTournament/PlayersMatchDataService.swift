//
//  PlayersMatchDataService.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import Foundation

protocol PlayersMatchDataServiceProtocol {
    func getPlayersData() -> [PlayerDataModel]?
    func getMatchesData() -> [MatchesDataModel]?
}

class PlayersMatchDataService: PlayersMatchDataServiceProtocol {
    
    func getPlayersData() -> [PlayerDataModel]? {
        getJSONData(with: "StarWarsPlayers")
    }
    
    func getMatchesData() -> [MatchesDataModel]? {
        getJSONData(with: "StarWarsMatches")
    }
    
    private func getJSONData<T: Decodable>(with fileName: String) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let json = try JSONDecoder().decode(T.self, from: data)
                return json
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
