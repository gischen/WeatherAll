//
//  DetailViewController.swift
//  WeatherAll
//
//  Created by Grapestree on 14/12/16.
//  Copyright (c) 2014年 Grapestree. All rights reserved.
//

import UIKit


/*extension UILabel{
    func TapRecAction(){
        println("hello")
        
        
    }
    func initGesture(){
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: "TapRecAction")
        
        self.addGestureRecognizer(tapRec)
        
        self.userInteractionEnabled = true
    }
}*/

class MyLabel: UILabel {
    func TapRecAction(){
        TT?.OpFamily()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initGesture()
        TT = FetchController()
    }
    
    var TT :FetchController? {
        didSet {
            TT = FetchController()
        }
    }

    let tapRec = UITapGestureRecognizer()
    
    func initGesture(){
        
        tapRec.addTarget(self, action: "TapRecAction")
        
        self.addGestureRecognizer(tapRec)
        
        self.userInteractionEnabled = true
    }
}

class DetailViewController: UIViewController {

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.editing = false
        
    }

    @IBOutlet weak var detailDescriptionLabel: UIWebView!
    

    var idItem: String? {
        didSet{
        }
    }
    
    var titleItem: String? {
        didSet{
        }
    }
    
    var themeItem: String? {
        didSet{
        }
    }
    
    var TargetUrl :String?{
        didSet{
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        //var urlpath = "http://daily.zhihu.com/story/4414133"
        //urlpath.extend(idItem!)
        self.title = titleItem
        if TargetUrl?.isEmpty == true{
            TargetUrl = "grapes.ico"
        }
        var linkURL = NSURL(string: TargetUrl!)
        var webReqest = NSURLRequest(URL: linkURL!)
        detailDescriptionLabel.loadRequest(webReqest)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

