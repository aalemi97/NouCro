//
//  Viewable.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import Foundation

protocol Viewable: AnyObject {
    func show(result: Result<Any, NCError>)
}
