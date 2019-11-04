//
//  AddQuestionViewController.swift
//  ReachMan
//
//  Created by Maxim on 03.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController, Storyboarded {

    @IBOutlet var addQuestionsTableView: UITableView!
    var numberOfQuestions = 1
    
    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestionsTableView.delegate = self
        addQuestionsTableView.dataSource = self
        coordinator?.navigationController.navigationBar.isHidden = false
    }
    @IBAction func addMoreQuestionsButton(_ sender: Any) {
        numberOfQuestions += 1
        self.addQuestionsTableView.reloadData()
    }
    
    @IBAction func addAllQuestionsInGame(_ sender: Any) {
    }
    
}

extension AddQuestionViewController: UITableViewDelegate{
    
}

extension AddQuestionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfQuestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionCell", for: indexPath) as? AddQuestionCell else {fatalError("error in dequeued AddQuestionCell")}
        return cell
    }
    
    
}
