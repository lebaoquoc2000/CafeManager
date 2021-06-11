//
//  DatabaseModel.swift
//  QuanLyPhongTro
//
//  Created by Tran Thanh  Nhan on 8/6/20.
//  Copyright © 2020 Tran Thanh  Nhan. All rights reserved.
//

import UIKit

let sharedInstance = DatabaseModel()

class DatabaseModel: NSObject {
    
    var database: FMDatabase?
    
    class func getInstance() -> DatabaseModel {
        if (sharedInstance.database == nil) {
            sharedInstance.database = FMDatabase(path: Util.getPath(fileName: "QuanLyChuoiCafe.sqlite"))
        }
        return sharedInstance
    }
    
    func dangKyTaiKhoan(_ TaiKhoanModel: TaiKhoanModel) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO nguoidung (tennguoidung, tendangnhap, matkhau) VALUES(?, ?, ?)", withArgumentsIn: [TaiKhoanModel.tennguoidung!, TaiKhoanModel.tendangnhap!, TaiKhoanModel.matkhau!])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func dangNhap(tendn: String, matkhau: String) -> TaiKhoanModel {
        sharedInstance.database!.open()
        let result: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM nguoidung where tendangnhap = ? and matkhau = ?", withArgumentsIn: [tendn, matkhau])
        let item = TaiKhoanModel()
        if result != nil {
            while result.next() {
                item.id = Int(result.int(forColumn: "id"))
                item.tennguoidung = String(result.string(forColumn: "tennguoidung")!)
                item.tendangnhap = String(result.string(forColumn: "tendangnhap")!)
                item.matkhau = String(result.string(forColumn: "matkhau")!)
            }
        }
        sharedInstance.database?.close()
        return item
    }
    
    
   
    

    
    func datPhong(idPhong: Int, tenPhong: String, ngayDat: String, tienPhong: Int, soNguoi: Int, ngayThanhToan: String, trangThai: Int) -> Bool {
        sharedInstance.database!.open()
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE phong SET tenphong = ?, ngaydat = ?, tienphong = ?, songuoi = ?, ngaythanhtoan = ?, trangthai = ? WHERE id = ?", withArgumentsIn: [tenPhong, ngayDat, tienPhong, soNguoi, ngayThanhToan, trangThai, idPhong])
        
        sharedInstance.database!.close()
        return isUpdated
        
    }
    
    
    
    
    
    func suaThongTinPhong(tenPhong: String, ngayDat: String, tienPhong: Int, soNguoi: Int, ngayThanhToan: String, loaiPhong: Int, idPhong: Int) -> Bool {
        sharedInstance.database!.open()

        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE PHONG SET tenphong = ?, ngaydat = ?, tienphong = ?, songuoi = ?, ngaythanhtoan = ?, loaiphong = ? WHERE id = ?", withArgumentsIn: [tenPhong, ngayDat, tienPhong, soNguoi, ngayThanhToan, loaiPhong, idPhong])

        sharedInstance.database!.close()
        return isUpdated

    }
    
    func suaThongTinKhach(tenKhach: String, sdt: String, diaChi: String, idPhong: Int) -> Bool {
        sharedInstance.database!.open()
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE khachdatphong SET hoten = ?, sdt = ?, diachi = ? WHERE id_phong = ?", withArgumentsIn: [tenKhach, sdt, diaChi, idPhong])
        
        sharedInstance.database!.close()
        return isUpdated
        
    }
    
    func thayDoiTrangThaiPhong(trangThai: Int, idPhong: Int, ngayThanhToan: String) -> Bool {
        sharedInstance.database!.open()
        
        if trangThai == 0 { // Trả phòng
            let isUpdated = sharedInstance.database!.executeUpdate("UPDATE phong SET trangthai = ?, ngaydat = 'null', tienphong = 0, songuoi = 0, ngaythanhtoan = 'null' WHERE id = ?", withArgumentsIn: [trangThai, idPhong])
            
            return isUpdated
        }
        
        if trangThai == 1 { // Đã thanh toán
            let isUpdated = sharedInstance.database!.executeUpdate("UPDATE phong SET trangthai = ?, ngaythanhtoan = ? WHERE id = ?", withArgumentsIn: [trangThai, ngayThanhToan, idPhong])
            
            return isUpdated
        }
        
        if trangThai == 2 { // Đang nợ
            let isUpdated = sharedInstance.database!.executeUpdate("UPDATE phong SET trangthai = ? WHERE id = ?", withArgumentsIn: [trangThai, idPhong])
            
            return isUpdated
        }
        
        sharedInstance.database!.close()
        return false
    }
    
    func thayDoiTrangThaiKhachTheoPhong(idPhong: Int) -> Bool {
        sharedInstance.database!.open()
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE khachdatphong SET trangthai = 0 WHERE id_phong = ?", withArgumentsIn: [idPhong])
        
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func xoaPhong(idPhong: Int) -> Bool {
        sharedInstance.database!.open()

        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM phong WHERE id = ?", withArgumentsIn: [idPhong])
        
        sharedInstance.database!.close()
        return isDeleted

    }
    

    
    func xoaKhach(idKhach: Int) -> Bool {
        sharedInstance.database!.open()
        
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM khachdatphong WHERE id = ?", withArgumentsIn: [idKhach])
        
        sharedInstance.database!.close()
        return isDeleted
        
    }
    
    func xoaKhachTheoIdPhong(idPhong: Int) -> Bool {
        sharedInstance.database!.open()
        
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM khachdatphong WHERE id_phong = ?", withArgumentsIn: [idPhong])
        
        sharedInstance.database!.close()
        return isDeleted
    }
    
    
    
}
