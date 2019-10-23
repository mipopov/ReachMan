//
//  ResultsViewController.swift
//  ReachMan
//
//  Created by Maxim on 21.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, Storyboarded {

    @IBOutlet var resultsTableView: UITableView!
    
    weak var coordinator: MainCoordinator?

    override func viewWillAppear(_ animated: Bool) {
        coordinator?.navigationController.navigationBar.isHidden = false
    }

}
extension ResultsViewController: UITableViewDelegate {
    
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameSingleton.shared.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultCell else {fatalError("error in dequeued ResultCell")}
        cell.percentLabel.text = String(GameSingleton.shared.results[indexPath.row].questionPercent)
        cell.correctAnswersLabel.text = String(GameSingleton.shared.results[indexPath.row].numberOfCorrectAnswers)
        return cell
    }
    
    
}
