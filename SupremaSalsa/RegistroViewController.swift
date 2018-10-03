//
//  RegistroViewController.swift
//  SupremaSalsa
//
//  Created by miguel mexicano on 02/10/18.
//  Copyright © 2018 miguel mexicano. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController,UITextFieldDelegate {
    var data : dataFacebook?
    let datePicker = UIDatePicker()

    @IBOutlet weak var nombreTxt: UITextField!
    @IBOutlet weak var apellidosTxt: UITextField!
    @IBOutlet weak var correoTxt: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var direccionTxt: UITextField!
    @IBOutlet weak var CPTxt: UITextField!
    @IBOutlet weak var cumpleañosTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ic_fondo.png")!)
        self.LlenarFormulario()
        self.showDatePicker()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.hideKeyboard()
        
    }
    
    
    
    func hideKeyboard(){
       self.nombreTxt.delegate = self
       self.apellidosTxt.delegate = self
       self.correoTxt.delegate = self
       self.telefono.delegate = self
       self.direccionTxt.delegate = self
       self.CPTxt.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func LlenarFormulario(){
        nombreTxt.text = data?.firstName!
        apellidosTxt.text = data?.lastname!
        correoTxt.text = data?.email!
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        cumpleañosTxt.inputAccessoryView = toolbar
        cumpleañosTxt.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        cumpleañosTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    
    

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
