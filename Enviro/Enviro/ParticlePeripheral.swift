//
//  ParticlePeripheral.swift
//  OB1 Visualizer
//
//  Created by Edward Handford on 05/03/2020.
//  Copyright © 2020 Edward Handford. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth




//Class created to contain UUID's - names ParticlePeripheral from inherited code
class ParticlePeripheral: NSObject {
//UUID's for TinyPico BLE device, which returns the text that is sent to it
 
    public static let particleLEDServiceUUID = CBUUID.init(string: "4FAFC201-1FB5-459E-8FCC-C5C9C331914B")
    public static let redLEDCharacteristicUUID = CBUUID.init(string: "BEB5483E-36E1-4688-B7F5-EA07361B26A8")
    
}
