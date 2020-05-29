//
//  File.swift
//  DataStructuresProfiling
//
//  Created by Павел on 29.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import UIKit

private enum SuffixArrayVCRow: Int {
    case creation = 0,
    sort,
    find,
    number
}

class SAViewController: DataStructuresViewController {
    
    //MARK: - Variables
    
    let suffixArrayManipulator: SuffixArrayManipulator = SAManipulator()
    
    var creationTime: TimeInterval = 0
    var sortingTime: TimeInterval = 0
    var findingTime: TimeInterval = 0
    var numberOfCoincidences: Int = 0
    
    //MARK: - Methods

    //MARK: View lifecycle

    override func viewDidLoad() {
      super.viewDidLoad()
      createAndTestButton.setTitle("Create Suffix Array and Test", for: UIControl.State())
    }

    //MARK: Superclass creation/testing overrides

    override func create(_ size: Int) {
        creationTime = suffixArrayManipulator.addObjects()
        sortingTime = suffixArrayManipulator.sort()
    }

    override func test() {
        if suffixArrayManipulator.hasEntries() {
            (findingTime, numberOfCoincidences) = suffixArrayManipulator.find(self.numberOfItems)
        } else {
            print("Suffix Array not yet set up!")
        }
    }
    
    //MARK: Table View Override
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //There are always 4 items
      return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        switch (indexPath as NSIndexPath).row {
        case SuffixArrayVCRow.creation.rawValue:
            cell.textLabel!.text = "Suffix Array creation:"
            cell.detailTextLabel!.text = formattedTime(creationTime)
        case SuffixArrayVCRow.sort.rawValue:
            cell.textLabel!.text = "Suffix Array sorting:"
            cell.detailTextLabel!.text = formattedTime(sortingTime)
        case SuffixArrayVCRow.find.rawValue:
            cell.textLabel!.text = "Suffix Array find sequences:"
            cell.detailTextLabel!.text = formattedTime(findingTime)
        case SuffixArrayVCRow.number.rawValue:
            cell.textLabel!.text = "Suffix Array number of findings:"
            cell.detailTextLabel!.text = String(numberOfCoincidences)
        default:
            print("Unhandled row! \((indexPath as NSIndexPath).row)")
        }
        
        return cell
    }
    
}
