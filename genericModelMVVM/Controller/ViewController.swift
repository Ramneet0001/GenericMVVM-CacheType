//
//  ViewController.swift
//  genericModelMVVM
//
//  Created by STUser on 25/06/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var personLists = [List]()
    var loadedIndexes = [Int]()
    var totalListCount = 100
    var loadableIndex = 0
    
    var person: PersonListModel? { didSet {
               guard let result = person else {return}
               DispatchQueue.main.async {
                self.loadedIndexes.append(self.loadableIndex)
                self.loadableIndex = self.loadableIndex+1
                self.personLists.append(contentsOf: result.list)
                LoaderClass().stopLoader(controller: self)
                self.tableView.reloadData()
               }}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getPersonList(index: 0)
    }
    
}

extension ViewController {  // MARK: Call Api View Model
   
    private func getPersonList(index:Int){
        // Here you can also call directly Generic methods with passing Model Class. It will return same model with data.
        PersonViewModel().getUserDetail(view: self,listIndex: index) { (personModel, error) in
                         if let error = error {
                           print("Get error: \(error.localizedDescription)")
                           return
                       }
                       guard let response = personModel  else { return }
                        self.person = response
        }}//
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{  // MARK: TableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let useDetail = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! personCell
         useDetail.tempImg = currentCell.personImage.image!
        useDetail.personLists = personLists[indexPath!.row]
        present(useDetail, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return personLists.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! personCell
                let singlePerson = personLists[indexPath.row]
                let url = URL(string:singlePerson.imgURL)
                cell.personImage.hnk_setImageFromURL(url!)
                cell.lblName.text = singlePerson.name
                cell.lblEmail.text = singlePerson.email
        
        if indexPath.row == personLists.count - 1 { // last cell
            if totalListCount > personLists.count && !loadedIndexes.contains(loadableIndex) { // more items to fetch
                getPersonList(index: (loadableIndex)) // incremented by 1 before server call
            }}
        return cell
    }
}





