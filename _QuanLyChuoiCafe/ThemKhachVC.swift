//
//  ThemKhachVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/8/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class ThemKhachVC: UIViewController {
    
    var idNguoiDung: Int?
    
    let hotenTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập họ tên"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    let sdtTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập số điện thoại"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    let diachiTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập địa chỉ"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    let ngaydatphongTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Chọn ngày đặt phòng"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.tintColor = .clear
        return tf
    }()
    
    lazy var themBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("THÊM", for: .normal)
        b.tintColor = .white
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.backgroundColor = .blue
        b.layer.cornerRadius = 3
        b.addTarget(self, action: #selector(them), for: .touchUpInside)
        return b
    }()
    
    var datePicker :UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        configureUI()
        
        // Tạo uidatepickerView add vào 2 textfield khi clicked vào
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "vi")
        datePicker.addTarget(self, action: #selector(dateChanged), for: .allEvents)
        
        ngaydatphongTF.inputView = datePicker
        
        // Tạo 1 toolbar chứa button done để ẩn uipickerView
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        
        ngaydatphongTF.inputAccessoryView = toolBar
        
    }
    
    @objc private func datePickerDone() {
        ngaydatphongTF.resignFirstResponder()
        dateChanged()
    }
    
    @objc private func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        ngaydatphongTF.text = dateFormatter.string(from: datePicker.date)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "THÊM KHÁCH Ở TRỌ"
    }
    
    @objc private func them() {
        if hotenTF.text!.isEmpty || sdtTF.text!.isEmpty || diachiTF.text!.isEmpty || ngaydatphongTF.text!.isEmpty {
            
        } else {
            let khach = KhachModel()
            khach.hoten = hotenTF.text!
            khach.sdt = sdtTF.text!
            khach.diachi = diachiTF.text!
            khach.id_nguoitao = idNguoiDung!
            
            let isInserted = DatabaseModel.getInstance().themKhach(khach)
            
            if isInserted {
                Util.alert1Action(title: "Thành công", message: "Đã thêm khách ở trọ", view: self, isDismiss: false, isPopViewController: true)
            }
        }
    }
    
    fileprivate func configureUI() {
        view.addSubview(hotenTF)
        view.addSubview(sdtTF)
        view.addSubview(diachiTF)
        view.addSubview(ngaydatphongTF)
        view.addSubview(themBT)
        
        let constraints = [
            hotenTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            hotenTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            hotenTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            hotenTF.heightAnchor.constraint(equalToConstant: 45),
            
            sdtTF.topAnchor.constraint(equalTo: hotenTF.bottomAnchor, constant: 16),
            sdtTF.leftAnchor.constraint(equalTo: hotenTF.leftAnchor),
            sdtTF.rightAnchor.constraint(equalTo: hotenTF.rightAnchor),
            sdtTF.heightAnchor.constraint(equalToConstant: 45),
            
            diachiTF.topAnchor.constraint(equalTo: sdtTF.bottomAnchor, constant: 16),
            diachiTF.leftAnchor.constraint(equalTo: sdtTF.leftAnchor),
            diachiTF.rightAnchor.constraint(equalTo: sdtTF.rightAnchor),
            diachiTF.heightAnchor.constraint(equalToConstant: 45),
            
            ngaydatphongTF.topAnchor.constraint(equalTo: diachiTF.bottomAnchor, constant: 16),
            ngaydatphongTF.leftAnchor.constraint(equalTo: diachiTF.leftAnchor),
            ngaydatphongTF.rightAnchor.constraint(equalTo: diachiTF.rightAnchor),
            ngaydatphongTF.heightAnchor.constraint(equalToConstant: 45),
            
            themBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            themBT.topAnchor.constraint(equalTo: ngaydatphongTF.bottomAnchor, constant: 36),
            themBT.widthAnchor.constraint(equalToConstant: 200),
            themBT.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
