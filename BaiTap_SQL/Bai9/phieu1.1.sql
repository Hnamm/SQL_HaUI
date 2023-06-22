use master
go
create database QLBanHang_Bai9_phieu11
go
use QLBanHang_Bai9_phieu11
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
/*Viết thủ tục nhập dữ liệu cho bảng xuat với các tham biến SoHDX, MaSP, manv, 
NgayXuat, SoLuongX. Kiểm tra xem MaSP có tồn tại trong bảng SanPham hay không? 
manv có tồn tại trong bảng NhanVien hay không? SoLuongX <= SoLuong? Nếu không thì 
thông báo, ngược lại thì hãy kiểm tra: Nếu SoHDX đã tồn tại thì cập nhật bảng Xuat theo 
SoHDX, ngược lại thêm mới bảng Xuat.*/

create proc SP_caua(@SoHDX nchar(10),
					@MaSP nchar(10),
					@MaNV nchar(10),
					@NgayXuat datetime,
					@SoLuongX int)
as
begin
	declare @SoLuong int
	set @SoLuong = (select SoLuong from SanPham where MaSP=@MaSP)
	if(not exists(select *from SanPham where MaSP=@MaSP))
		print(N'Khong ma san pham')
	else if(not exists(select *from NhanVien where MaNV=@MaNV))
		print(N'Khong co ma nhan vien')
	else if(@SoLuongX>@SoLuong)
		print(N'Khong du so luong san pham de xuat')
	else
		begin
		if(not exists(select *from Xuat where SoHDX=@SoHDX))
			begin
			insert into Xuat values(@SoHDX, @MaSP, @SoLuongX)
			insert into PXuat values(@SoHDX, @NgayXuat, @MaNV)
			print(N'Them moi thanh cong')
			end
		else
			begin
			update Xuat
			set MaSP=@MaSP,
				SoLuongX=@SoLuongX
			where SoHDX=@SoHDX
			update PXuat
			set NgayXuat=@NgayXuat,
				MaNV=@MaNV
			where SoHDX=@SoHDX
			print(N'Cap nhat thanh cong')
			end
		end
end

exec SP_caua 'X07', 'SP04', 'NV01','2000-12-11', 2

select *from Xuat
select *from PXuat

/*. Viết thủ tục xóa dữ liệu bảng NhanVien với tham biến là manv. Nếu manv chưa có 
thì thông báo, ngược lại xóa NhanVien với NhanVien bị xóa là manv. (Lưu ý: xóa 
NhanVien thì phải xóa các bảng Nhap, Xuat mà nhân viên này tham gia).*/





