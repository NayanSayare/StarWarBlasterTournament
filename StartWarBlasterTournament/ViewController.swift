//
//  ViewController.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let vc: PlayersPointTableViewController = PlayersPointTableViewController.getInstance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

