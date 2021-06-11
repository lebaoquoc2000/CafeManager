//
//  ManHinhChinhVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/6/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class ManHinhChinhVC: UIViewController {
    
    private let cellId = "cellId"
    var idNguoiDung: Int!
    
    let thongtinV: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize.zero
        v.layer.shadowRadius = 5
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = false
        return v
    }()
    
    let tennguoidungLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    
    let tendangnhapLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    
    let sophongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    
    let phongvipLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    
    let phongthuongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15)
        return l
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        configureUI()
        toanBoPhong()
        soPhongThuong()
        soPhongVip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "QUẢN LÝ CHUỖI CAFE"
        toanBoPhong()
        soPhongThuong()
        soPhongVip()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "QUẢN LÝ CHUỖI CAFE"
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "logout").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(dangXuat), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = item
    }
    
    private func toanBoPhong() {
        let sophong = 1
        sophongLB.text = "Số Quán: \(sophong)"
    }
    
    private func soPhongThuong() {
        let sophong = 1
        phongthuongLB.text = "Vị Trí Thường : \(sophong)"
    }
    
    private func soPhongVip() {
        let sophong = 1
        phongvipLB.text = "Vị Trí Đặc Biệt: \(sophong)"
    }
    
    @objc private func dangXuat() {
        let alert = UIAlertController(title: nil, message: "Bạn có chắc muốn đăng xuất?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { (action) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Không", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func viewTapped() {

    }
    
    // addSubview and Autolayout
    private func configureUI() {
        view.addSubview(thongtinV)
        thongtinV.addSubview(tennguoidungLB)
        thongtinV.addSubview(tendangnhapLB)
        thongtinV.addSubview(sophongLB)
        thongtinV.addSubview(phongvipLB)
        thongtinV.addSubview(phongthuongLB)
        
        view.addSubview(collectionView)
        collectionView.register(QuanLyCell.self, forCellWithReuseIdentifier: cellId)
        
        let constraints = [
            thongtinV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            thongtinV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            thongtinV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            thongtinV.heightAnchor.constraint(equalToConstant: 170),
            
            tennguoidungLB.topAnchor.constraint(equalTo: thongtinV.topAnchor, constant: 16),
            tennguoidungLB.leftAnchor.constraint(equalTo: thongtinV.leftAnchor, constant: 16),
            
            tendangnhapLB.topAnchor.constraint(equalTo: tennguoidungLB.bottomAnchor, constant: 12),
            tendangnhapLB.leftAnchor.constraint(equalTo: tennguoidungLB.leftAnchor),
            
            sophongLB.topAnchor.constraint(equalTo: tendangnhapLB.bottomAnchor, constant: 12),
            sophongLB.leftAnchor.constraint(equalTo: tendangnhapLB.leftAnchor),
            
            phongvipLB.topAnchor.constraint(equalTo: sophongLB.bottomAnchor, constant: 12),
            phongvipLB.leftAnchor.constraint(equalTo: sophongLB.leftAnchor),
            
            phongthuongLB.topAnchor.constraint(equalTo: phongvipLB.bottomAnchor, constant: 12),
            phongthuongLB.leftAnchor.constraint(equalTo: phongvipLB.leftAnchor),
            
            collectionView.topAnchor.constraint(equalTo: thongtinV.bottomAnchor, constant: 40),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension ManHinhChinhVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! QuanLyCell
        if indexPath.item == 0 {
            cell.imageView.image = #imageLiteral(resourceName: "room").withRenderingMode(.alwaysTemplate)
            cell.quanlyphongLB.text = "Danh Sách Cửa Hàng CaFe"
        }
        if indexPath.item == 1 {
            cell.imageView.image = #imageLiteral(resourceName: "guest").withRenderingMode(.alwaysTemplate)
            cell.quanlyphongLB.text = "Danh Sách Quản Lý"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 28
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

class QuanLyCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .orange
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let quanlyphongLB: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .orange
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(quanlyphongLB)

        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            quanlyphongLB.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            quanlyphongLB.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            quanlyphongLB.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
