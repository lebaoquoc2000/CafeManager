//
//  DangNhapVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/4/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class DangNhapVC: UIViewController {
    
    let dangNhapLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "ĐĂNG NHẬP"
        l.font = UIFont.boldSystemFont(ofSize: 24)
        l.textAlignment = .center
        l.textColor = .orange
        return l
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "user-login")
        return iv
    }()
    
    let tenDangNhapTF: UITextField = {
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
    
    lazy var dangNhapBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Đăng nhập", for: .normal)
        b.tintColor = .white
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.backgroundColor = .blue
        b.layer.cornerRadius = 3
        b.addTarget(self, action: #selector(dangNhapBTClicked), for: .touchUpInside)
        return b
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
        setupNavigation()
        configureUI()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc private func dangKyBTClicked() {
        let dangKyVC = DangKyVC()
        self.navigationController?.pushViewController(dangKyVC, animated: true)
    }
    
    @objc private func dangNhapBTClicked() {
        if tenDangNhapTF.text!.isEmpty || matKhauTF.text!.isEmpty {
            Util.alert1Action(title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin", view: self, isDismiss: false, isPopViewController: false)
        } else {
            let user = DatabaseModel.getInstance().dangNhap(tendn: tenDangNhapTF.text!, matkhau: matKhauTF.text!)
            if user.tendangnhap != nil {
                let mhc = ManHinhChinhVC()
                mhc.idNguoiDung = user.id
                mhc.tennguoidungLB.text = "Tên người dùng: \(user.tennguoidung!)"
                mhc.tendangnhapLB.text = "Tên đăng nhập: \(user.tendangnhap!)"
                let navigation = UINavigationController(rootViewController: mhc)
                DispatchQueue.main.async {
                    self.navigationController?.present(navigation, animated: true, completion: {
                        self.tenDangNhapTF.text = ""
                        self.matKhauTF.text = ""
                    })
                }
            } else {
                Util.alert1Action(title: "Lỗi", message: "Thông tin đăng nhập không đúng.", view: self, isDismiss: false, isPopViewController: false)
            }
        }
    }
    
    private func configureUI() {
        view.addSubview(imageView)
        view.addSubview(dangNhapLB)
        view.addSubview(tenDangNhapTF)
        view.addSubview(matKhauTF)
        view.addSubview(dangNhapBT)
        view.addSubview(dangKyBT)
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            dangNhapLB.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -16),
            dangNhapLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            dangNhapLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            tenDangNhapTF.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            tenDangNhapTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tenDangNhapTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tenDangNhapTF.heightAnchor.constraint(equalToConstant: 45),
            
            matKhauTF.topAnchor.constraint(equalTo: tenDangNhapTF.bottomAnchor, constant: 8),
            matKhauTF.leftAnchor.constraint(equalTo: tenDangNhapTF.leftAnchor),
            matKhauTF.rightAnchor.constraint(equalTo: tenDangNhapTF.rightAnchor),
            matKhauTF.heightAnchor.constraint(equalToConstant: 45),
            
            dangNhapBT.topAnchor.constraint(equalTo: matKhauTF.bottomAnchor, constant: 16),
            dangNhapBT.leftAnchor.constraint(equalTo: tenDangNhapTF.leftAnchor),
            dangNhapBT.rightAnchor.constraint(equalTo: tenDangNhapTF.rightAnchor),
            dangNhapBT.heightAnchor.constraint(equalToConstant: 50),
            
            dangKyBT.topAnchor.constraint(equalTo: dangNhapBT.bottomAnchor, constant: 8),
            dangKyBT.leftAnchor.constraint(equalTo: dangNhapBT.leftAnchor),
            dangKyBT.rightAnchor.constraint(equalTo: dangNhapBT.rightAnchor),
            dangKyBT.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tenDangNhapTF.resignFirstResponder()
        matKhauTF.resignFirstResponder()
    }
    
}
