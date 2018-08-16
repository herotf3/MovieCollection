//
//  MovieTableViewController.swift
//  CrushTracker
//
//  Created by MacBook on 8/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import os.log

class MovieTableViewController: UITableViewController {
    //MARK: props
    var movies = [Movie]()
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        //get movie obj from sender's source
        //with downcasting sender.source & checking valid obj
        if let movieViewCtrl=sender.source as? MovieViewController,
            let newMovie=movieViewCtrl.movie {
            //Update a movie
            if let indexPath=tableView.indexPathForSelectedRow {
                //a row is selected
                movies[indexPath.row]=newMovie
                tableView.reloadRows(at: [indexPath], with: .none)
                return
            }
            
            //Add new movie to list
            movies.append(newMovie)
            //Add to table view
            let indexPath=IndexPath(row: movies.count-1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)    //tableView is a prop of base class UITAbleViewCtrl
            
            saveMovies()
        }
    }
    
    //MARK: Private methods
    private func loadSampleMovie(){
        let img1=UIImage(named: "phim0")
        let img2=UIImage(named: "phim1")
        let img3=UIImage(named: "phim3")
        let img4=UIImage(named: "phim4")
        let img5=UIImage(named: "phim5")
        
        guard let movie1 = Movie(name: "Shark Oce", rating: 3, image: img1)else{
            fatalError()
        }
        guard let movie2 = Movie(name: "Shark Oce", rating: 4, image: img2)else{
            fatalError()
        }
        guard let movie3 = Movie(name: "Dare you", rating: 2, image: img3)else{
            fatalError()
        }
        guard let movie4 = Movie(name: "Shark Oce", rating: 3, image: img4)else{
            fatalError()
        }
        guard let movie5 = Movie(name: "Mission impossible", rating: 5, image: img5)else{
            fatalError()
        }
    
        movies+=[movie1,movie2,movie3,movie4,movie5]
        
    }
    //Save movie to local
    private func saveMovies() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.movies, toFile: Movie.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Movies successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save movies...", log: OSLog.default, type: .error)
        }
    }
    private func loadMeals() -> [Movie]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Movie.ArchiveURL.path) as? [Movie]
    }
    //-----
    override func viewDidLoad() {
        super.viewDidLoad()
        //edit btn provided by table view controller
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedMovies = loadMeals(){
            movies+=savedMovies
        }
            else{
            //load sample data
            loadSampleMovie()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MovieTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell
            else{
                fatalError("cell cast error")
        }
        //get obj model
        let movie=movies[indexPath.row]
        
        // Configure the cell...
        cell.movieLabel.text=movie.name
        cell.posterImgView.image=movie.image
        cell.ratingView.rating=movie.rating
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            movies.remove(at: indexPath.row)
            saveMovies()
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            os_log("Show Detail",log: OSLog.default, type: .debug)
            //get destination of segue
            guard let movieDetailViewCtrl=segue.destination as? MovieViewController
            else{
                fatalError("Unexpected destination of segue \(segue.destination)")
            }
            //get the cell view triggering this event
            guard let selectedMovieCell=sender as? MovieTableViewCell else{
                fatalError("Unexpected sender \(sender ?? "undefined")")
            }
            //get index of selected cell in tableview
            guard let indexPath=tableView.indexPath(for: selectedMovieCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            //get data in that cell
            let movie = movies[indexPath.row]
            //send obj data to destination view controller
            movieDetailViewCtrl.movie=movie
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "undefined")")
        }
    }
    

}
