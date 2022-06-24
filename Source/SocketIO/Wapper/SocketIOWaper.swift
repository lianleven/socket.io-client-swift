//
//  SocketIO.swift
//  SocketIOObjC
//
//  Created by GZ00015ML on 2022/6/24.
//

import Foundation

open class SocketIOWaper: NSObject {
//    @objc(shared)
//    static let `default` = SocketIOWaper()
//    private override init(){}
    
    @objc public var socket: SocketIOClient?
    @objc public var manage: SocketManager?
    @objc public var logTextAction:((_ log: String) -> ())?
    
    @objc
    open func connect(_ host: String) {
        if self.socket?.status == .connecting {
            self.logTextAction?("正在连接")
            return
        }
        if self.socket?.status == .connected {
            self.logTextAction?("已经连接")
            return
        }
        guard let url = URL(string: "http://\(host):50001") else {
            return
        }
        
        self.manage = SocketManager(socketURL: url, config: [.log(true), .compress])
        self.socket = self.manage?.socket(forNamespace: "/competitors")
        
        self.socket?.onAny({[weak self] event in
            self?.logTextAction?(event.event)
        })
        
        
        self.socket?.connect()
    }
    
}
