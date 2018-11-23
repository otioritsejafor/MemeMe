//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Oti Oritsejafor on 11/17/18.
//  Copyright © 2018 Magloboid. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UIViewController
, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.MemeImageView?.image = meme.memedImage
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
     navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    @IBAction func add(_sender: Any) {
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorController") as! ViewController
     navigationController!.pushViewController(editorController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
    }
    
    
}

