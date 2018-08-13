//
//  RepositoriesTableViewController.swift
//  SearchGitHub
//
//  Created by Marcos Suarez on 17/7/18.
//  Copyright © 2018 Marcos Suarez. All rights reserved.
//

import UIKit
import SafariServices

class SearchTableVC: UIViewController, SFSafariViewControllerDelegate {
    
    var presenter: SearchPresenter?
    
    var repositories = [DataClient]()
    
    var loadingIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnPublicProyects: UIButton!
    
    override func viewDidLoad() {
        
        // Presenter
        presenter = SearchPresenter(withView: self)
        
        // Add background image
        let imageBackground = UIImageView(image: UIImage(named: "github-octocat.png"))
        imageBackground.contentMode = .scaleAspectFit
        tableView.backgroundColor = UIColor.lightGray
        tableView.backgroundView = imageBackground
        
        // Activity indicator
        setupLoading()
        
        // Button public proyects
        btnPublicProyects.tintColor = .white
        btnPublicProyects.backgroundColor = tableView.backgroundColor
    }
    
    // MARK: - Methods
    func setupLoading() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .whiteLarge
        loadingIndicator.stopAnimating()
        loadingIndicator.center = self.view.center
        loadingIndicator.layer.backgroundColor = UIColor.black.cgColor
        self.view.addSubview(loadingIndicator)
    }

    // MARK: - Safari
    private func goRepositoryDetail(url: String) {
        
        guard let urlrepository = URL(string: url) else { return }
        
        let safari = SFSafariViewController(url: urlrepository)
        
        present(safari, animated: true)
        
        safari.delegate = self
    }
    
    // MARK: - Search
    func startSearch() {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        repositories.removeAll()
        tableView.reloadData()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        let filter:GHFilters = isPressed ? .publicProyects : .none
        
        presenter?.search(by: searchText, filter: filter)
    }
    
    var isPressed:Bool = false
    // MARK: - Filter proyects
    @IBAction func pressedFilterButton(_ sender: UIButton) {
       
        isPressed = !isPressed
        sender.tintColor = (isPressed) ? searchBar.tintColor : .white
        startSearch()
    }
}

extension SearchTableVC: SearchPresenterProtocol {

    func nextPage(repositories: [DataClient]) {
        self.repositories += repositories
        
        print("TOTAL repositorios en móvil: ",repositories.count)
        
        print("página Anterior", APIGitHub.shared.pagination.previosPage)
        print("página Siguiente", APIGitHub.shared.pagination.nextPage)
        print("ultima página: ",APIGitHub.shared.pagination.lastPage)
    }
    
    
    func resultFor(repositories: [DataClient]) {
        self.repositories += repositories
        print("TOTAL repositorios en móvil: ",repositories.count)
        
        print("página Anterior", APIGitHub.shared.pagination.previosPage)
        print("página Siguiente", APIGitHub.shared.pagination.nextPage)
        print("ultima página: ",APIGitHub.shared.pagination.lastPage)
    }
    
    func beginSearch() {
        print("Se inicio la busqueda")
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        repositories.removeAll()
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        tableView.reloadData()
    }
    
    func finishSearch() {
        print("Finalizó la busqueda")
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    
}

extension SearchTableVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoCell
        
        cell.load(repo: repositories[indexPath.row])
        
        // Control page.
        if  indexPath.row == Int((repositories.count - 1) * 3/4) {
            presenter?.updatePagination()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to detail.
        goRepositoryDetail(url: repositories[indexPath.row].repoAddress)
    }
}

//MARK: - Search bar
extension SearchTableVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
