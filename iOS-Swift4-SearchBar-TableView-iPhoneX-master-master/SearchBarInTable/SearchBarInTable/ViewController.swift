//
//  ViewController.swift
//  SearchBarInTable
//
//  Created by PhamDucDuong on 1/13/18.
//  Copyright © 2018 PhamDucDuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: Properties
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var animalArray = [Animal]()
    var currentAnimalArray = [Animal]() //update table
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimals()
        setUpSearchBar()
        alterLayout()
    }
    
    private func setUpAnimals() {
        // CATS
        animalArray.append(Animal(name: "duong", category: .cat, image:"images-1", ratings: 3))
        animalArray.append(Animal(name: "cuong", category: .cat, image:"images-2", ratings: 5))
        animalArray.append(Animal(name: "dat", category: .cat, image:"images-3", ratings: 4))
        // DOGS
        animalArray.append(Animal(name: "dat", category: .dog, image:"images-9", ratings: 2))
        animalArray.append(Animal(name: "huyen", category: .dog, image:"images-8", ratings: 5))
        animalArray.append(Animal(name: "anh", category: .dog, image:"images-6", ratings: 1))
        
        currentAnimalArray = animalArray
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
//        navigationItem.titleView = searchBar
//       
//       searchBar.showsScopeBar = true // you can show/hide this dependant on your layout
        table.tableHeaderView = searchBar
        searchBar.placeholder = "Search Animal by Name"
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = currentAnimalArray[indexPath.row].name
        cell.categoryLbl.text = currentAnimalArray[indexPath.row].category.rawValue
        cell.imgView.image = UIImage(named:currentAnimalArray[indexPath.row].image)
        cell.h_ratings.rating = currentAnimalArray[indexPath.row].ratings
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            currentAnimalArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // This two functions can be used if you want to show the search bar in the section header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return searchBar
//    }
    
//    // search bar in section header
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    // Search Bar
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        currentAnimalArray = animalArray.filter({ animal -> Bool in
//            switch searchBar.selectedScopeButtonIndex {
//            case 0:
//                if searchText.isEmpty { return true }
//                return animal.name.lowercased().contains(searchText.lowercased())
//            case 1:
//                if searchText.isEmpty { return animal.category == .dog }
//                return animal.name.lowercased().contains(searchText.lowercased()) &&
//                animal.category == .dog
//            case 2:
//                if searchText.isEmpty { return animal.category == .cat }
//                return animal.name.lowercased().contains(searchText.lowercased()) &&
//                animal.category == .cat
//            default:
//                return false
//            }
//        })
//        table.reloadData()
//    }
//
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentAnimalArray = animalArray
        case 1:
            currentAnimalArray = animalArray.filter({ animal -> Bool in
                animal.category == AnimalType.dog
            })
        case 2:
            currentAnimalArray = animalArray.filter({ animal -> Bool in
                animal.category == AnimalType.cat
            })
        default:
            break
        }
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentAnimalArray = searchText.isEmpty ? animalArray : animalArray.filter { (item) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        table.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text?.removeAll()
        currentAnimalArray = animalArray
        table.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vcDisplay = segue.destination as? ViewControllerDisplay else {
            return
        }
        if let indexPath = table.indexPathForSelectedRow {
            vcDisplay.animal = currentAnimalArray[indexPath.row]
            
        }
    }
}
