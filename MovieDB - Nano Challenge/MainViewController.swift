//
//  MainViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 06/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {

   // @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let resultsController = SearchViewController()
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let searchController = UISearchController(searchResultsController: nil)
        
        
        searchBar.delegate = self
        
        
        //self.navigationController?.delegate = self
        //searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        //definesPresentationContext = true
        //searchController.delegate = self;
        
        
        //searchController.searchBar.setShowsCancelButton(true, animated: true)
        //navBar
        
        //self.navigationItem.titleView = searchBar
        
        //searchController.hidesNavigationBarDuringPresentation = false
        //searchController.dimsBackgroundDuringPresentation = true
        
        

       // searchController.searchBar.delegate = self
        //navBar.addSubview(searchController.searchBar)
        //searchController.searchBar.resignFirstResponder()
        //tableView.tableHeaderView = searchController.searchBar
        
        // Do any additional setup after loading the view.
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
            }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        
        
    }
    
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
    
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        
        print ("hhshhassbdhavsjbhajsbhs")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print ("hhshhashs")
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //performSegue(withIdentifier: , sender: nil)
       // let mySegue = UIStoryboardSegue.init(identifier: , source: self, destination: SearchViewController as! UIViewController)
   // prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        secondViewController.searchText = searchBar.text
        
        self.present(secondViewController, animated: true) {
            
        }

    
        //performSegue(withIdentifier: "goToSearchResults", sender: self)
    
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let variavel = sender as! SearchViewController
        let destView: SearchViewController = segue.destination as! SearchViewController
        // destView.selectedPilot = variavel.cellPilot
        destView.searchText = searchBar.text
        
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
