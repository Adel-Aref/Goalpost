//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Have a Mission on 4/5/18.
//  Copyright © 2018 Have a Mission. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController , UITextViewDelegate {
    @IBOutlet weak var txtGoal: UITextView!
    @IBOutlet weak var BtnShortTerm: UIButton!
    @IBOutlet weak var BtnLongTerm: UIButton!
    @IBOutlet weak var BtnNext: UIButton!
    var goalType : GoalType = .shortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnNext.bindToKeyboard()
        BtnShortTerm.setSelectedColor()
        BtnLongTerm.setDeselectedColor()
        txtGoal.delegate = self
    }
    @IBAction func BtnShortTermWasPressed(_ sender: Any) {
             goalType = .shortTerm
             BtnShortTerm.setSelectedColor()
             BtnLongTerm.setDeselectedColor()
    }
    @IBAction func BtnLongTermWasPressed(_ sender: Any) {
        goalType = .longTerm
        BtnLongTerm.setSelectedColor()
        BtnShortTerm.setDeselectedColor()
    }
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if txtGoal.text != "" && txtGoal.text != "What is your goal ?"
        {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC
                else {return}
            finishGoalVC.initData(description: txtGoal.text, type: goalType)
            presentingViewController?.presentSeconderyDetail(finishGoalVC)
        }
    }
    
    @IBAction func BtnBackWasPressed(_ sender: Any) {
       dissmisDetail()
    }
    //
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtGoal.text = ""
        txtGoal.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    // End of the class
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


