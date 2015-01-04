//
//  MasterViewController.swift
//  WeatherAll
//
//  Created by Grapestree on 14/12/16.
//  Copyright (c) 2014年 Grapestree. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController{

    var newsManager: AllNewsManager? = nil
    
    @IBOutlet var loadingIndicator : UIActivityIndicatorView! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(){
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder :aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "今日热闻"
        //var cellnib = UINib(nibName: "MyCellD", bundle: nil)
        //self.tableView?.registerNib(cellnib, forCellReuseIdentifier: "MyCell")
        
        self.loadingIndicator.startAnimating()

        while (self.newsManager?.worker?.wokState != true){
            sleep(1)
        }
        self.newsManager?.GetInsertNewsImage(0)
        sleep(10)
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        println("insert object")
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
            (segue.destinationViewController as DetailViewController).TargetUrl = newsManager?.GetSomeDayNews(0)?.GetNewsContentUrl(indexPath.item)
            (segue.destinationViewController as DetailViewController).titleItem = newsManager?.GetSomeDayNews(0)?.GetNewsTitle(indexPath.item)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count :Int = self.newsManager?.GetSomeDayNews(0)?.TotalAllNewsToday() as Int!
        return count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        //cell.textLabel!.text = newsManager?.GetSomeDayNews(0)?.GetNewsTitle(0)
        //println(newsManager?.GetSomeDayNews(0)?.story?[0].dictionaryValue["image"])
        //println(newsManager?.GetSomeDayNews(0)?.story?[0].dictionaryValue["images"]?[0])
        //cell.imageView?.image = UIImage(contentsOfFile: newsManager?.GetSomeDayNews(0)?.GetNewsImageUrl(0) as String!)
        cell.textLabel!.text = newsManager?.GetSomeDayNews(0)?.GetNewsTitle(indexPath.item)
        
        //let img :UIImage = UIImage(named :"nm.jpg")!
        cell.imageView?.image = self.newsManager?.GetSomeDayNews(0)?.GetImageByIndex(indexPath.item)
        
        
        println(cell.textLabel?.text?.debugDescription)
        println(cell.imageView?.image?.debugDescription)
        //println(img.debugDescription)
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
    }
    

}

