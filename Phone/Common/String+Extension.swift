//
//  String+Extension.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

extension String {
    var endpoint: String? {
        return Bundle.main.infoDictionary?[self] as? String 
    }
}
