//
//  WebViewController.swift
//  uistreet
//
//  Created by Amandeep Brar on 10/1/15.
//  Copyright © 2015 Amandeep Brar. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webloading: UIActivityIndicatorView!
    @IBOutlet weak var webview: UIWebView!
    var link = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        webloading.startAnimating()
        self.webview.backgroundColor = UIColor.clearColor()
        self.webview.opaque = false
        let request:NSURLRequest = NSURLRequest.init(URL: NSURL.init(string: link)!)
        webview.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webloading.stopAnimating()
    }
    

   
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
