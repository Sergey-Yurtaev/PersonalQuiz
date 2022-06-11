//
//  QuestionsViewController.swift
//  Quiz2
//
//  Created by Sergey Yurtaev on 20.11.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var resultImageLabel: UILabel!
    @IBOutlet var resultTextLabel: UILabel!
    
    // MARK: - Public Properties
    var answersChoosenResult: [Answer]!
    
    // MARK: - Ovveride Method
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        getResult(from: answersChoosenResult)
    }
    
}
//  my version
// MARK: - Private Methods
extension ResultsViewController {
    
    private func getResult(from answer: [Answer])  {
        var resultAnimalType: [AnimalType] = []
        //помещаем выбранные типы ответов в массив
        for answer in answersChoosenResult {
            resultAnimalType.append(answer.type)
        }
        //создание словаря ключ - AnimalType, значение 1 у каждого экземпляра
        let mappedItems = resultAnimalType.map { ($0, 1) } 
        //сложение значений у одинаковых ключей
        let countsType = Dictionary(mappedItems, uniquingKeysWith: +)
        //сортировка словаря с наибольшим значением
        let greatType = countsType.max { a, b in a.value < b.value }

        guard let selectedType = greatType?.key else { return }
        updateUI(with: selectedType)
    }
    
    private func updateUI(with animal: AnimalType) {
        resultImageLabel.text = "Вы - \(animal.rawValue)"
        resultTextLabel.text = animal.definition
    }
}
/*
 version teacher
private func getResult() {
    var resultOfAnimals: [AnimalType: Int] = [:]
    let animals = answersChoosenResult.map { $0.type } - отделяем типы .type от Answer и помещаем в новый массив, animals имеет тип AnimalType [.dog, .dog, .cat ...]
    
    for animal in animals {
        resultOfAnimals[animal] = (resultOfAnimals[animal] ?? 0) + 1 - присваиваем словарю по ключу .AnimalType значение +1.
    }
    let sortedResultOfAnimals = resultOfAnimals.sorted { $0.value > $1.value } - сортировка, сравниваем каждый элемент друг с другом и самый большой элемент станет первым в массиве
    guard let mostesultOfAnimals = sortedResultOfAnimals.first?.key else { return } - берем первый ключ элемента отсортированного массива
 
    updateUI(with: mostesultOfAnimals)
 }
 
 
 // решение в одну строку но с выходом optional
 private func getResult() {
    var resultOfAnimals: [AnimalType: Int] = [:]
    let animals = answersChoosenResult.map { $0.type } - отделяем типы .type от Answer и помещаем в новый массив, animals имеет тип AnimalType [.dog, .dog, .cat ...]
    
    let mostesultOfAnimals = Dictionary(grouping: a  nswersChoosenResult, by: { $0.type }) создаем и группируем словарь по типу
        .sorted(by: {$0.value.count > $1.value.count}) сортируем словарь от большего к меньшему
        .first?.key берем первый элемент из отсортированного словаря mostesultOfAnimals имеет тип AnimalType?
 
    updateUI(with: mostesultOfAnimals)
 }

*/
