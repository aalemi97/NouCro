//
//  GameParametersProvider.swift
//  NouCro
//
//  Created by AliReza on 2024-10-28.
//

import Foundation

protocol GameParametersProvider {
    func getPlayers(onCompletion: @escaping ([NCPlayer]) -> Void )
    func getGridSize(onCompletion: @escaping (NCGrid?) -> Void)
}
