//
//  QuestionsViewController.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import UIKit

class QuestionsViewController: UIViewController {
    @IBOutlet weak var txtQuizCategory: UILabel!
    
    @IBOutlet weak var cnstTbl: NSLayoutConstraint!
    @IBOutlet weak var tblOption: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    
    var intSelectedQuestion: Int = 0
    
    var vmCategory: CategoryViewModel = CategoryViewModel()
    var objQuizQuestion: quizQuestions?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    //MARK: common
    func initView() {
        self.tblOption.delegate = self
        self.tblOption.dataSource = self
        if let questionList = vmCategory.questionModel?.results as? [quizQuestions] {
            if questionList.count > 0 {
                objQuizQuestion = questionList[self.intSelectedQuestion]
                self.txtQuizCategory.text = questionList[self.intSelectedQuestion].category
                self.lblQuestion.text = String(htmlEncodedString: questionList[self.intSelectedQuestion].question ?? "")
                vmCategory.setupOptionData(correctAns: objQuizQuestion?.correct_answer ?? "", incorrectAnswer: objQuizQuestion?.incorrect_answers ?? [""])
            }
        }
        self.vmCategory.reloadTableView = {
            self.tblOption.reloadData()
        }
        
    }
    
    func navigateToResult() {
        self.intSelectedQuestion += 1
        if self.intSelectedQuestion < self.vmCategory.questionModel?.results?.count ?? 0 {
            self.initView()
        } else {
            if let vcResult = Common.shared.viewController("ResultViewController", onStoryboard: "Main") as? ResultViewController {
                vcResult.correctAnswer = vmCategory.correctAnswers
                self.navigationController?.pushViewController(vcResult, animated: true)
            }
        }
    }
    //MARK: button click
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: tableview delegate and datasource
extension QuestionsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vmCategory.arrOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblOption.dequeueReusableCell(withIdentifier: "optionCell") as! optionCell
        cell.selectionStyle = .none
        cell.lblOption.text = String(htmlEncodedString: vmCategory.arrOptions[indexPath.row])
        cell.vwMain.backgroundColor = .white
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tblOption.cellForRow(at: indexPath) as? optionCell {
            if self.objQuizQuestion?.correct_answer ?? "" == vmCategory.arrOptions[indexPath.row] {
                cell.vwMain.backgroundColor = .green
                self.vmCategory.correctAnswers += 1
            }else{
                cell.vwMain.backgroundColor = .red
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigateToResult()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
//MARK: tableViewcell

class optionCell: UITableViewCell {
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var vwMain: UIView!

    override func awakeFromNib() {
        self.vwMain.setBorder()
    }
    
}
