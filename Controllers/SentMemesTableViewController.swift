//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Oti Oritsejafor on 11/17/18.
//  Copyright © 2018 Magloboid. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UIViewController,
    UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memeTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.memeTable.reloadData()
    }
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = (indexPath as NSIndexPath).row
        let meme = self.memes[index]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        
        cell.textLabel!.text = meme.topText!
        cell.imageView?.image = meme.memedImage
        cell.textLabel!.textColor = UIColor.white
        
        return cell
    }
    
    @IBAction func add(_sender: Any) {
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorController") as! ViewController
        navigationController!.pushViewController(editorController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
    }
    
}

