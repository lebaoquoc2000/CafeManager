//
//  DangKyVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/4/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class DangKyVC: UIViewController {
    
    let dangkyLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "ĐĂNG KÝ"
        l.textColor = .orange
        l.font = UIFont.boldSystemFont(ofSize: 24)
        l.textAlignment = .center
        return l
    }()
    
    let tennguoidungTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Họ tên"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    let tendangnhapTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Tên đăng nhập"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    let matKhauTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Mật khẩu"
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var dangKyBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Đăng ký", for: .normal)
        b.tintColor = .white
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.backgroundColor = .purple
        b.layer.cornerRadius = 3
        b.addTarget(self, action: #selector(dangKyBTClicked), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        configureUI()
    }
    
    @objc private func dangKyBTClicked() {
        if tennguoidungTF.text!.isEmpty || tendangnhapTF.text!.isEmpty || matKhauTF.text!.isEmpty {
            Util.alert1Action(title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin!", view: self, isDismiss: false, isPopViewController: false)
        } else {
            let taikhoan = TaiKhoanModel()
            taikhoan.tennguoidung = tennguoidungTF.text
            taikhoan.tendangnhap = tendangnhapTF.text
            taikhoan.matkhau = matKhauTF.text
            
            let isInserted = DatabaseModel.getInstance().dangKyTaiKhoan(taikhoan)
            if isInserted {
                Util.alert1Action(title: "Thành công", message: "Tạo tài khoản thành công.", view: self, isDismiss: false, isPopViewController: true)
            } else {
                Util.alert1Action(title: "Lỗi", message: "Thất bại. Vui lòng thử lại!", view: self, isDismiss: false, isPopViewController: false)
            }
        }
    }
    
    private func configureUI() {
        view.addSubview(dangkyLB)
        view.addSubview(tennguoidungTF)
        view.addSubview(tendangnhapTF)
        view.addSubview(matKhauTF)
        view.addSubview(dangKyBT)
        
        let constraints = [
            dangkyLB.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dangkyLB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tennguoidungTF.topAnchor.constraint(equalTo: dangkyLB.bottomAnchor, constant: 36),
            tennguoidungTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tennguoidungTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tennguoidungTF.heightAnchor.constraint(equalToConstant: 45),
            
            tendangnhapTF.topAnchor.constraint(equalTo: tennguoidungTF.bottomAnchor, constant: 16),
            tendangnhapTF.leftAnchor.constraint(equalTo: tennguoidungTF.leftAnchor),
            tendangnhapTF.rightAnchor.constraint(equalTo: tennguoidungTF.rightAnchor),
            tendangnhapTF.heightAnchor.constraint(equalToConstant: 45),
            
            matKhauTF.topAnchor.constraint(equalTo: tendangnhapTF.bottomAnchor, constant: 16),
            matKhauTF.leftAnchor.constraint(equalTo: tendangnhapTF.leftAnchor),
            matKhauTF.rightAnchor.constraint(equalTo: tendangnhapTF.rightAnchor),
            matKhauTF.heightAnchor.constraint(equalToConstant: 45),
            
            dangKyBT.topAnchor.constraint(equalTo: matKhauTF.bottomAnchor, constant: 32),
            dangKyBT.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            dangKyBT.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            dangKyBT.heightAnchor.constraint(equalToConstant: 45),
            
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
