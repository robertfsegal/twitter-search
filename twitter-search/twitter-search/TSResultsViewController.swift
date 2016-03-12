//
//  TSResultsViewController.swift
//  twitter-search
//
//  Created by Robert Segal on 2016-03-06.
//  Copyright © 2016 Get Set Games Inc. All rights reserved.
//

import Cocoa
import WebKit

class TSResultsViewController: NSViewController, NSSearchFieldDelegate, WebPolicyDelegate {

    @IBOutlet weak var search: NSSearchField!
    @IBOutlet weak var web: WebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func controlTextDidChange(obj: NSNotification)
    {
        let url = NSURL(string: "http://localhost:3000/tweets?s=" + search.stringValue)
        let req = NSURLRequest(URL: url!)
        
        web.mainFrame.loadRequest(req)
    }
    
    func webView(webView: WebView!, decidePolicyForNavigationAction
       actionInformation: [NSObject : AnyObject]!,
                 request: NSURLRequest!,
                   frame: WebFrame!,
        decisionListener listener: WebPolicyDecisionListener! )
    {
        let s = request.URL?.absoluteString
        
        if (s!.containsString("localhost") == false)
        {
            // open the url in an external application
            //
            NSWorkspace.sharedWorkspace().openURL(request.URL!)
            listener.ignore()
        }
        else
        {
            listener.use()
        }
    }
 
}
