//
//  ManageLampViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/22/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import CoreCityOS
import RxSwift
import RxCocoa

enum LampControlAction: String {
    case TurnOn = "Turn on"
    case TurnOff = "Turn off"
    case Name = "Name"
    case Location = "Location"
    
    var controlImage: UIImage? {
        switch  self {
        case .TurnOn:
            return UIImage(named: "turn-on")
        case .TurnOff:
            return UIImage(named: "turn-off")
        default:
            return nil
        }
    }
    
    static func controlsArray() -> [LampControlAction] {
        let array: [LampControlAction] = [
            .TurnOn,
            .TurnOff,
            .Name,
            .Location
        ]
        return array
    }
    
    var defaultValue: String {
        switch  self {
        case .TurnOn:
            return "At sunrise"
        case .TurnOff:
            return "At sunset"
        case .Name:
            return "Lamp name"
        case .Location:
            return "Retrieving location ..."
        }
    }
}

class ManageLampViewController: UIViewController {
    
    //MARK: Class properties
    var lamp: DeviceType!
    lazy var controls = LampControlAction.controlsArray()
    
    //MARK: Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var controlLightContainerView: UIView!
    @IBOutlet weak var lightControlSlider: UISlider!
    @IBOutlet weak var lightControlSliderValueLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(lamp != nil, "View loaded without lamp property set")
        
        title = "Manage \(lamp.name ?? "lamp")"

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        lightControlSlider
            .rx_value
            .map { NSString(format: "%.0f", $0) as String }
            .bindTo(lightControlSliderValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        lightControlSlider
            .rx_value
            .asDriver()
            .throttle(1)
            .asObservable()
            .map { Int(round($0)) }
            .share()
            .subscribeNext { print($0) }
            .addDisposableTo(disposeBag)
        
         Observable
            .just(controls.map { $0 })
            .bindTo(tableView.rx_itemsWithCellIdentifier("manageLampCell",
                cellType: LampControlTableViewCell.self)) { row,controlItem, cell in
                cell.controlItem = controlItem
                
                if controlItem == .Name {
                    cell.rightTitleLabel.text = self.lamp.name ?? ""
                }
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}