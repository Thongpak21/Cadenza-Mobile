//
//  RegisterViewController.swift
//  Cadenza
//
//  Created by Thongpak on 5/11/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class RegisterViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pass_con: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var studentid: UITextField!
    @IBOutlet weak var academy: UITextField!
    var picker = UIPickerView()
    private var data_model = ["Open Course","Kasetsart University Sriracha","Kasetsart University Bngkhen"]
    override func viewDidLoad() {
        super.viewDidLoad()
    //    fetchdata()
        email.delegate = self
        pass_con.delegate = self
        password.delegate = self
        fname.delegate = self
        lname.delegate = self
        studentid.delegate = self
        academy.delegate = self
        picker.delegate = self
        picker.dataSource = self
        academy.inputView = picker
    }
    func register() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
        let data = ["email":email.text!,"password":password.text!,"password_confirmation":pass_con.text!,"firstname":fname.text!,"lastname":lname.text!,"studentid":studentid.text!,"CourseAcademyID":"1"]
        Alamofire.request(.POST , "http://cadenza.in.th/v2/oauth/register",parameters: data)
            .responseJSON{ response in
                print(response.result.value)
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if response.result.value! as! String == "Register Success"{
                    let alert = UIAlertController(title: "Success", message: "Register Success.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.dismissViewControllerAnimated(true, completion: {});
                }else{
                    let alert = UIAlertController(title: "Fail", message: "Register Fail.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                }
                
        }
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        //    textField.resignFirstResponder()
        if textField == self.email {
            self.password.becomeFirstResponder()
        }
        if textField == self.password {
            self.pass_con.becomeFirstResponder()
        }
        if textField == self.pass_con {
            self.fname.becomeFirstResponder()
        }
        if textField == self.fname {
            self.lname.becomeFirstResponder()
        }
        if textField == self.lname {
            self.studentid.becomeFirstResponder()
        }
        if textField == self.studentid {
            self.academy.becomeFirstResponder()
        }
        if textField == self.academy {
            textField.resignFirstResponder()
        }
        return true
    }

    @IBAction func confirm(sender: AnyObject) {
        register()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data_model.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data_model[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        academy.text = data_model[row]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
