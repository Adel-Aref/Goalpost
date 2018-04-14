//
//  GoalsVC
//  GoalPost
//
//  Created by Have a Mission on 4/5/18.
//  Copyright © 2018 Have a Mission. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    var goals: [Goal] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    // 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    func fetchCoreDataObjects()
    {
        self.fetch {( complete) in
            if complete {
                if goals.count >= 1{
                    self.tableView.isHidden = false
                } else {
                    self.tableView.isHidden = true}
            }
        }
    }

    @IBAction func BtnAddGoal(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else{return}
        presentDtails(viewControllerToPresent: createGoalVC)
    }
}

// extenion from GoalVC to makee my code more readable and reusable
extension GoalsVC: UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell")
        as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal:goal)
        return cell
     }
    // to remove row from tableview
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(indexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return [deleteAction]
    }
    
}

extension GoalsVC{
    // delete row from coredata
    func removeGoal(indexPath:IndexPath)
    {
        guard let mangedContext = appDelegate?.persistentContainer.viewContext else {return}
        mangedContext.delete(goals[indexPath.row])
        do{
            try mangedContext.save()
            print("delete sucssefully")
        }
        catch{
            debugPrint("couldn't remove data \(error.localizedDescription)")
        }
        
    }



    func fetch(completion: (_ complete: Bool) -> ())
    {
        guard let mangedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
          goals = try mangedContext.fetch(fetchRequest) 
          print("secessfully fetched data .")
            completion(true)
        }
        catch{
            debugPrint("couldn't fetch data \(error.localizedDescription)")
            completion(false)
            }
        }
    }

