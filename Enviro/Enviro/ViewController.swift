//  ViewController.swift
//  OB1 Visualizer
//
//  Created by Edward Handford on 04/03/2020.
//  Copyright © 2020 Edward Handford. All rights reserved.


//importing necessary libraries
import UIKit
import CoreBluetooth


//Bluetooth Flow
//Status Update -> Did Discover -> Did Connect -> Discover Services ->  Discover Characters

//Added CBPeripheralDelegate and CBCentralManagerDelegate
//CBPeripheralDelegate - A protocol that provides updates on the use of a peripherals services
//CBCentralMagagerDelegate - A protocol that provides updates for the discober
//and management of peripheral devices

class ViewController: UIViewController, CBPeripheralDelegate, UITextFieldDelegate, CBCentralManagerDelegate {


//add UITextFieldDelegate once actually in use
//UITextFieldDelegate,
    
//------------------------BLUETOOTH SETUP AND CONNECT SECTION-----------------------------
    
    //Intialising variables recieved from BLE
    private var redChar: CBCharacteristic?

    //Variables to store the central manager and peripheral
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    //Default function
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        }
    
    //Default function - with addition to allow central
     override func viewDidLoad() {
        super.viewDidLoad()
        print("View Loaded")
         //allows central to change its own state
         centralManager = CBCentralManager(delegate: self, queue: nil)
        }

    // updates when bluetooth peripheral is switched on or off.
    //Will update when app is first loaded
    //Will start scanning if powered on
    //has app started and/or bluetooth peripheral switched on or off, if so begin scan
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
            print("Central State Update")
            if central.state != .poweredOn {
                print("Central is not powered on")
            } else {
                print("Central is scanning for", ParticlePeripheral.particleLEDServiceUUID);
                centralManager.scanForPeripherals(withServices: [ParticlePeripheral.particleLEDServiceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
                }
            }

    //Handles the result of the BLE scan
    //event occurs when scan results are received
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber)
            {
                
            //found the device so stop the scan
            self.centralManager.stopScan()
            
            //copy the peripheral instance
            self.peripheral = peripheral
            self.peripheral.delegate = self
    
            //connect
            self.centralManager.connect(self.peripheral, options: nil)
            }
    
    // handles discovery event
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == ParticlePeripheral.particleLEDServiceUUID {
                    print("Random Hex service found")
                    //now start discovery of characteristics
                    peripheral.discoverCharacteristics([ParticlePeripheral.redLEDCharacteristicUUID], for: service)
                    return
                    }
                }
            }
        }
    
     func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
         if peripheral == self.peripheral{
         print("Connected to the BLE board!!")
             peripheral.discoverServices([ParticlePeripheral.particleLEDServiceUUID])
             }
         }
    
    //Handles discovery of characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == ParticlePeripheral.redLEDCharacteristicUUID {
                    print("rand hex characteristic found")
                    redChar = characteristic
                    print((redChar!))
                  //  print(characteristic.value)
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    
    func peripheral( _ peripheral:CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?){
        if (characteristic == redChar) {
            print(characteristic.value![0])
          //  let percent = "%"
            serialread.text = "\(characteristic.value![0])" + "%" //+ percent
            
        }
    }

//------------------------END OF BLUETOOTH SETUP AND CONNECT SECTION-----------------------------
    

 
    
    
    
//----------------Work In Progress Section---------------------------
    
  
    
// Label Field Containing User Entered Device UUID
    @IBOutlet weak var UserEnteredUUID: UITextField!
    
    
  //  @IBAction func UUIDEnter(_ sender: Any) {
  //  }
    
    @IBAction func UUIDEnterButton(_ sender: UIButton) {
    }
    
    //UILabel which reads out the BLE raw Characteristic
    @IBOutlet weak var serialread: UILabel!

//-------------------End of Work in Progress Section---------------------
    
 
    
    
 
    
    
    

    
    
    
    
    
//Final View Controller Bracket
}


