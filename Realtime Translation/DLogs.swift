//
//  DLogs.swift
//  Realtime Translation
//
//  Created by Pawan kumar on 19/06/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import Foundation

struct DLogs {

    //MARK:- Print Details

    static func logs<M,D>(printMessage: M, printDetails: D){

        let printMessage = String(describing: printMessage)
        let printDetails = String(describing: printDetails)
        print("DLogs:- \(printMessage):- \(printDetails)")
    }
}
