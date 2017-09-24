//
//  ViewController.swift
//  BarBrowse
//
//  Created by Tyler Angert on 4/27/17.
//  Copyright © 2017 Tyler Angert. All rights reserved.
//

import Cocoa
import WebKit

class BrowseViewController: NSViewController {

// MARK: IBOutlets 
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.layer?.cornerRadius = 30
            webView.layer?.masksToBounds = true
        }
    }
    
    @IBOutlet weak var searchBar: NSSearchField!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var tabsCollectionView: NSCollectionView!
    
    var searchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.sendsWholeSearchString = true
        
        webView.navigationDelegate = self
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

// MARK: IBActions
    
    @IBAction func goNext(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func refreshPage(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func quit(_ sender: Any) {
        NSApp.terminate(self)
    }
    
    func setSearchBar() {
        searchBar.stringValue = webView.url!.absoluteString
    }
    

}

// MARK: Delegates

extension BrowseViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Loading...")
        setSearchBar()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished!")
        setSearchBar()
    }
}

extension BrowseViewController: NSSearchFieldDelegate {
    
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        print("Start search")
        self.searchString = self.searchBar.stringValue
        let url = searchString?.formattedURL
        self.searchBar.stringValue = url!.absoluteString
        webView.load(URLRequest(url: url!))
    }
    
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        print("End searching")
    }
    
}

