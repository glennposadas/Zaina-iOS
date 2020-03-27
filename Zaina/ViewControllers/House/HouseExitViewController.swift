//
//  HouseExitViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 09/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class HouseExitViewController: BaseGameViewController {

  // MARK: - IBOutlets

  // MARK: - ViewController lifecycle

  private var playerView: ZainaSpriteView!
  private var omarView: OmarSpriteView!
  private var omarTimer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupOmar()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    startOmarTimer()
    showDialog()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "house_exit_message".localize,
                      firstButtonTitle: "house_exit_message_action".localize)
  }

  private func setup() {
    Status.currentLevel = 5
  }

  // MARK: - Add sprites

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: view.frame.width - 70, y: view.frame.height / 2)
    sceneView.addSubview(playerView)
  }

  private func setupOmar() {
    omarView = OmarSpriteView()
    omarView.frame.origin = CGPoint(x: view.frame.width - 40, y: view.frame.height / 2)
    omarView.moveTo(x: view.frame.width - 40, y: view.frame.height / 2)
    sceneView.addSubview(omarView)
  }

  // MARK: - Moving

  @objc
  private func moveOmar() {
    let x = playerView.frame.origin.x + playerView.frame.size.width
    let y = playerView.frame.origin.y + playerView.frame.size.width
    omarView.moveTo(x: x, y: y)
  }

  // MARK: - Timers

  private func startOmarTimer() {
    omarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(moveOmar), userInfo: nil, repeats: true)
    moveOmar()
  }

  private func stopOmarTimer() {
    omarTimer?.invalidate()
    omarTimer = nil
  }

  // MARK: - Collide

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.exit):
      return collideBetween(zaina: object1, andExit: object2)
    case (CollideTypes.exit, CollideTypes.zain):
      return collideBetween(zaina: object2, andExit: object1)
    default:
      return true
    }
  }

  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .forest, controller: ForestViewController.self))
    return false
  }
}
