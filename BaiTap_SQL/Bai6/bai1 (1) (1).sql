use master
go
create database QLBanHang_Bai6
on primary(
	name= 'QLBanHang_Bai6_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai6\QLBanHang_Bai6.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'QLBanHang_Bai6_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai6\QLBanHang_Bai6.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go
use QLBanHang_Bai6
go
create table HangSX(
	MaHangSX nchar(10) not null primary key,
	TenHang nvarchar(20) not null,
	DiaChi nvarchar(30),
	SoDT nvarchar(20),
	Email nvarchar(30)
)
create table SanPham(
	MaSP nchar(10) not null primary key,
	MaHangSX nchar(10) not null,
	TenSP nvarchar(20),
	SoLuong int,
	MauSac nvarchar(20),
	GiaBan money,
	DonViTinh nchar(10),
	MoTa nvarchar(max),
	constraint fk_SanPham foreign key (MaHangSX)
		references HangSX(MaHangSX)
)
create table NhanVien(
	MaNV nchar(10) not null primary key,
	TenNV nvarchar(20) not null,
	GioiTinh nchar(10),
	DiaChi nvarchar(30),
	SoDT nvarchar(20),
	Email nvarchar(30),
	TenPhong nvarchar(30)
)
create table PNhap(
	SoHDN nchar(10) not null primary key,
	NgayNhap date,
	MaNV nchar(10),
	constraint fk_PNhap_NhanVien foreign key(MaNV)
		references NhanVien(MaNV)
)
create table Nhap(
	SoHDN nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongN int,
	DonGiaN money,
	constraint pk_Nhap primary key(SoHDN, MaSP),
	constraint fk_Nhap_PNhap foreign key(SoHDN)
		references PNhap(SoHDN),
	constraint fk_Nhap_SanPham foreign key(MaSP)
		references SanPham(MaSP)
)
create table PXuat(
	SoHDX nchar(10) not null primary key,
	NgayXuat date,
	MaNV nchar(10) not null,
	constraint fk_PXuat_NhanVien foreign key(MaNV)
		references NhanVien(MaNV)
)
create table Xuat(
	SoHDX nchar(10) not null,
	MaSP nchar(10),
	SoLuongX int,
	constraint pk_Xuat primary key(SoHDX, MaSP),
	constraint fk_Xuat_PXuat foreign key(SoHDX)
		references PXuat(SoHDX),
	constraint fk_Xuat_SanPham foreign key(MaSP)
		references SanPham(MaSP)
)
go
insert into HangSX(MaHangSX, TenHang, DiaChi, SoDT, Email)
	values 
		('H01', 'Samsung', 'Korea', '011-08271717', 'ss@gmail.com.kr'),
        ('H02', 'OPPO', 'China', '081-08626262', 'oppo@gmail.com.cn'),
        ('H03', 'Vinfone', N'Việt nam', '084-098262626', 'vf@gmail.com.vn')
go
insert into NhanVien(MaNV, TenNV, GioiTinh, DiaChi, SoDT, Email, TenPhong)
	values
		('NV01', N'Nguyễn Thị Thu', N'Nữ', N'Hà Nội', '0982626521', 'thu@gmail.com', N'Kế toán'),
		('NV02', N'Lê Văn Nam', N'Nam', N'Bắc Ninh', '0972525252', 'nam@gmail.com', N'Vật tư'),
		('NV03', N'Trần Hòa Bình', N'Nữ', N'Hà Nội', N'0328388388', 'hb@gmail.com', N'Kế toán')
go
insert into SanPham(MaSP, MaHangSX, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa)
	values
		('SP01', 'H02', 'F1 Plus', 100, N'Xám', 7000000, N'Chiếc', N'Hàng cận cao cấp'),
		('SP02', 'H01', 'Galaxy Note11', 50, N'Đỏ', 19000000, N'Chiếc', N'Hàng cao cấp'),
		('SP03', 'H02', 'F3 lite', 200, N'Nâu', 3000000, N'Chiếc', N'Hàng phổ thông'),
		('SP04', 'H03', 'Vjoy3', 200, N'Xám', 1500000, N'Chiếc', N'Hàng phổ thông'),
		('SP05', 'H01', 'Galaxy V21', 500, N'Nâu', 8000000, N'Chiếc', N'Hàng cận cao cấp')
go
insert into PNhap(SoHDN, NgayNhap, MaNV)
	values
		('N01', '02-05-2019', 'NV01'),
		('N02', '03-04-2019', 'NV02'),
		('N03', '04-03-2019', 'NV02'),
		('N04', '05-02-2019', 'NV03'),
		('N05', '06-01-2019', 'NV01')
go
insert into Nhap(SoHDN, MaSP, SoLuongN, DonGiaN)
	values
		('N01', 'SP02', 10, 17000000),
		('N02', 'SP01', 30, 6000000),
		('N03', 'SP04', 20, 12000000),
		('N04', 'SP01', 10, 62000000),
		('N05', 'SP05', 20, 70000000)
go
insert into PXuat(SoHDX, NgayXuat, MaNV)
	values
		('X01', '06-14-2020', 'NV02'),
		('X02', '03-05-2019', 'NV03'),
		('X03', '12-12-2020', 'NV01'),
		('X04', '06-01-2020', 'NV02'),
		('X05', '06-04-2020', 'NV01')
go
insert into Xuat(SoHDX, MaSP, SoLuongX)
	values
		('X01', 'SP03', 5),
		('X02', 'SP01', 3),
		('X03', 'SP02', 1),
		('X04', 'SP03', 2),
		('X05', 'SP05', 1)
go
select *from HangSX
select *from SanPham
select *from NhanVien
select *from Nhap
select *from PNhap
select *from Xuat
select *from PXuat
go
--a (1đ). Đưa ra các thông tin về các hóa đơn mà hãng Samsung đã nhập trong năm 2020,
--gồm: SoHDN, MaSP, TenSP, SoLuongN, DonGiaN, NgayNhap, TenNV, TenPhong. 

create view vw_caua 
as 
	select Nhap.SoHDN, SanPham.TenSP, Nhap.SoLuongN, Nhap.DonGiaN, PNhap.NgayNhap, TenNV, TenPhong
			from PNhap inner join Nhap on PNhap.SoHDN=Nhap.SoHDN
					   inner join NhanVien on PNhap.MaNV=NhanVien.MaNV
					   inner join SanPham on Nhap.MaSP=SanPham.MaSP
					   inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
			where TenHang='Samsung' and Year(PNhap.NgayNhap)=2019

	select  SoHDN, TenSP from vw_caua
--b (1đ). Đưa ra các thông tin sản phẩm có giá bán từ 100.000 đến 500.000 của hãng Samsung. 

create view vw_caub
as 
	select MaSP, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
From SanPham Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
Where TenHang = 'Samsung' And GiaBan Between 100.000 And 500.000
  
  select *from vw_caub
--c (1đ). Tính tổng tiền đã nhập trong năm 2020 của hãng Samsung. 
Create view vw_cauc
as
Select Sum(SoLuongN*DonGiaN) As N'Tổng tiền nhập'
From Nhap Inner join SanPham on Nhap.MaSP = SanPham.MaSP
 Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
 Inner join PNhap on Nhap.SoHDN=PNhap.SoHDN
Where Year(NgayNhap)=2020 And TenHang = 'Samsung'

select * from vw_cauc
--d (1đ). Thống kê tổng tiền đã xuất trong ngày 14/06/2020. 
as
Select Sum(SoLuongX*GiaBan) As N'Tổng tiền xuất'
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
 Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX
Where NgayXuat = '06/14/2020'

--e (1đ). Đưa ra SoHDN, NgayNhap có tiền nhập phải trả cao nhất trong năm 2020.

Create view vw_Cau5
as
Select Nhap.SoHDN,NgayNhap
From Nhap Inner join PNhap on Nhap.SoHDN=PNhap.SoHDN
Where Year(NgayNhap)=2020 And SoLuongN*DonGiaN =
 (Select Max(SoLuongN*DonGiaN)
 From Nhap Inner join PNhap on 
Nhap.SoHDN=PNhap.SoHDN
 Where Year(NgayNhap)=2020
 )
--g (1đ). Hãy thống kê xem tổng tiền nhập của mỗi sản phẩm trong năm 2020. 
Create view vw_Cau6
as
Select HangSX.MaHangSX, TenHang, Count(*) As N'Số lượng sp'
From SanPham Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
Group by HangSX.MaHangSX, TenHang
--h (1đ). Hãy thống kê các sản phẩm có tổng số lượng xuất năm 2020 là lớn hơn 10.000 sản phẩm của hãng Samsung. 
Create view vw_Cau8
as
Select SanPham.MaSP,TenSP,sum(SoLuongX) As N'Tổng xuất'
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
    Inner join HangSX on HangSX.MaHangSX = SanPham.MaHangSX
    Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX
Where Year(NgayXuat)=2018 And TenHang = 'Samsung'
Group by SanPham.MaSP,TenSP
Having sum(SoLuongX) >=10000
select *from vw_Cau8
--i (1đ). Thống kê số lượng nhân viên Nam của mỗi phòng ban.

--j (1đ). Thống kê tổng số lượng nhập của mỗi hãng sản xuất trong năm 2018.

--k (1đ). Hãy thống kê xem tổng lượng tiền xuất của mỗi nhân viên trong năm 2018 là bao nhiêu.