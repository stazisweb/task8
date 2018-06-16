//
//  TrainingViewController.swift
//  8
//
//  Created by Кривогузов Владислав on 15.06.18.
//  Copyright © 2018 Кривогузов Владислав. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var distanceTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var stepTF: UITextField!
    var dict = [String: [String]]()
    let df = DateFormatter()
    @IBAction func addTrainingClick(_ sender: Any) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true) as NSArray
        let documentDirectory = paths[0] as? String
        let path = documentDirectory?.appending("TrainingData")
       
       
       let date = df.string(from: datePicker.date)
        if typeTF.text != "",durationTF.text != "",stepTF.text != "",distanceTF.text != ""{
        dict["date"]?.append(date)
        dict["type"]?.append(typeTF.text!)
        dict["duration"]?.append(durationTF.text!)
        dict["steps"]?.append(stepTF.text!)
        dict["distance"]?.append(distanceTF.text!)
        }
        
        let url = URL(fileURLWithPath: path!)
        //  запись
        do {
            print("as")
            let data = try PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)
            try data.write(to: url, options: .atomicWrite)
        } catch {
            print(error)
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dict["date"] = [String]()
        dict["type"] = [String]()
        dict["duration"] = [String]()
        dict["steps"] = [String]()
        dict["distance"] = [String]()
        df.dateFormat = "MM-dd-yyyy"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true) as NSArray
        let documentDirectory = paths[0] as? String
        let path = documentDirectory?.appending("TrainingData")
        if let data = NSData(contentsOfFile: path!) {
            do {
                dict = try PropertyListSerialization.propertyList(from: data as Data, options: .mutableContainersAndLeaves, format: nil) as! [String : [String]]
            } catch {
                print(error)
            }
        }
        print("Загружено \(dict)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Статистика
    
    @IBOutlet weak var selectedTypeTB: UITextField!
    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var time: UILabel!
    var currentDate = Date()
    func renewAverages(){
        let endDate = currentDate
        let beginDate = endDate.addingTimeInterval(-7*3600*24)
        var averageSteps=0.0,averageDictance=0.0,averageTime=0.0
        for index in 0..<dict["date"]!.count{
            let date = df.date(from: dict["date"]![index])!
            if(date>beginDate && date<endDate && dict["type"]![index]==selectedTypeTB.text){
                averageSteps+=Double(dict["steps"]![index])!
                averageDictance+=Double(dict["distance"]![index])!
                averageTime+=Double(dict["duration"]![index])!
            }
            steps.text = String(format: "%.2f ", averageSteps/7)
            distance.text = String(format: "%.2f  км", averageDictance/7)
            time.text = String(format: "%.2f  с", averageTime/7)
        }
        
        weekLabel.text = "\(df.string(from: beginDate)) - \(df.string(from: endDate))"
    }
    @IBAction func showStatClick(_ sender: Any) {
        renewAverages()
    }
    
    @IBAction func nextWeekClick(_ sender: Any) {
        let d = currentDate.addingTimeInterval(7*3600*24)
        if d<Date(){
        currentDate = d
            }
        renewAverages()
    }
    @IBAction func prevWeekClick(_ sender: Any) {
        currentDate = currentDate.addingTimeInterval(-7*3600*24)
        renewAverages()
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var statView: UIView!
    @IBAction func segmentedConrolChange(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex==0{
            statView.isHidden=true
        }
        else{
            statView.isHidden=false
        }
    }
    @IBOutlet weak var weekLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
