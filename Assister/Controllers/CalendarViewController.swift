//
//  SecondViewController.swift
//  Assister
//
//  Created by Sana on 15/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var calendar: FSCalendar!
    @IBOutlet  var consultationsTable: UITableView?
    @IBOutlet weak var addButton: UIImageView!
    @IBOutlet weak var noConsultations: UIImageView!

    var consultations: [Consultation]? = []
    var filteredConsultations = [Consultation]() {
          didSet {
            self.consultationsTable!.reloadData()
          }
      }

    override func viewDidLoad() {
        super.viewDidLoad()

        initCalendar()
        initTable()
        styleViews()
        initEventHandlers()

    }

    func initEventHandlers() {
          // Option Button
          let tap = UITapGestureRecognizer(target: self, action: #selector(CalendarViewController.openForm(gesture:)))
          addButton?.addGestureRecognizer(tap)
          addButton?.isUserInteractionEnabled = true

      }

    func setCalendarDate(date: Date) {
        print(date)
        calendar.select(date)
    }

    @objc func openForm(gesture: UIGestureRecognizer) {

              if (gesture.view as? UIImageView) != nil {
               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let PatientVC = storyBoard.instantiateViewController(withIdentifier: "ConsultationFormViewController") as! ConsultationFormViewController
              PatientVC.modalPresentationStyle = .fullScreen

              self.present(PatientVC, animated: true, completion: nil)
              let today = self.calendar.today

                setCalendarDate(date: today!)
           }
       }

    func styleViews() {
        // Style the add Button
        addButton?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        addButton?.layer.shadowOpacity = 0.1
        addButton?.layer.shadowRadius = 4.0
        addButton?.layer.masksToBounds = false
    }

    func initCalendar() {
        calendar.delegate = self
        let today = calendar.today

        filterConsultations(date: today!)
    }

    func filterConsultations(date: Date) {
        self.filteredConsultations = (self.consultations?.filter {
        consult in

        if Calendar.current.isDate(date, inSameDayAs: consult.getDateTime()) {
            return true
        } else {
            return false
        }

        })!

        print(filteredConsultations.count)
        if filteredConsultations.count == 0 {
            noConsultations.isHidden = false
        } else {
            noConsultations.isHidden = true

        }
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        filterConsultations(date: date)

    }

    func initTable() {
        let rowHeight = UIDevice.current.userInterfaceIdiom == .pad ? 120 : 90

        consultationsTable?.rowHeight = CGFloat(rowHeight)

        consultationsTable?.dataSource = self
        consultationsTable?.delegate = self

        // Data
        DataService.shared.getConsultations().subscribe {
            elements in
            if let data = elements.element {
                self.consultations = data
                self.consultationsTable?.reloadData()

            }
            // Update selected date consultations
            let today = self.calendar.today
            self.filterConsultations(date: today!)
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.filteredConsultations.count

     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: "NotifCell") as! HomeTableViewCell

             let customerName = filteredConsultations[indexPath.row].getCustomer()?.getName()
             let date = filteredConsultations[indexPath.row].getDateTimeString()

             let gender = filteredConsultations[indexPath.row].getCustomer()?.getGender()

             cell.cellTitle.text = customerName!
             cell.cellTitle.sizeToFit()

             cell.cellSubTitle.text = "Consultation on " + date
             cell.cellSubTitle.sizeToFit()

             if gender == "female" {

                      var image: UIImage = UIImage(named: "female")!

                      cell.cellIcon.image = image
             } else {
                      var image: UIImage = UIImage(named: "male")!

                      cell.cellIcon.image = image
             }

            // Edit event handler
        cell.editButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.editConsultation(sender:))))

            cell.editButton?.isUserInteractionEnabled = true

             return cell
     }

    @objc func editConsultation( sender: UITapGestureRecognizer) {

        // using sender, we can get the point in respect to the table view
        let tapLocation = sender.location(in: self.consultationsTable)

        // using the tapLocation, we retrieve the corresponding indexPath
        let indexPath = self.consultationsTable!.indexPathForRow(at: tapLocation)
        let consult = filteredConsultations[indexPath!.row]

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let form = storyBoard.instantiateViewController(withIdentifier: "ConsultationFormViewController") as! ConsultationFormViewController
               form.modalPresentationStyle = .fullScreen
        self.present(form, animated: true, completion: nil)

        form.editConsultation(consultation: consult)
        let today = self.calendar.today

        setCalendarDate(date: today!)

        }

}
