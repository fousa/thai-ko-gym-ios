//
//  MembersViewController.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import BSGridCollectionViewLayout
import Bond

class MembersViewController: UIViewController {

    // MARK: - View Model

    fileprivate let viewModel = MembersViewModel()

    // MARK: - Selections

    fileprivate var selectedItems: [Int]? {
        return collectionView.indexPathsForSelectedItems?.map { $0.item }
    }

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolbarBottomConstraint: NSLayoutConstraint!

    // MARK: - Search

    private var searchController: UISearchController!

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        // Setup navigation bar.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout(sender:)))

        // Setup collection view.
        let layout = GridCollectionViewLayout()
        layout.itemsPerRow = viewModel.numberOfItemsPerRow(for: traitCollection)
        layout.itemSpacing = 4
        layout.itemHeightRatio = 3/4
        collectionView.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = true

        // Bindings
        viewModel.hasSelection.observeNext(with: { hasSelection in
            self.toolbarIsHidden = !hasSelection
        }).disposeIn(bnd_bag)

        // Pull to refresh
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchMembers), for: .valueChanged)

        // Setup searchController
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        if let field = searchController.searchBar.value(forKey:"searchField") as? UITextField {
            field.backgroundColor = UIColor(red:0.88, green:0.90, blue:0.93, alpha:1.00)
            field.textColor = UIColor(red:0.21, green:0.25, blue:0.31, alpha:1.00)
            field.tintColor = UIColor(red:0.24, green:0.77, blue:0.82, alpha:1.00)
        }
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if let refreshControl = self.collectionView.refreshControl {
            self.collectionView.setContentOffset(CGPoint(x: 0, y: refreshControl.frame.height), animated: true)
        }
        fetchMembers()
    }

    // MARK: - Fetching

    func fetchMembers() {
        searchController.isActive = false
        collectionView.refreshControl?.beginRefreshing()

        print("🚃 Start fetching members")
        viewModel.fetchMembers { result in
            print("🚃 Fetched members", result.objects?.count)

            self.viewModel.members = result.objects as? [Member]
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
            self.toolbarIsHidden = true
        }
    }

    // MARK: - Actions

    func logout(sender: AnyObject) {
        let controller = UIAlertController(title: "Logout", message: "Are you sure you want to log out? You will lose all your current data on the device.", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
            self.viewModel.logout()
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        present(controller, animated: true, completion: nil)
    }

    @IBAction func clearSelection(sender: AnyObject) {
        print("🎯 Clearing selection")

        let controller = UIAlertController(title: "Clear selection", message: "Are you sure you want to clear the current selection? This can not be undone.", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
            for indexPath in self.collectionView.indexPathsForSelectedItems ?? [IndexPath]() {
                self.collectionView.deselectItem(at: indexPath, animated: true)
            }
            self.toolbarIsHidden = true
        }))
        present(controller, animated: true, completion: nil)
    }

    @IBAction func save(sender: AnyObject) {
        ProgressHUD.present(on: view)

        viewModel.save(items: selectedItems) { result in
            ProgressHUD.dismiss(on: self.view)

            print("✅ Finished saving")
            for indexPath in self.collectionView.indexPathsForSelectedItems ?? [IndexPath]() {
                self.collectionView.deselectItem(at: indexPath, animated: true)
            }
            self.toolbarIsHidden = true

            let controller = UIAlertController(title: "Presences", message: "All the presences are registered online.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }

    // MARK: - Rotation

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: traitCollection, with: coordinator)

        if let layout = self.collectionView.collectionViewLayout as? GridCollectionViewLayout {
            layout.itemsPerRow = self.viewModel.numberOfItemsPerRow(for: newCollection)
        }
    }

    // MARK: - Toolbar

    fileprivate var toolbarIsHidden: Bool = true {
        didSet {
            toolbarBottomConstraint.priority = toolbarIsHidden ? UILayoutPriorityDefaultLow : UILayoutPriorityDefaultHigh
            UIView.animate(withDuration: 0.35) { 
                self.view.layoutIfNeeded()
            }
        }
    }

}

extension MembersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.members?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MemberCollectionViewCell

        let member = viewModel.members![indexPath.item]
        cell.configure(presentation: member)
        return cell
    }

}

extension MembersViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.select(items: selectedItems)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.select(items: selectedItems)
    }

}

extension MembersViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

    }

}
