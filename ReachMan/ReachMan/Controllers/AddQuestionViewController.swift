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
    var indexes = [IndexPath]()
    private let careTracker = CareTrackerQuestion()
    
    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        indexes.append(IndexPath(row: 0, section: 0))
        addQuestionsTableView.delegate = self
        addQuestionsTableView.dataSource = self
        coordinator?.navigationController.navigationBar.isHidden = false
    }
    @IBAction func addMoreQuestionsButton(_ sender: Any) {
        let lastCount = indexes.count
        numberOfQuestions += 1
        indexes.append(IndexPath(row: lastCount, section: 0))
        self.addQuestionsTableView.reloadData()
    }
    
    @IBAction func addAllQuestionsInGame(_ sender: Any) {
        var newQuestions = [Question]()
        
        for index in indexes {
            let cell:AddQuestionCell = self.addQuestionsTableView.cellForRow(at: index) as! AddQuestionCell
            
            guard let textQuestion = cell.questionTextField.text,
                let firstAnswer = cell.firstAnswerTextField.text,
                let secondAnswer = cell.secondAnswerTextField.text,
                let thirdAnswer = cell.thirdAnswerTextField.text,
                let fourthAnswer = cell.fourthAnswerTextField.text,
                let correctAnswer = cell.numberOfCorrectAnswer.text else {return }
            if firstAnswer != "" &&
                secondAnswer != "" &&
                thirdAnswer != "" &&
                fourthAnswer != "" &&
                correctAnswer != ""{
                let builderQuestion = Builder()
                builderQuestion.setFirstAnswer(firstAnswer)
                builderQuestion.setSecondAnswer(secondAnswer)
                builderQuestion.setThirdAnswer(thirdAnswer)
                builderQuestion.setFourthAnswer(fourthAnswer)
                builderQuestion.setTextQuestion(textQuestion)
                builderQuestion.correctAnswer(correctAnswer)
                let newQuestion = builderQuestion.build()
                newQuestions.append(newQuestion)
            } else {
                UIView.animate(withDuration: 2, animations: {
                    cell.firstAnswerTextField.backgroundColor = .red
                    cell.secondAnswerTextField.backgroundColor = .red
                    cell.thirdAnswerTextField.backgroundColor = .red
                    cell.fourthAnswerTextField.backgroundColor = .red
                    cell.numberOfCorrectAnswer.backgroundColor = .red
                    cell.questionTextField.backgroundColor = .red
                }) { (_) in
                    UIView.animate(withDuration: 1) {
                        cell.firstAnswerTextField.backgroundColor = .clear
                        cell.secondAnswerTextField.backgroundColor = .clear
                        cell.thirdAnswerTextField.backgroundColor = .clear
                        cell.fourthAnswerTextField.backgroundColor = .clear
                        cell.numberOfCorrectAnswer.backgroundColor = .clear
                        cell.questionTextField.backgroundColor = .clear
                    }
                }
                let alertController = UIAlertController(title: "Заполните все поля", message: "", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(cancelButton)
                present(alertController, animated: true)
                break
            }
        }
        if newQuestions.count == indexes.count {
            careTracker.saveQuestions(newQuestions)
        }
        numberOfQuestions = 1
        addQuestionsTableView.reloadData()
        let cell:AddQuestionCell = self.addQuestionsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddQuestionCell
        cell.firstAnswerTextField.text = ""
        cell.secondAnswerTextField.text = ""
        cell.thirdAnswerTextField.text = ""
        cell.fourthAnswerTextField.text = ""
        cell.questionTextField.text = ""
        cell.numberOfCorrectAnswer.text = ""
        
        
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
