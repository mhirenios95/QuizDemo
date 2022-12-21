//
//  CategoryViewController.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import UIKit
import DropDown

class CategoryViewController: UIViewController {

    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtMode: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    
    var modeDropDown = DropDown()
    var categoryDropDown = DropDown()

    var vmCategory: CategoryViewModel = CategoryViewModel()

    var selectedCat: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.txtCategory.text = ""
        self.txtMode.text = ""
    }
    //MARK: functions
    func initView() {
        Common.shared.addrightViewTextfield(textField: txtCategory)
        Common.shared.addrightViewTextfield(textField: txtMode)
        
        self.txtMode.delegate = self
        self.txtCategory.delegate = self
        
        let appearance = DropDown.appearance()
        appearance.cellHeight = 60
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor.white
        appearance.cornerRadius = 5
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 5
        appearance.animationduration = 0.25
        appearance.textColor =  #colorLiteral(red: 0.1725490196, green: 0.2196078431, blue: 0.2509803922, alpha: 1)

        vmCategory.initViewModel()
        
        vmCategory.reloadViewClosure = {
            self.setupCategoryDropDown()
        }
        vmCategory.questionListFetched = {
            if let vcQuestion = Common.shared.viewController("QuestionsViewController", onStoryboard: "Main") as? QuestionsViewController {
                vcQuestion.vmCategory = self.vmCategory
                self.navigationController?.pushViewController(vcQuestion, animated: true)
            }
        }
        vmCategory.showAlertClosure = { str in
            Common.shared.showAlert(message: str, vc: self)
        }
    }
    
    func setupModeDropDown() {
        modeDropDown.anchorView = self.txtMode
        modeDropDown.dataSource = ["Hard","Medium","Easy"]
        modeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtMode.text = item
            modeDropDown.hide()
        }
        modeDropDown.show()
    }
    func setupCategoryDropDown() {
        categoryDropDown.anchorView = self.txtCategory
        if let ctgry = self.vmCategory.modelCategory?.triviaCategory?.map({$0.name}) as? [String] {
            categoryDropDown.dataSource =  ctgry
        }
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.txtCategory.text = item
            self.selectedCat = self.vmCategory.modelCategory?.triviaCategory?[index].strID ?? 0
            categoryDropDown.hide()
        }
    }

    //MARK: button click
    @IBAction func btnSelectClick(_ sender: Any) {
        let param: [String: Any] = ["amount":10,"category":self.selectedCat,"difficulty":self.txtMode.text!.lowercased(),"type":"multiple"]
        self.vmCategory.getQuestionList(param: param)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: textfield delegate
extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCategory {
            categoryDropDown.show()
            return false
        }
        if textField == txtMode {
            self.setupModeDropDown()
            return false
        }
        return false
    }
}

