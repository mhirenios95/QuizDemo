//
//  CategoryViewModel.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import Foundation

class CategoryViewModel: NSObject {
    
    var reloadViewClosure: (()->())?
    var showAlertClosure: ((_ str: String)->())?
    var questionListFetched: (()->())?
    var reloadTableView: (()->())?
    var arrOptions: [String] = [String]()
    var modelCategory: CategoryModel?
    var questionModel: QuestionsModel?
    
    var correctAnswers: Int = 0

    func initViewModel() {
        Services.callAPI(serverURL: .getCategory(["": ""])) { res in
            self.modelCategory = try? JSONDecoder().decode(CategoryModel.self, from: res)
            self.reloadViewClosure?()
        } failure: { mess in
            self.showAlertClosure?(mess)
        }
    }
    func getQuestionList(param: [String: Any]) {
        Services.callAPI(serverURL: .getQuestionsList(param)) { res in
            if let modelQuestion = try? JSONDecoder().decode(QuestionsModel.self, from: res) {
                self.questionModel = modelQuestion
                self.questionListFetched?()
            }
        } failure: { mess in
            self.showAlertClosure?(mess)
        }
    }
    
    func setupOptionData(correctAns: String, incorrectAnswer: [String]){
        self.arrOptions = incorrectAnswer
        self.arrOptions.append(correctAns)
        self.arrOptions.shuffle()
        self.reloadTableView?()
    }
}
