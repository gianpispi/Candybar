//
//  ViewController.swift
//  Candybar preferences
//
//  Created by Gianpiero Spinelli on 24/11/20.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        insertToolbar()
    }
    
    func insertToolbar() {
        // 1
        #if targetEnvironment(macCatalyst)
        
        // 2
        guard let scene = view.window?.windowScene else {
            return
        }
        
        // 3
        if let titleBar = scene.titlebar {
            // 4
            let toolBar = NSToolbar(identifier: "mainToolbar")
            toolBar.delegate = self
            
            toolBar.selectedItemIdentifier = ToolbarIdentifiers.general
            
            // 5
            titleBar.toolbarStyle = .preference
            
            // 6
            titleBar.toolbar = toolBar
        }
        #endif
    }
}

extension ViewController: NSToolbarDelegate {
    enum ToolbarIdentifiers {
        static let privacy = NSToolbarItem.Identifier(rawValue: "hand.raised")
        static let general = NSToolbarItem.Identifier(rawValue: "gear")
        static let tipJar = NSToolbarItem.Identifier(rawValue: "gift")
    }
    
    public func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [ToolbarIdentifiers.privacy, ToolbarIdentifiers.general, ToolbarIdentifiers.tipJar]
    }
    
    public func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [ToolbarIdentifiers.general, ToolbarIdentifiers.privacy, ToolbarIdentifiers.tipJar]
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [ToolbarIdentifiers.general, ToolbarIdentifiers.privacy, ToolbarIdentifiers.tipJar]
    }
    
    public func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarItem: NSToolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        
        switch itemIdentifier {
        case ToolbarIdentifiers.general:
            toolbarItem.action = #selector(showGeneral)
            toolbarItem.image = UIImage(systemName: "gear")
            toolbarItem.label = "General"
            
        case ToolbarIdentifiers.privacy:
            toolbarItem.action = #selector(showPrivacy)
            toolbarItem.image = UIImage(systemName: "hand.raised")
            toolbarItem.label = "Privacy"
            
        case ToolbarIdentifiers.tipJar:
            toolbarItem.action = #selector(showTipJar)
            toolbarItem.image = UIImage(systemName: "gift")
            toolbarItem.label = "Tip Jar"
            
        default:
            fatalError()
        }

        toolbarItem.isBordered = false
        
        return toolbarItem
    }
    
    @objc func showGeneral() {}
    @objc func showPrivacy() {}
    @objc func showTipJar() {}
}
