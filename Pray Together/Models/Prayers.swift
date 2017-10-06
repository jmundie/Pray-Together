//
//  Prayers.swift
//  Pray Together
//
//  Created by Jason Mundie on 10/5/17.
//  Copyright © 2017 Jason Mundie. All rights reserved.
//

import Foundation

class Prayers {
    
    private var _prayerContent: String
    private var _senderId: String
    
    var prayerContent: String {
        return _prayerContent
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(prayerContent: String, senderId: String) {
        self._prayerContent = prayerContent
        self._senderId = senderId
    }
}
