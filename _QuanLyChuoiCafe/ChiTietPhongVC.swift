//
//  ChiTietPhongVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/5/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class ChiTietPhongVC: UIViewController {
    
    var name: String!
    var idPhong: Int!
    var idKhach: Int!
    
    let tenphongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 28)
        l.textColor = .orange
        return l
    }()
    
    let ngaydatLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let tienphongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let songuoiLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let ngaythanhtoanLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    lazy var thanhtoanBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("ĐÃ THANH TOÁN", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        b.backgroundColor = .blue
        b.layer.cornerRadius = 3
        b.addTarget(self, action: #selector(thanhToan), for: .touchUpInside)
        return b
    }()
    
    lazy var traphongBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("TRẢ PHÒNG", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        b.backgroundColor = .green
        b.layer.cornerRadius = 3
        b.addTarget(self, action: #selector(traPhong), for: .touchUpInside)
        return b
    }()
    
    lazy var dangnoBT: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("ĐANG NỢ", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        b.backgroundColor = .red
        b.layer.cornerRadius = 3
        b.addTarget(self, action: #selector(dangNo), for: .touchUpInside)
        return b
    }()
    
    let loaiphongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let nguoidatLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let sdtLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    let diachiLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        configureUI()
        layThongTinPhong()
        layThongTinKhach()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // reload data
        layThongTinPhong()
        layThongTinKhach()
    }
    
    @objc private func thanhToan() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        
        let isUpdated = DatabaseModel.getInstance().thayDoiTrangThaiPhong(trangThai: 1, idPhong: idPhong!, ngayThanhToan: result)
        
        if isUpdated {
            Util.alert1Action(title: "Đã thanh toán", message: "", view: self, isDismiss: false, isPopViewController: false)
            layThongTinPhong()
        }
        
    }
    
    @objc private func traPhong() {
        let isUpdated = DatabaseModel.getInstance().thayDoiTrangThaiPhong(trangThai: 0, idPhong: idPhong!, ngayThanhToan: "")
        
        if isUpdated {
            
            let isDeleted = DatabaseModel.getInstance().xoaKhach(idKhach: idKhach!)

            if isDeleted {
                Util.alert1Action(title: "Đã trả phòng", message: "", view: self, isDismiss: false, isPopViewController: true)
            }
        }
    }
    
    @objc private func dangNo() {
        let isUpdated = DatabaseModel.getInstance().thayDoiTrangThaiPhong(trangThai: 2, idPhong: idPhong!, ngayThanhToan: "")
        
        if isUpdated {
            Util.alert1Action(title: "Đã xác nhận đang nợ", message: "", view: self, isDismiss: false, isPopViewController: false)
        }
    }
    
    private func layThongTinPhong() {
        let phong = DatabaseModel.getInstance().layThongTinPhong(idPhong: idPhong!)
        tenphongLB.text = phong.tenphong!
        ngaydatLB.text = "Ngày đặt: \(phong.ngaydat!)"
        let tien = phong.tienphong!
        let forrmatter = NumberFormatter()
        forrmatter.groupingSeparator = "."
        forrmatter.numberStyle = .decimal
        let formattedTien = forrmatter.string(from: NSNumber(value: tien))
        tienphongLB.text = "Tiền phòng: \(formattedTien ?? "0") VNĐ"
        songuoiLB.text = "Số người: \(phong.songuoi!)"
        ngaythanhtoanLB.text = "Ngày thanh toán gần nhất: \(phong.ngaythanhtoan!)"
        
        let loaiPhong = phong.loaiphong!
        
        if loaiPhong == 1 {
            loaiphongLB.text = "Loại phòng: phòng vip"
        } else {
            loaiphongLB.text = "Loại phòng: phòng thường"
        }
        
    }
    
    private func layThongTinKhach() {
        let khach = DatabaseModel.getInstance().layThongTinKhach(idPhong: idPhong!)
        nguoidatLB.text = "Người đặt: \(khach.hoten!)"
        sdtLB.text = "Người đặt: \(khach.sdt!)"
        diachiLB.text = "Người đặt: \(khach.diachi!)"
        self.idKhach = khach.id!
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "CHI TIẾT PHÒNG"
        let item = UIBarButtonItem(title: "Sửa", style: .plain, target: self, action: #selector(sua))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc private func sua() {
        let suaVC = SuaThongTinPhongVC()
        suaVC.type = 1
        suaVC.idPhong = idPhong
        let navigation = UINavigationController(rootViewController: suaVC)
        DispatchQueue.main.async {
            self.present(navigation, animated: true, completion: nil)
        }
    }
    
    private func configureUI() {
        view.addSubview(loaiphongLB)
        view.addSubview(nguoidatLB)
        view.addSubview(sdtLB)
        view.addSubview(diachiLB)
        view.addSubview(tenphongLB)
        view.addSubview(ngaydatLB)
        view.addSubview(tienphongLB)
        view.addSubview(songuoiLB)
        view.addSubview(ngaythanhtoanLB)
        view.addSubview(thanhtoanBT)
        view.addSubview(traphongBT)
        view.addSubview(dangnoBT)
        let constraints = [
            tenphongLB.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tenphongLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tenphongLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            loaiphongLB.topAnchor.constraint(equalTo: tenphongLB.bottomAnchor, constant: 24),
            loaiphongLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            loaiphongLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            nguoidatLB.topAnchor.constraint(equalTo: loaiphongLB.bottomAnchor, constant: 24),
            nguoidatLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nguoidatLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            sdtLB.topAnchor.constraint(equalTo: nguoidatLB.bottomAnchor, constant: 24),
            sdtLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            sdtLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            diachiLB.topAnchor.constraint(equalTo: sdtLB.bottomAnchor, constant: 24),
            diachiLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            diachiLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            ngaydatLB.topAnchor.constraint(equalTo: diachiLB.bottomAnchor, constant: 24),
            ngaydatLB.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ngaydatLB.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            tienphongLB.topAnchor.constraint(equalTo: ngaydatLB.bottomAnchor, constant: 24),
            tienphongLB.leftAnchor.constraint(equalTo: ngaydatLB.leftAnchor),
            tienphongLB.rightAnchor.constraint(equalTo: ngaydatLB.rightAnchor),
            
            songuoiLB.topAnchor.constraint(equalTo: tienphongLB.bottomAnchor, constant: 24),
            songuoiLB.leftAnchor.constraint(equalTo: tienphongLB.leftAnchor),
            songuoiLB.rightAnchor.constraint(equalTo: tienphongLB.rightAnchor),
            
            ngaythanhtoanLB.topAnchor.constraint(equalTo: songuoiLB.bottomAnchor, constant: 24),
            ngaythanhtoanLB.leftAnchor.constraint(equalTo: songuoiLB.leftAnchor),
            ngaythanhtoanLB.rightAnchor.constraint(equalTo: songuoiLB.rightAnchor),
            
            thanhtoanBT.topAnchor.constraint(equalTo: ngaythanhtoanLB.bottomAnchor, constant: 44),
            thanhtoanBT.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            thanhtoanBT.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 2, constant: -32),
            thanhtoanBT.heightAnchor.constraint(equalToConstant: 45),
            
            traphongBT.topAnchor.constraint(equalTo: thanhtoanBT.topAnchor),
            traphongBT.leftAnchor.constraint(equalTo: thanhtoanBT.rightAnchor, constant: 16),
            traphongBT.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            traphongBT.heightAnchor.constraint(equalToConstant: 45),
            
            dangnoBT.topAnchor.constraint(equalTo: thanhtoanBT.bottomAnchor, constant: 16),
            dangnoBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dangnoBT.widthAnchor.constraint(equalTo: thanhtoanBT.widthAnchor),
            dangnoBT.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
