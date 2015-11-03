//
//  ViewController.swift
//  uistreet
//
//  Created by Amandeep Brar on 10/1/15.
//  Copyright © 2015 Amandeep Brar. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var magazines = [];
    var imageData:NSMutableArray = [];
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        self.activityIndicator.startAnimating()
        self.collectionView.showsVerticalScrollIndicator = false;
        Alamofire.request(.GET, "http://uistreet.herokuapp.com/magazines")
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    self.magazines  = JSON["magazines"] as! NSArray
                    
                    self.collectionView.reloadData()


                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                        for magazine in self.magazines {
                            let imageurl = magazine.objectForKey("image") as! String
                            let imageData = NSData.init(contentsOfURL: NSURL.init(string: imageurl)!)
                            let imageMag = UIImage.init(data: imageData!)
                            self.imageData.addObject(imageMag!)
                            dispatch_async(dispatch_get_main_queue()) {
                                self.collectionView.reloadData()
                            }
                        }
                    })
                    
                    self.activityIndicator.stopAnimating()
                    
                    
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magazines.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("magazine", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.blackColor()
        let imageView:UIImageView = UIImageView.init(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))

        if self.imageData.count > indexPath.row{
            
            imageView.image = self.imageData[indexPath.row] as? UIImage
            
        } else {
            imageView.image = UIImage.init(named: "01.png")
        }
        cell.addSubview(imageView)
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let link = self.magazines[self.collectionView.indexPathForCell(sender as! UICollectionViewCell)!.row]
        if let dest = segue.destinationViewController as? WebViewController{
            dest.link = link.objectForKey("url") as! String
        }
        
    }

}

