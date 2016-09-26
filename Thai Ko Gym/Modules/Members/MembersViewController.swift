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

    @IBOutlet var collectionView: UICollectionView!

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        // Setup navigation bar.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(sender:)))

        // Setup collection view.
        let layout = GridCollectionViewLayout()
        layout.itemsPerRow = viewModel.numberOfItemsPerRow(for: traitCollection)
        layout.itemSpacing = 4
        layout.itemHeightRatio = 3/4
        collectionView.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = true

        // Bindings
        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
            viewModel.hasSelection.bind(to: rightBarButtonItem.bnd_isEnabled)
        }

        // Pull to refresh
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(fetchMembers), for: .valueChanged)
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
        self.collectionView.refreshControl?.beginRefreshing()

        print("🚃 Start fetching members")
        viewModel.fetchMembers { result in
            print("🚃 Fetched members", result.objects?.count)

            self.viewModel.members = result.objects as? [Member]
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
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

    func save(sender: AnyObject) {
        ProgressHUD.present(on: view)

        viewModel.save(items: selectedItems) { result in
            ProgressHUD.dismiss(on: self.view)

            print("✅ Finished saving")

            let controller = UIAlertController(title: "Presences", message: "All the presences are registered online.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                for indexPath in self.collectionView.indexPathsForSelectedItems ?? [IndexPath]() {
                    self.collectionView.deselectItem(at: indexPath, animated: true)
                }
            }))
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
