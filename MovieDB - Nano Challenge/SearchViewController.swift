//
//  SearchViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchDisplayDelegate, UICollectionViewDelegateFlowLayout  {

    
    
    var searchText: String!
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    
    
    //lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect.init(x:0, y:0, width:200, height:20))

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var movieArray = MovieModel()
    var searchController: UISearchController!
    //let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 6.7, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        //collectionView.
        mySearchBar.delegate = self
        mySearchBar.backgroundImage = UIImage()
        mySearchBar.showsCancelButton = true
        mySearchBar.tintColor = UIColor.white
       
        //self.configureSearchController()
        //mySearchBar.sizeToFit()
        
        //var leftNavBarButton = UIBarButtonItem(customView:searchBar)
        //self.navigationItem.titleView = searchBar
        
        let myRequestsManeger = RequestsManager()
        myRequestsManeger.getMoviesInTheaterInformation(search: .NameSearch, movieName: searchText) { (movieList) in
            
            
            self.movieArray = movieList
            print(self.movieArray.movieArray)
            
        }
        self.myCollectionView.reloadData()
        
        for movieName in self.movieArray.movieArray{
            
            print(movieName.originalTitle)
        }
    
        
        
        
        //myCollectionView.register(colle, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
        
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        //self.returnToMain()
        
        
        
    }
    
    
    func returnToMain(){
        
        let main: UIStoryboard  = UIStoryboard.init(name: "Main", bundle: nil)
        let destination: ViewController = main.instantiateViewController(withIdentifier: "MoviesInTheater") as! ViewController
        
        //DispatchQueue.main.async(execute: {
            self.present(destination, animated: true, completion:nil)
                
            //})    });
    }


    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        //let paddingSpace = sectionInsets.left
        let availableWidth = collectionView.frame.size.width //- paddingSpace
        let widthPerItem = availableWidth
        
        
        return CGSize(width: widthPerItem, height: 267)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20.0
//    }
    
    // 4
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func updateSearchResults(for searchController: UISearchController) {
        
        
        
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1;
        
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
       
        
    }
    
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        
//        
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        
        cell.initWithContent(cellMovie: movieArray.movieArray[indexPath.section])
        
       
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.movieArray.movieArray.count
        
        //return 10
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        //return searchController
//        
//        
//        
//        if (kind == UICollectionElementKindSectionHeader && indexPath.section == 0 ){
//            
//            let headerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
//            return headerView
//            
//        }
//        else{
//            return nil as! UICollectionReusableView
//        }
//        //return UICollectionReusableView()
//    }
    
    
    
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
