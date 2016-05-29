//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Antonia Blair on 5/28/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    // MARK: Properties
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        // create a special type of bar button that has editing behavior and add to left side of nav bar
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any sample meals.. otherwise load sample data
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            // load sample data
            loadSampleMeals()
        }
    }
    
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "bagels")!
        let meal1 = Meal(name: "Bagels", photo: photo1, rating: 5)!
        
        let photo2 = UIImage(named: "doughnuts")!
        let meal2 = Meal(name: "Doughnuts", photo: photo2, rating: 4)!
        
        let photo3 = UIImage(named: "brusselsprouts")!
        let meal3 = Meal(name: "Brussel Sprouts", photo: photo3, rating: 4)!
        
        let photo4 = UIImage(named: "carrotloaves")!
        let meal4 = Meal(name: "Carrot Loaves", photo: photo4, rating: 3)!
        
        let photo5 = UIImage(named: "watermelonpopsicles")!
        let meal5 = Meal(name: "Watermelon Popsicles", photo: photo5, rating: 5)!
        
        meals += [meal1, meal2, meal3, meal4, meal5]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // visual grouping of cells within table view (simples ones just need 1)
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
        return meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /**
         * The template performs several tasks.
         * It asks the table view for a cell with a placeholder identifier,
         * adds a comment about where code to configure the cell should go, and then returns the cell.
         **/
        
        let cellIdentifier = "MealTableViewCell" // this is the reuseIdentifier
        // now downcast the type of cell to the custom cell subclass, MealTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            //local constant is assigned segue.destinationViewController as type MealViewController
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
    }
 
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            
            else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveMeals()
        }
    }
    
    // MARK: NSCoding
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
