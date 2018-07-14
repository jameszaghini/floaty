//
//  WebWindowController.swift
//  Floaty
//
//  Created by James Zaghini on 10/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa
import RxSwift

class WebWindowController: NSWindowController, Serviceable {

    private let disposeBag = DisposeBag()
    private var trafficLightsObserver: Disposable?

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.hideTrafficLights(true)
        window?.appearance = NSAppearance(named: .vibrantDark)

        trafficLightsObserver = services.settings.trafficLightsEnabled.asObservable().subscribe(onNext: { [weak self] hide in
            self?.window?.hideTrafficLights(hide)
        })
    }

}
