//
//  ActorPickerViewController.swift
//  FavoriteActors
//
//  Created by Jason on 1/31/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import CoreData

protocol ActorPickerViewControllerDelegate {
    func actorPicker(actorPicker: ActorPickerViewController, didPickActor actor: Person?)
}

/**
* Challenge Step 3: Convert Actor Picker to Fetched Results View Controller.
*/

class ActorPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    
    // The data for the table. This needs to be replaced by a lazy fetchedResultsController
    var actors = [Person]()
    
    var delegate: ActorPickerViewControllerDelegate?
    var searchTask: NSURLSessionDataTask?
    var temporaryContext: NSManagedObjectContext!
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        
        let sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext
        
        // Set the temporary context
        temporaryContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        temporaryContext.persistentStoreCoordinator = sharedContext.persistentStoreCoordinator
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchBar.becomeFirstResponder()
    }
    
    // Step 1 - The Lazy fetchedResultsController property. You can put the property here. If you do not
    // remember how to write it there is a reverence sheet available in the course
    
    
    // MARK: - Actions
    
    @IBAction func cancel() {
        self.delegate?.actorPicker(self, didPickActor: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Search Bar Delegate
    
    // Each time the search text changes we want to cancel any current download and start a new one
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Cancel the last task
        if let task = searchTask {
            task.cancel()
        }
        
        // If the text is empty we are done
        if searchText == "" {
            actors = [Person]()
            tableView?.reloadData()
            objc_sync_exit(self)
            return
        }
        
        // Start a new one download
        let resource = TheMovieDB.Resources.SearchPerson
        let parameters = ["query" : searchText]
        
        searchTask = TheMovieDB.sharedInstance().taskForResource(resource, parameters: parameters) { [unowned self] jsonResult, error in
            
            // Handle the error case
            if let error = error {
                print("Error searching for actors: \(error.localizedDescription)")
                return
            }
            
            // Get a Swift dictionary from the JSON data
            if let actorDictionaries = jsonResult.valueForKey("results") as? [[String : AnyObject]] {
                self.searchTask = nil
                
                // Create an array of Person instances from the JSON dictionaries
                self.actors = actorDictionaries.map() {
                    Person(dictionary: $0, context: self.temporaryContext)
                }
                
                // Reload the table on the main thread
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView!.reloadData()
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Table View Delegate and Data Source
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellReuseId = "ActorSearchCell"
        let actor = actors[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseId)!
        
        configureCell(cell, actor: actor)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let actor = actors[indexPath.row]
        
        // Alert the delegate
        delegate?.actorPicker(self, didPickActor: actor)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // All right, this is kind of meager. But its nice to be consistent
    func configureCell(cell: UITableViewCell, actor: Person) {
        cell.textLabel!.text = actor.name
    }
}





