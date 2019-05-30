//
//  ViewController.swift
//  Collection View
//
//  Created by Asmaa on 2/20/19.
//  Copyright © 2019 Asmaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionData = ["1 😂" , "2 😍" , "3 🧐" , "4 😌" , "5 🤪" , "6 😉" , "7 🤕" , "8 😴" , "9🐸" , "10 💃🏻" , "11 👻" , "12 ☠️"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshUI), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refresh
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
        let width = (view.frame.size.width - 20) / 3
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    //prepare data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let dest = segue.destination as? DetailViewController,
                let index = sender as? IndexPath{
                //    let index = collectionView.indexPathsForSelectedItems?.first{
                dest.selection = collectionData [index.row]
            }
        }
    }
    //edit
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        deleteBtn.isEnabled = editing
        addBtn.isEnabled = !editing
//    navigationController?.isToolbarHidden = !editing
        collectionView.allowsMultipleSelection = editing
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes{
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editing
        }
        if !editing {
               navigationController?.isToolbarHidden = true
        }
    }
    @IBAction func addItem() {
        //y3ml 2 mara wa7da
        collectionView.performBatchUpdates({
            for _ in 0..<2 {
                let text = "\(collectionData.count + 1) 😘"
                collectionData.append(text)
                let index = IndexPath(row: collectionData.count - 1, section: 0)
                collectionView.insertItems(at: [index])
            }
            
        }, completion: nil)
    }
    
    
    @objc func refreshUI(){
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    @IBAction func deleteItem() {
        if let selected =  collectionView.indexPathsForSelectedItems{
            let items = selected.map{$0.item}.sorted().reversed()
            for item in items {
                collectionData.remove(at: item)
            }
        collectionView.deleteItems(at: selected)
           navigationController?.isToolbarHidden = true
        }
        }
    
    
    @IBAction func deselectAll(_ sender: UIBarButtonItem) {
    if let selected =  collectionView.indexPathsForSelectedItems{
            
            for item in selected{
           collectionView.deselectItem(at: item, animated: true)
               
            }
              navigationController?.isToolbarHidden = true
        }
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        // 3rftha anha mn collectionView cell
        //        if let label = cell.viewWithTag(100) as? UILabel{
        //label.text mab2at4 3eazaha
        cell.titleLabel.text = collectionData[indexPath.row]
        cell.isEditing = isEditing
        //}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        print("Item \(indexPath.row + 1) was selected ")
        print("item value : \(collectionData[indexPath.row])")
       
        if !isEditing {
       performSegue(withIdentifier: "detailSegue", sender: indexPath)
         
        }else{
            navigationController?.isToolbarHidden = false
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
            
            navigationController?.isToolbarHidden = true
        }
    }
}


