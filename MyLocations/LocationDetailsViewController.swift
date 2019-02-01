//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by Nima Akbarzade on 11/5/1397 AP.
//  Copyright © 1397 AP Nima Akbarzade. All rights reserved.
//

import UIKit
import CoreLocation

private var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

class LocationDetailsViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: properties
    var coordinate = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    var placemark: CLPlacemark?
    
    var categoryName = "No Category"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        categoryLabel.text = categoryName
        
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        if let placemark = placemark {
            addressLabel.text = string(from: placemark)
        } else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: Date())
        
        // Hide Keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard(_ gestureRecognizer: UIGestureRecognizer) {
        let point = gestureRecognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if indexPath != nil && indexPath!.section == 0 && indexPath!.row == 0 {
            return
        }
        descriptionTextView.resignFirstResponder()
    }
    
    // MARK: Helper Methods
    func string(from placemark: CLPlacemark) -> String {
            var text = ""
            
            if let s = placemark.subThoroughfare {
                text += s + " "
            }
            if let s = placemark.subThoroughfare {
                text += s + ", "
            }
            if let s = placemark.locality {
                text += s + ", "
            }
            if let s = placemark.administrativeArea {
                text += s + " "
            }
            if let s = placemark.postalCode {
                text += s
            }
            if let s = placemark.country {
                text += s
            }
            return text
        }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "PickCategory" {
            let controller = segue.destination as! CategoryPickerViewController
            controller.selectedCategoryName = categoryName
        }
    }
    
    // MARK: Table View Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 || indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            descriptionTextView.becomeFirstResponder()
        }
    }
    
    // MARK: Actions
    @IBAction func categoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! CategoryPickerViewController
        categoryName = controller.selectedCategoryName
        categoryLabel.text = categoryName
    }
    
    @IBAction func done() {
//        navigationController?.popViewController(animated: true)
        let hudView = HudView.hud(inView: navigationController!.view, animated: true)
        hudView.text = "Tagged"
        afterDelay(0.6) {
            hudView.hide()
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
}
