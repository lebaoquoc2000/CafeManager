//
//  DanhSachPhongVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/5/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class DanhSachPhongVC: UITableViewController {
    
    private let cellId = "cellId"
    var idNguoiDung: Int!
    var roomModels: [PhongModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.tableView.tableFooterView = UIView()
        getAllData()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "DANH SÁCH CỬA HÀNG"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(them))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "DANH SÁCH CỬA HÀNG"
        getAllData()
    }
    
    private func getAllData() {
        roomModels = DatabaseModel.getInstance().getAllPhong(idNguoiTao: self.idNguoiDung!) as? [PhongModel]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func them() {
        let alertController = UIAlertController(title: "THÊM PHÒNG MỚI", message: nil, preferredStyle: .alert)
        
        let customView = CustomView()
        alertController.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50).isActive = true
        customView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 16).isActive = true
        customView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -16).isActive = true
        customView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -50).isActive = true
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        alertController.addAction(UIAlertAction(title: "THÊM", style: .default, handler: { (action) in
            
            if customView.textField.text!.isEmpty {

            } else {
                let phongModel = PhongModel()
                phongModel.tenphong = customView.textField.text!
                phongModel.trangthai = 0
                phongModel.songuoi = 0
                phongModel.ngaydat = "null"
                phongModel.tienphong = 0
                phongModel.ngaythanhtoan = "null"
                phongModel.id_nguoitao = self.idNguoiDung!
                
                if customView.switchButton.isOn {
                    phongModel.loaiphong = 1
                } else {
                    phongModel.loaiphong = 0
                }
                
                let isInserted = DatabaseModel.getInstance().themPhong(phongModel)
                if isInserted {
                    self.getAllData()
                } else {

                }
            }

        }))
        alertController.addAction(UIAlertAction(title: "HUỶ", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

class TableViewCell: UITableViewCell {
    var roomModel: PhongModel? {
        didSet {
            if let name = roomModel?.tenphong {
                nameLabel.text = name
            }
            if let status = roomModel?.trangthai {
                if status == 0 {
                    nameLabel.textColor = .lightGray
                    statusLabel.text = "Trạng thái: trống"
                    statusLabel.textColor = .lightGray
                    roomImageView.tintColor = .lightGray
                    dateLabel.text = "Ngày đặt: null"
                    dateLabel.textColor = .lightGray
                }
                if status == 1 {
                    nameLabel.textColor = .blue
                    statusLabel.text = "Trạng thái: đang có khách"
                    statusLabel.textColor = .blue
                    roomImageView.tintColor = .blue
                    dateLabel.text = "Ngày đặt: \(roomModel?.ngaydat ?? "")"
                    dateLabel.textColor = .blue
                }
                if status == 2 {
                    nameLabel.textColor = .red
                    statusLabel.text = "Trạng thái: đang nợ"
                    statusLabel.textColor = .red
                    roomImageView.tintColor = .red
                    dateLabel.text = "Ngày đặt: \(roomModel?.ngaydat ?? "")"
                    dateLabel.textColor = .red
                }
            }
            
            if let loaiPhong = roomModel?.loaiphong {
                if loaiPhong == 1 {
                    DispatchQueue.main.async {
                        self.vipImageView.image = #imageLiteral(resourceName: "vip").withRenderingMode(.alwaysOriginal)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.vipImageView.image = nil
                    }
                }
            }
            
        }
    }
    
    let roomImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "room").withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .red
        sv.axis = NSLayoutConstraint.Axis.vertical
        sv.distribution = UIStackView.Distribution.fillEqually
        return sv
    }()
    
    let vipImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(roomImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(vipImageView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(dateLabel)
        
        let constraints = [
            roomImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            roomImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            roomImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            roomImageView.widthAnchor.constraint(equalTo: roomImageView.heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: roomImageView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: roomImageView.rightAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -64),
            stackView.heightAnchor.constraint(equalTo: roomImageView.heightAnchor),
            
            vipImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vipImageView.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 8),
            vipImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            vipImageView.widthAnchor.constraint(equalToConstant: 40),
            vipImageView.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DanhSachPhongVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.roomModel = roomModels?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if roomModels?[indexPath.row].trangthai == 0 {
            let datphongVC = SuaThongTinPhongVC()
            datphongVC.type = 0
            datphongVC.idPhong = roomModels?[indexPath.row].id
            datphongVC.tenphongTF.text = roomModels?[indexPath.row].tenphong
            datphongVC.loaiphong = roomModels?[indexPath.row].loaiphong
            datphongVC.idNguoiDung = idNguoiDung
            self.navigationController?.pushViewController(datphongVC, animated: true)
        } else {
            let chiTietPhongVC = ChiTietPhongVC()
            chiTietPhongVC.idPhong = roomModels?[indexPath.row].id
            chiTietPhongVC.name = roomModels?[indexPath.row].tenphong
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(chiTietPhongVC, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let xoaBT = UITableViewRowAction(style: .normal, title: "Xoá") { (action, index) in
            if self.roomModels?[indexPath.row].trangthai == 0 {
                _ = DatabaseModel.getInstance().xoaPhong(idPhong: (self.roomModels?[indexPath.row].id!)!)
                self.roomModels?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                let xoaKhach = DatabaseModel.getInstance().xoaKhachTheoIdPhong(idPhong: (self.roomModels?[indexPath.row].id!)!)
                if xoaKhach {
                    _ = DatabaseModel.getInstance().xoaPhong(idPhong: (self.roomModels?[indexPath.row].id!)!)
                    self.roomModels?.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
        xoaBT.backgroundColor = .red
        return [xoaBT]
    }
    
}

class CustomView: UIView {
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nhập tên phòng"
        tf.font = UIFont.boldSystemFont(ofSize: 15)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        return tf
    }()
    
    let phongvipLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Phòng Vip"
        l.font = UIFont.boldSystemFont(ofSize: 15)
        return l
    }()
    
    let switchButton: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(textField)
        self.addSubview(phongvipLabel)
        self.addSubview(switchButton)
        
        let constraints = [
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            switchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            switchButton.rightAnchor.constraint(equalTo: textField.rightAnchor),
            
            phongvipLabel.centerYAnchor.constraint(equalTo: switchButton.centerYAnchor),
            phongvipLabel.leftAnchor.constraint(equalTo: textField.leftAnchor),
        ]

        NSLayoutConstraint.activate(constraints)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
