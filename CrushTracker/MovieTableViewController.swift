//
//  MovieTableViewController.swift
//  CrushTracker
//
//  Created by MacBook on 8/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    //MARK: props
    var movies = [Movie]()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleMovie()
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
        // #warning Incomplete implementation, return the number of rows
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
