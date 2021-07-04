//
//  MainTableViewController.swift
//  SimpleToDo
//
//  Created by Артём on 04.07.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    @IBAction func onAddTaskButtonPushed(_ sender: Any) {
        let alertController = UIAlertController(title: "Новая задача", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Новая задача"
        }
        let cancelAlertAction = UIAlertAction(title: "Отменить", style: .cancel)
        let submitAllertAction = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let taskName = alertController.textFields?[0].text
            else { return }
            self.tasks.append(Task(name: taskName))
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAlertAction)
        alertController.addAction(submitAllertAction)
        present(alertController, animated: true)
    }
    
    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = "\(task.subtasks.count)"

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SubtasksSegue",
            let controller = segue.destination as? SubtasksTableViewController,
            let indexPath = tableView.indexPathForSelectedRow
        else { return }
        
        controller.task = tasks[indexPath.row]
    }

}
