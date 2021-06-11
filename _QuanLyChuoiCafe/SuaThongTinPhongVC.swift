//
//  SuaThongTinPhongVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/6/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class SuaThongTinPhongVC: UIViewController {
    
    var type: Int!
    var idPhong: Int!
    var loaiphong: Int!
    var idNguoiDung: Int!
    
    let tenphongTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.textColor = .orange
        tf.font = UIFont.boldSystemFont(ofSize: 28)
        return tf
    }()
    
    let nguoidatLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Họ tên người đặt:"
        return l
    }()
    
    let sdtLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Số điện thoại:"
        return l
    }()
    
    let sdtTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Nhập số điện thoại"
        return tf
    }()
    
    let diachiLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Địa chỉ:"
        return l
    }()
    
    let diachiTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Nhập địa chỉ"
        return tf
    }()
    
    let ngaydatLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Ngày đặt:"
        return l
    }()
    
    let tienphongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Tiền phòng:"
        return l
    }()
    
    let songuoiLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Số người:"
        return l
    }()
    
    let ngaythanhtoanLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        l.text = "Ngày thanh toán:"
        return l
    }()
    
    let nguoidatTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Nhập họ tên người đặt"
        return tf
    }()
    
    lazy var ngaydatTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Chọn ngày đặt phòng"
        tf.delegate = self
        tf.tintColor = .clear
        return tf
    }()
    
    let tienphongTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Nhập tiền phòng"
        tf.keyboardType = UIKeyboardType.numberPad
        return tf
    }()
    
    let songuoiTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Nhập số người ở"
        tf.keyboardType = UIKeyboardType.numberPad
        return tf
    }()
    
    lazy var ngaythanhtoanTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Chọn ngày thanh toán"
        tf.delegate = self
        return tf
    }()
    
    lazy var luuBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        b.backgroundColor = .blue
        b.layer.cornerRadius = 3
        return b
    }()
    
    let loaiphongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let switchButton: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var datePicker :UIDatePicker!
    var tag: Int = 0
    
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
        
        ngaydatTF.inputView = datePicker
        ngaythanhtoanTF.inputView = datePicker
        
        // Tạo 1 toolbar chứa button done để ẩn uipickerView
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        
        ngaydatTF.inputAccessoryView = toolBar
        ngaythanhtoanTF.inputAccessoryView = toolBar
        
        // Nếu type = 0 (Phòng đang trống) thì là đặt phòng
        if type == 0 {
            navigationItem.title = "ĐẶT PHÒNG"
            luuBT.setTitle("ĐẶT PHÒNG", for: .normal)
            luuBT.addTarget(self, action: #selector(datPhong), for: .touchUpInside)
            tenphongTF.isUserInteractionEnabled = false
            switchButton.isHidden = true
            if loaiphong == 1 {
                loaiphongLB.text = "Loại phòng: phòng vip"
            } else {
                loaiphongLB.text = "Loại phòng: phòng thường"
            }
            
        }
        
        // Nếu type = 1 (Phòng đang có người ở) thì là sửa thông tin phòng
        if type == 1 {
            layThongTinPhong()
            layThongTinKhach()
            navigationItem.title = "SỬA THÔNG TIN PHÒNG"
            luuBT.setTitle("LƯU", for: .normal)
            luuBT.addTarget(self, action: #selector(suaThongTinPhong), for: .touchUpInside)
            let item = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(huy))
            item.tintColor = .white
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    private func layThongTinPhong() {
        let phong = DatabaseModel.getInstance().layThongTinPhong(idPhong: idPhong!)
        tenphongTF.text = phong.tenphong!
        ngaydatTF.text = phong.ngaydat!
        tienphongTF.text = "\(phong.tienphong!)"
        songuoiTF.text = "\(phong.songuoi!)"
        ngaythanhtoanTF.text = phong.ngaythanhtoan!
        loaiphongLB.text = "Phòng vip:"
        let loaiPhong = phong.loaiphong!
        if loaiPhong == 1 {
            switchButton.isOn = true
        } else {
            switchButton.isOn = false
        }
    }
    
    private func layThongTinKhach() {
        let khach = DatabaseModel.getInstance().layThongTinKhach(idPhong: idPhong!)
        nguoidatTF.text = khach.hoten
        sdtTF.text = khach.sdt
        diachiTF.text = khach.diachi
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc private func datPhong() {
        if ngaydatTF.text!.isEmpty || tienphongTF.text!.isEmpty || songuoiTF.text!.isEmpty || ngaythanhtoanTF.text!.isEmpty || nguoidatTF.text!.isEmpty || sdtTF.text!.isEmpty || diachiTF.text!.isEmpty {
            Util.alert1Action(title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin", view: self, isDismiss: false, isPopViewController: false)
        }
        else {
            let isUpdated = DatabaseModel.getInstance().datPhong(idPhong: idPhong!, tenPhong: tenphongTF.text!, ngayDat: ngaydatTF.text!, tienPhong: Int(tienphongTF.text!) ?? 0, soNguoi: Int(songuoiTF.text!) ?? 0, ngayThanhToan: ngaythanhtoanTF.text!, trangThai: 1)
            
            if isUpdated {
                let khach = KhachModel()
                khach.hoten = nguoidatTF.text!
                khach.sdt = sdtTF.text!
                khach.diachi = diachiTF.text!
                khach.id_nguoitao = idNguoiDung!
                khach.id_phong = idPhong!
                
                let isInserted = DatabaseModel.getInstance().themKhach(khach)
                
                if isInserted {
                    Util.alert1Action(title: "Thành công", message: "Đặt phòng thành công", view: self, isDismiss: false, isPopViewController: true)
                }
            }
        }
    }
    
    @objc private func suaThongTinPhong() {
        let loaiPhong: Int
        if switchButton.isOn {
            loaiPhong = 1
        } else {
            loaiPhong = 0
        }
        let suaPhong = DatabaseModel.getInstance().suaThongTinPhong(tenPhong: tenphongTF.text!, ngayDat: ngaydatTF.text!, tienPhong: Int(tienphongTF.text!)!, soNguoi: Int(songuoiTF.text!)!, ngayThanhToan: ngaythanhtoanTF.text!, loaiPhong: loaiPhong, idPhong: idPhong!)
        
        if suaPhong {
            let suaKhach = DatabaseModel.getInstance().suaThongTinKhach(tenKhach: nguoidatTF.text!, sdt: sdtTF.text!, diaChi: diachiTF.text!, idPhong: idPhong)
            
            if suaKhach {
                Util.alert1Action(title: "Thành công", message: "Sửa thông tin phòng thành công", view: self, isDismiss: true, isPopViewController: false)
            }
        }
    }
    
    @objc private func huy() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func datePickerDone() {
        if tag == 1 {
            ngaydatTF.resignFirstResponder()
            dateChanged()
        }
        
        if tag == 2 {
            ngaythanhtoanTF.resignFirstResponder()
            dateChanged()
        }
    }
    
    @objc private func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if tag == 1 {
            ngaydatTF.text = dateFormatter.string(from: datePicker.date)
        }
        
        if tag == 2 {
            ngaythanhtoanTF.text = dateFormatter.string(from: datePicker.date)
        }
    }
    
    private func configureUI() {
        view.addSubview(nguoidatLB)
        view.addSubview(nguoidatTF)
        view.addSubview(loaiphongLB)
        view.addSubview(sdtLB)
        view.addSubview(sdtTF)
        view.addSubview(diachiLB)
        view.addSubview(diachiTF)
        view.addSubview(switchButton)
        view.addSubview(tenphongTF)
        view.addSubview(ngaydatLB)
        view.addSubview(tienphongLB)
        view.addSubview(songuoiLB)
        view.addSubview(ngaythanhtoanLB)
        view.addSubview(ngaydatTF)
        view.addSubview(tienphongTF)
        view.addSubview(songuoiTF)
        view.addSubview(ngaythanhtoanTF)
        view.addSubview(luuBT)
        let constraints = [
            tenphongTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tenphongTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tenphongTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tenphongTF.heightAnchor.constraint(equalToConstant: 45),
            
            loaiphongLB.topAnchor.constraint(equalTo: tenphongTF.bottomAnchor, constant: 24),
            loaiphongLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            switchButton.centerYAnchor.constraint(equalTo: loaiphongLB.centerYAnchor),
            switchButton.leftAnchor.constraint(equalTo: loaiphongLB.rightAnchor, constant: 16),
            
            nguoidatLB.topAnchor.constraint(equalTo: loaiphongLB.bottomAnchor, constant: 24),
            nguoidatLB.leftAnchor.constraint(equalTo: loaiphongLB.leftAnchor),
            nguoidatLB.widthAnchor.constraint(equalToConstant: 80),
            
            nguoidatTF.centerYAnchor.constraint(equalTo: nguoidatLB.centerYAnchor),
            nguoidatTF.leftAnchor.constraint(equalTo: nguoidatLB.rightAnchor, constant: 16),
            nguoidatTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nguoidatTF.heightAnchor.constraint(equalToConstant: 45),
            
            sdtLB.topAnchor.constraint(equalTo: nguoidatLB.bottomAnchor, constant: 24),
            sdtLB.leftAnchor.constraint(equalTo: nguoidatLB.leftAnchor),
            sdtLB.widthAnchor.constraint(equalToConstant: 100),
            
            sdtTF.centerYAnchor.constraint(equalTo: sdtLB.centerYAnchor),
            sdtTF.leftAnchor.constraint(equalTo: sdtLB.rightAnchor, constant: 16),
            sdtTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            sdtTF.heightAnchor.constraint(equalToConstant: 45),
            
            diachiLB.topAnchor.constraint(equalTo: sdtLB.bottomAnchor, constant: 24),
            diachiLB.leftAnchor.constraint(equalTo: sdtLB.leftAnchor),
            diachiLB.widthAnchor.constraint(equalToConstant: 60),
            
            diachiTF.centerYAnchor.constraint(equalTo: diachiLB.centerYAnchor),
            diachiTF.leftAnchor.constraint(equalTo: diachiLB.rightAnchor, constant: 16),
            diachiTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            diachiTF.heightAnchor.constraint(equalToConstant: 45),
            
            ngaydatLB.topAnchor.constraint(equalTo: diachiLB.bottomAnchor, constant: 24),
            ngaydatLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ngaydatLB.widthAnchor.constraint(equalToConstant: 70),
            
            ngaydatTF.centerYAnchor.constraint(equalTo: ngaydatLB.centerYAnchor),
            ngaydatTF.leftAnchor.constraint(equalTo: ngaydatLB.rightAnchor, constant: 16),
            ngaydatTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            ngaydatTF.heightAnchor.constraint(equalToConstant: 45),
            
            tienphongLB.topAnchor.constraint(equalTo: ngaydatLB.bottomAnchor, constant: 24),
            tienphongLB.leftAnchor.constraint(equalTo: ngaydatLB.leftAnchor),
            tienphongLB.widthAnchor.constraint(equalToConstant: 90),
            
            songuoiLB.topAnchor.constraint(equalTo: tienphongLB.bottomAnchor, constant: 24),
            songuoiLB.leftAnchor.constraint(equalTo: tienphongLB.leftAnchor),
            songuoiLB.widthAnchor.constraint(equalToConstant: 70),
            
            ngaythanhtoanLB.topAnchor.constraint(equalTo: songuoiLB.bottomAnchor, constant: 24),
            ngaythanhtoanLB.leftAnchor.constraint(equalTo: songuoiLB.leftAnchor),
            ngaythanhtoanLB.widthAnchor.constraint(equalToConstant: 130),
            
            ngaydatTF.centerYAnchor.constraint(equalTo: ngaydatLB.centerYAnchor),
            ngaydatTF.leftAnchor.constraint(equalTo: ngaydatLB.rightAnchor, constant: 16),
            ngaydatTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            ngaydatTF.heightAnchor.constraint(equalToConstant: 45),
            
            tienphongTF.centerYAnchor.constraint(equalTo: tienphongLB.centerYAnchor),
            tienphongTF.leftAnchor.constraint(equalTo: tienphongLB.rightAnchor, constant: 16),
            tienphongTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tienphongTF.heightAnchor.constraint(equalToConstant: 45),
            
            songuoiTF.centerYAnchor.constraint(equalTo: songuoiLB.centerYAnchor),
            songuoiTF.leftAnchor.constraint(equalTo: songuoiLB.rightAnchor, constant: 16),
            songuoiTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            songuoiTF.heightAnchor.constraint(equalToConstant: 45),
            
            ngaythanhtoanTF.centerYAnchor.constraint(equalTo: ngaythanhtoanLB.centerYAnchor),
            ngaythanhtoanTF.leftAnchor.constraint(equalTo: ngaythanhtoanLB.rightAnchor, constant: 16),
            ngaythanhtoanTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            ngaythanhtoanTF.heightAnchor.constraint(equalToConstant: 45),
            
            luuBT.topAnchor.constraint(equalTo: ngaythanhtoanLB.bottomAnchor, constant: 44),
            luuBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            luuBT.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            luuBT.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension SuaThongTinPhongVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == ngaydatTF {
            tag = 1
        }
        
        if textField == ngaythanhtoanTF {
            tag = 2
        }
        
    }
}
