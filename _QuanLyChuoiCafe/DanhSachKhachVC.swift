//
//  DanhSachKhachVC.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/8/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

class DanhSachKhachVC: UITableViewController {
    
    private let cellId = "cellId"
    var idNguoiDung: Int?
    var khachArr: [KhachModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        tableView.register(KhachCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        getAllKhach()
    }
    
    private func getAllKhach() {
        khachArr = DatabaseModel.getInstance().getAllKhach(idNguoiTao: idNguoiDung!) as? [KhachModel]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "DANH SÁCH KHÁCH Ở TRỌ"
    }
}


class KhachCell: UITableViewCell {
    
    var khach: KhachModel? {
        didSet {
            if let hoten = khach?.hoten {
                tenLabel.text = hoten
            }
            
            if let sdt = khach?.sdt {
                sdtLabel.text = "SĐT: \(sdt)"
            }
        }
    }
    
    let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "user").withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .orange
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
    
    let tenLabel = UILabel()
    let sdtLabel = UILabel()
    let spLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.addSubview(userImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(tenLabel)
        stackView.addArrangedSubview(sdtLabel)
        stackView.addArrangedSubview(spLabel)
        
        tenLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        sdtLabel.font = UIFont.systemFont(ofSize: 16)
        sdtLabel.textColor = .lightGray
        
        spLabel.font = UIFont.systemFont(ofSize: 16)
        spLabel.textColor = .lightGray
        
        let constraints = [
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            userImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalTo: userImageView.heightAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DanhSachKhachVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return khachArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! KhachCell
        cell.khach = khachArr?[indexPath.row]
        let phong = DatabaseModel.getInstance().laySoPhong(idKhach: (khachArr?[indexPath.row].id)!)
        cell.spLabel.text = phong.tenphong
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
