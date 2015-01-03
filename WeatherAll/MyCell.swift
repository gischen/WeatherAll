//
//  MyCell.swift
//  WeatherAll
//
//  Created by Grapestree on 15/1/2.
//  Copyright (c) 2015年 Grapestree. All rights reserved.
//

import Foundation


import UIKit



class MyCell:UITableViewCell {
    
    
    @IBOutlet weak var img :UIImageView?
    @IBOutlet weak var title :UILabel?
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.img?.image = UIImage(contentsOfFile: "nm.jpg")
        self.title?.text = "print my cell"
        self.img?.addSubview(self)
        self.title?.addSubview(self)
        
        println("print my cell")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        println("print my cell")
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "MyCell")
    }
    
    override func select(sender: AnyObject?) {
        super.select(sender)
        
    }

}