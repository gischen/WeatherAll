//
//  ZhihuNewsItem.swift
//  WeatherAll
//
//  Created by Grapestree on 14/12/16.
//  Copyright (c) 2014年 Grapestree. All rights reserved.
//

import Foundation
import UIKit


var Zhihu_news_Url = "http://news-at.zhihu.com/api/3/news/latest"
let Share_url_fix = "http://daily.zhihu.com/story/"

/*
{
  "theme_name":"电影日报",
  "subscribed":false,
  "title":"一月美剧指南：8 部新剧登场",
  "ga_prefix":"010114",
  "images":["http:\/\/pic3.zhimg.com\/3a38d65e76a7ee8c30aaa5e25fa5c145_t.jpg"],
  "theme_id":3,
  "type":0,
  "id":4416678
}
*/

class AllNewsManager: NSObject {
    
    override init(){
        itemList = Array<ZhihuTodayNews>()
        worker = NetWorker()
        //LocalCache = FetchController()
    }
    var itemList :Array<ZhihuTodayNews>
    var date :NSDate?
    
    var worker :NetWorker?
    
    //var LocalCache :FetchController? {
    //    didSet {
    //        LocalCache = FetchController()
    //    }
    //}
    
    func GetSomeDayNews(index :Int)->ZhihuTodayNews?{
        if index < 0{
            return nil
        }
        return self.itemList[index]
    }
    //
    //  later here will add a cache ,in case user want to browse the news before today 
    //  &&　in cese network down can't updata case
    //
    func InsertSomeDayNews(urlpath:String){
        var Todaynews = ZhihuTodayNews()
        worker?.RequestUrl = urlpath
        worker?.GetObject(Todaynews)
        self.itemList.append(Todaynews)
    }

}

class ZhihuTodayNews:NSObject,NilLiteralConvertible{
    var date :String?
    var story :Array<JSON>?
    var topstory :Array<JSON>?
    var data :NSData?
    var TodayNewsJson: JSON = JSON.nullJSON
    
    
    var imageData:Dictionary<Int,NSData>?
    
    override init(){
        data = NSData()
    }
    
    init(msg :String){
        println(msg)
        data = NSData()
    }
    
    required init(nilLiteral: ()) {
        //super.init(NSNull())
    }
    
    func GetTodayNews(resp:HTTPResponse){
        data = resp.responseObject as? NSData
        
        TodayNewsJson = JSON(data:data!)
        
        self.date = TodayNewsJson["date"].stringValue
        self.story = TodayNewsJson["stories"].arrayValue
        self.topstory = TodayNewsJson["top_stories"].arrayValue
        
        for var index = 0;index < self.TotalAllNewsToday();index++
        {
            //添加异步线程获取图片
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                for var i = 0; i < 5; i++
                {
                    println("hello dispatch_get_global_queue")
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    println("hello dispatch_get_main_queue")
                })
            })
        }
        
        self.SetCellRaw(0)
        
    }
    
    func TotalTopNewsToday()->Int{
        var count :Int = self.topstory?.count as Int!
        return count
    }
    func TotalAllNewsToday()->Int{
        var count :Int = self.story?.count as Int!
        return count
    }
    
    func GetNewsDate()->String?{
        return self.date as String!
    }
    
    func SetCellRaw(index :Int){
        var num :Int = self.TotalAllNewsToday()
        if index < 0{
            println("overflow ")
        }else if index > num{
            println("overflow ")
        }
        /*
        println(self.story?[index].dictionaryValue["theme_name"])
        println(self.story?[index].dictionaryValue["subscribed"])
        println(self.story?[index].dictionaryValue["title"])
        println(self.story?[index].dictionaryValue["image"])
        println(self.story?[index].dictionaryValue["ga_prefix"])
        
        println(self.story?[index].dictionaryValue["theme_id"])
        println(self.story?[index].dictionaryValue["images"]?[0])
        println(self.story?[index].dictionaryValue["multipic"])
        
        println(self.story?[index].dictionaryValue["type"])
        println(self.story?[index].dictionaryValue["id"])
        */

    }
    
    func GetThemenameContentUrl(index :Int)->String?{
        var url = self.story?[index].dictionaryValue["theme_name"]
        return url?.stringValue
    }
    
    func GetSubscribContentUrl(index :Int)->String?{
        var url = self.story?[index].dictionaryValue["subscribed"]
        return url?.stringValue
    }
    
    func GetNewsTitle(index :Int)->String?{
        var url = self.story?[index].dictionaryValue["title"]
        return url?.stringValue
    }
    
    func GetNewsImageUrl(index :Int)->String{
        var url = self.story?[index].dictionaryValue["image"]?[0].stringValue
        return url!
    }
    
    func GetGa_prefixContentUrl(index :Int)->String?{
        var url = self.story?[index].dictionaryValue["ga_prefix"]
        return url?.stringValue
    }
    
    func GetTheme_idContentUrl(index :Int)->String?{
        var url = self.story?[index].dictionaryValue["theme_id"]
        return url?.stringValue
    }
    
    func GetMultipicContentUrl(index :Int)->Bool?{
        var url = self.story?[index].dictionaryValue["multipic"]
        return url?.boolValue
    }
    
    func GetTypeContentUrl(index :Int)->String?{
        var url = self.story?[index].dictionaryValue["type"]
        return url?.stringValue
    }
    
    func _GetNewsContentUrl(index :Int)->String?{
        var temp = self.story?[index].dictionaryValue["id"]
        return temp?.stringValue
    }
    
    func GetNewsContentUrl(index :Int)->String?{
        var url = Share_url_fix + _GetNewsContentUrl(index)!
        return url
    }
}


class ZhiHuNewsItem:NSObject{
    override init(){
        println("ZhiHuNewsItem has been init")
    }
    var Theme_name :String?
    var Subscribed :Bool?
    var title :String?
    var image :String?
    var share_url :String?
    var ga_prefix :String?
    var theme_id:String?
    var images :Array<String>?
    var multipic :Bool?
    var type :String?
    var id :String?
    
    
    func ShowItem()->String{
        println("this item info :\(self.Theme_name) \n :\(self.Theme_name) \n ")
        return self.title!
    }
}