//
//  NetWorker.swift
//  WeatherAll
//
//  Created by Grapestree on 14/12/19.
//  Copyright (c) 2014年 Grapestree. All rights reserved.
//

import Foundation



class NetWorker:NSObject{
    override init(){
        self.RequestUrl = "http://news-at.zhihu.com/api/3/news/latest"
        Manager = HTTPTask()
        wokState = false
    }
    
    var wokState :Bool?
    
    var Manager:HTTPTask{
        didSet{
            Manager = HTTPTask()
        }
    }
    
    var RequestUrl:String?{
        didSet{
            RequestUrl = "http://news-at.zhihu.com/api/3/news/latest"
        }
    }
    
    func GetObject(itemList :ZhihuTodayNews){
        Manager.GET(RequestUrl!, parameters: nil,
            success: {
                (operation :HTTPResponse!) in (itemList.GetTodayNews(operation))
                self.wokState = true
                println("fetchstatu show : \(self.wokState) ")
            },
            failure: {
                (error :NSError!,operation :HTTPResponse?) in println(operation?.statusCode)
                println("failure \(self.RequestUrl)")
                self.wokState = false
                println("fetchstatu show : \(self.wokState) ")
            }
        )
    }
    
    
    func GetImageObject(itemList :ZhihuTodayNews ,index :Int){
        var Manager_temp = HTTPTask()
        Manager_temp.GET(itemList.GetNewsImageUrl(index), parameters: nil,
            success: {
                (operation :HTTPResponse!) in (itemList.GetTodayNewsImage(operation,index: index))
            },
            failure: {
                (error :NSError!,operation :HTTPResponse?) in println(operation?.statusCode)
            }
        )
    }
    
    
}