//
//  TIPBadgeManager.swift
//  ExampleTIPBadgeManager
//
//  Created by John Coschigano on 6/16/15.
//  Copyright (c) 2015 John Coschigano. All rights reserved.
//

import UIKit

public class TIPBadgeManager {
    
    public static let sharedInstance = TIPBadgeManager()
    
    public var tipBadgeObjDict = [String : TIPBadgeObject]()
    
    private init() {}
    
    public func addBadgeSuperview(name: String, view: AnyObject){
        var badgeObj: TIPBadgeObject?
        
        if let superView = view as? UIView {
            badgeObj = TIPViewObject(view: superView)
        }
        else if let superView = view as? UITabBarItem {
            badgeObj = TIPTabBarItemObject(tabBar: superView)
        }
        tipBadgeObjDict[name] = badgeObj!
    }
    
    public func setBadgeValue(key : String, value : Int){
        tipBadgeObjDict[key]?.badgeValue = value
    }
    
    public func setAllBadgeValues(value : Int){
        for (key, _) in tipBadgeObjDict {
            if !isTIPViewObjNil(tipBadgeObjDict[key]!) || !isTIPTabBarItemObjNil(tipBadgeObjDict[key]!){
                setBadgeValue(key, value: value)
            }
        }
    }
    
    public func getBadgeValue(key : String) -> Int? {
        if tipBadgeObjDict[key] != nil {
            if !isTIPViewObjNil(tipBadgeObjDict[key]!) || !isTIPTabBarItemObjNil(tipBadgeObjDict[key]!){
                return tipBadgeObjDict[key]!.badgeValue
            }
        }
       return nil
    }
    
    func isTIPViewObjNil(tipBadgeObject: TIPBadgeObject) -> Bool{
        if let tipViewObject = tipBadgeObject as? TIPViewObject {
            if tipViewObject.view != nil {
                return false
            }
        }
        return true
    }
    
    func isTIPTabBarItemObjNil(tipBadgeObject: TIPBadgeObject) -> Bool{
        if let tipTabBarItemObject = tipBadgeObject as? TIPTabBarItemObject {
            if tipTabBarItemObject.tabBar != nil {
                return false
            }
        }
        return true
    }
    
    public func clearAllBadgeValues(clearAppIconBadge: Bool){
        clearAllBadgeValues()
        if clearAppIconBadge { clearAppBadgeValue() }
    }
    
    func clearAllBadgeValues(){
        for (key, _) in tipBadgeObjDict {
            setBadgeValue(key, value: 0)
        }
    }
    
    func clearAppBadgeValue() {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    public func removeBadgeObjFromDict(keys : [String]) {
        for key in keys {
            tipBadgeObjDict.removeValueForKey(key)
        }
    }
    
    //not yet called progammatically
    public func cleanBadgeObjectDict(){
        for (key, value) in tipBadgeObjDict {
            if let val = value as? TIPViewObject {
                cleanTipViewObject(key)
            }
            if let val = value as? TIPTabBarItemObject {
                cleanTipTabBarItemObject(key)
            }
        }
    }
    
    func cleanTipViewObject(key : String){
        var tipViewObj : TIPViewObject = tipBadgeObjDict[key] as! TIPViewObject
        if tipViewObj.view == nil {
            removeBadgeObjFromDict([key])
        }
    }
    
    func cleanTipTabBarItemObject(key : String){
        var tipTabBarItemObj : TIPTabBarItemObject = tipBadgeObjDict[key] as! TIPTabBarItemObject
        if tipTabBarItemObj.tabBar == nil {
            removeBadgeObjFromDict([key])
        }
    }
    
}
