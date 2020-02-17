//
//  JsonParser.swift
//  ASA_assignment
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

protocol DownloadApps {
    var listOfApps : [AppModel]? { get set}
    func reloadTable()
}

class JsonParser{
    
    var delegate : DownloadApps!
    
    func downloaData() {
        let url = URL(string: "https://data.42matters.com/api/v2.0/ios/apps/top_appstore_charts.json?device_type=iphone&country=IN&limit=12&access_token=41fad933f911b11d8cbd646180950c9cacbdefc9")
        let urlSession = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let appData = data else {
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: appData, options: .allowFragments) as! NSDictionary
                let listOfApps = json.value(forKey: "app_list") as? NSArray
                guard let list = listOfApps else { return }
                let jsonData = try JSONSerialization.data(withJSONObject: list, options: [])
                let code = JSONDecoder()
                self.delegate.listOfApps = try code.decode([AppModel].self, from: jsonData)
                self.delegate.reloadTable()
            }
            catch{
                print("serialisation failed")
            }
            
        }
        urlSession.resume()
    }
}
