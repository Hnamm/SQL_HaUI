use master
go
create database QLBanHang_Bai93
go
use QLBanHang_Bai93
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
/*Tạo thủ tục nhập dữ liệu cho bảng sản phẩm với các tham biến truyền vào MaSP, 
TenHangSX, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa. Hãy kiểm tra xem 
nếu MaSP đã tồn tại thì cập nhật thông tin sản phẩm theo mã, ngược lại thêm mới sản phẩm 
vào bảng SanPham.*/
create proc SP_Nhap(@masp nchar(10), @tenhangsx nvarchar(20), @tensp nvarchar(20),
				    @soluong int, @mausac nvarchar(20), @giaban money, @donvitinh nchar(10),
					@mota nvarchar(max))
as
begin
	if(not exists(select *from HangSX where TenHang=@tenhangsx))
		print (N'Khong co hang san xuat nay')
	else
		begin
		declare @mahangsx nchar(10)
		set @mahangsx = (select MaHangSX from HangSX where TenHang=@tenhangsx)
		if(exists(select * from SanPham where MaSP=@masp))
			begin 
			update SanPham
			set MaHangSX=@mahangsx,
				TenSP=@tensp,
				SoLuong=@soluong,
				MauSac=@mausac,
				GiaBan=@giaban,
				DonViTinh=@donvitinh,
				MoTa=@mota
				where MaSP=@masp
				print (N'Cap nhat thanh cong')
			end
		else
			begin
			insert into SanPham
			values(@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
			print('Them moi thanh cong')
			end
		end
end

exec SP_Nhap 'SP09', 'Samsun', 'Tivi',100, 'Den', 399988, 'Chiec', 'Hang deu'

select *from SanPham

/*Viết thủ tục xóa dữ liệu bảng HangSX với tham biến là TenHang. Nếu TenHang chưa 
có thì thông báo, ngược lại xóa HangSX với hãng bị xóa là TenHang. (Lưu ý: xóa HangSX
thì phải xóa các sản phẩm mà HangSX này cung ứng).*/

create proc SP_Xoa(@tenhang nvarchar(20))
as
begin
	if(not exists(select *from HangSX where TenHang=@tenhang))
		print(N'Khong co ten hang san xuat nay')
	else
		begin
		declare @mahangsx nchar(10)
		set @mahangsx = (select MaHangSX from HangSX where TenHang=@tenhang)

		DELETE FROM Nhap WHERE MaSP IN (SELECT MaSP FROM SanPham WHERE MaHangSX = @mahangsx)
		DELETE FROM Xuat WHERE MaSP IN (SELECT MaSP FROM SanPham WHERE MaHangSX = @mahangsx)

		delete from SanPham where MaHangSX=@mahangsx
		delete from HangSX where MaHangSX=@mahangsx

		print(N'Xoa hang san xuat thanh cong')

		end
end
exec SP_Xoa 'OPPO' 
select *from HangSX
select *from SanPham
select *from Nhap
select *from Xuat

 /*Viết thủ tục nhập dữ liệu cho bảng nhân viên với các tham biến manv, TenNV, GioiTinh, 
DiaChi, SoDT, Email, Phong, và 1 biến cờ Flag, Nếu Flag = 0 thì cập nhật dữ liệu cho bảng 
nhân viên theo manv, ngược lại thêm mới nhân viên này.*/

create proc SP_Cauc (@MaNV nchar(10),
					@TenNV nvarchar(20),
					@GioiTinh nchar(10),
					@DiaChi nvarchar(30),
					@SoDT nvarchar(20),
					@Email nvarchar(30),
					@TenPhong nvarchar(30),
					@flag int)
as 
begin
	if(@flag =0)
		begin
			if(exists(select *from NhanVien where MaNV=@MaNV))
				begin
						update NhanVien
						set TenNV=@TenNV,
						GioiTinh=@GioiTinh,
						DiaChi=@DiaChi,
						SoDT=@SoDT,
						Email=@Email,
						TenPhong=@TenPhong
						where MaNV=@MaNV
				end
			else 
				print(N'Khong the cap nhat')
		end
	else
		begin
		insert into NhanVien
		values(@MaNV, @TenNV, @GioiTinh, @DiaChi, @SoDT, @Email, @TenPhong)
		end
end
exec SP_Cauc 'NV05', N'Nguyễn Hải', N'Nam', N'Thái Bình', '09889787', 'hainam@gmail.com', N'Kế toán' , 1

select *from NhanVien

 /*Viết thủ tục nhập dữ liệu cho bảng Nhap với các tham biến SoHDN, MaSP, manv, 
NgayNhap, SoLuongN, DonGiaN. Kiểm tra xem MaSP có tồn tại trong bảng SanPham hay 
không? manv có tồn tại trong bảng NhanVien hay không? Nếu không thì thông báo, ngược 
lại thì hãy kiểm tra: Nếu SoHDN đã tồn tại thì cập nhật bảng Nhap theo SoHDN, ngược lại 
thêm mới bảng Nhap.*/
create proc sp_Nhapmoi (
						@SoHDN nchar(10),
						@MaSP nchar(10),
						@MaNV nchar(10),
						@NgayNhap date,
						@SoLuongN int,
						@DonGiaN money)
as
begin
	if(not exists(select *from SanPham where MaSP=@MaSP))
		print(N'Khong co san pham nay')
	else 
		if(not exists(select *from NhanVien where MaNV=@MaNV))
			print(N'Khong co nhan vien nay')
		else
		begin
		if(exists(select *from Nhap where SoHDN=@SoHDN))
			begin
			update Nhap
			set MaSP=@MaSP,
				DonGiaN=@DonGiaN,
				SoLuongN=@SoLuongN
			where SoHDN=@SoHDN
			update PNhap
			set NgayNhap=@NgayNhap,
				MaNV=@MaNV
			where SoHDN=@SoHDN
				print(N'Cap nhat thanh cong')
			end
		else
			begin
			insert into Nhap
			values (@SoHDN, @MaSP, @SoLuongN, @DonGiaN)
			insert into PNhap
			values (@SoHDN, @NgayNhap, @MaNV)
			print (N'Them moi thanh cong')
			end
		end
end
EXEC sp_Nhapmoi 'N01', 'SP02', 'NV03', '2021-12-13', 40, 4500000
SELECT *FROM Nhap
select *from PXuat


------Bai2----

/*a. Viết thủ tục thêm mới sản phẩm với các tham biến MaSP, TenHang, TenSP, SoLuong, 
MauSac, GiaBan, DonViTinh, MoTa và 1 biến Flag. Nếu Flag=0 thì thêm mới sản phẩm, 
ngược lại cập nhật sản phẩm. Hãy kiểm tra:
- Nếu TenHang không có trong bảng HangSX thì trả về mã lỗi 1
- Nếu SoLuong <0 thì trả về mã lỗi 2
 Ngược lại trả về mã lỗi 0.*/

 create proc SP_Bai2a(@MaSP nchar(10),
					@TenHang nvarchar(20), 
					@TenSP nvarchar(20),
					@SoLuong int,
					@MauSac nvarchar(20),
					@GiaBan money,
					@DonViTinh nchar(10),
					@MoTa nvarchar(max),
					@flag int,
					@trave int output)
as 
begin
	if(not exists(select *from HangSX where TenHang=@TenHang))
		set @trave = 1
	else if(@SoLuong<0)
		set @trave = 2
	else
		begin
		set @trave = 0
		declare @mahangsx nchar(10)
		set @mahangsx = (select MaHangSX from HangSX where  TenHang=@TenHang)
		if(@flag=0)
			begin
			insert into SanPham values(@MaSP, @mahangsx, @TenSP, @SoLuong, @MauSac, @GiaBan, @DonViTinh, @MoTa)
			end
		else
			begin
			update SanPham
			set MaHangSX=@mahangsx,
				TenSP=@TenSP,
				SoLuong=@SoLuong,
				MauSac=@MauSac,
				GiaBan=@GiaBan,
				DonViTinh=@DonViTinh,
				MoTa=@MoTa
			where MaSP=@MaSP
			end
		end
end

declare @kq int
exec SP_Bai2a 'SP07', N'Samsung', N'Galaxy A10', 99, N'Xanh', 6000000, N'Chiếc', N'Hàng cận cao cấp', 0, @kq output
select @kq
select *from SanPham



/*Viết thủ tục xóa dữ liệu bảng NhanVien với tham biến là manv. Nếu manv chưa có thì 
trả về 1, ngược lại xóa NhanVien với NhanVien bị xóa là manv và trả về 0. (Lưu ý: xóa 
NhanVien thì phải xóa các bảng Nhap, Xuat mà nhân viên này tham gia).*/

create proc SP_XoaNV(@manv nchar(10), @trave int output)
as
begin 
	if(not exists(select *from NhanVien where MaNV=@manv))
		set @trave = 1
	else
		begin
			delete from PNhap where MaNV=@manv
			delete from PXuat where MaNV=@manv
			delete from Nhap where SoHDN in (select SoHDN from PNhap where MaNV=@manv)
			delete from Xuat where SoHDX in (select SoHDX from PXuat where MaNV=@manv)
			delete from NhanVien where MaNV=@manv
			set @trave = 0
		end
end

declare @kq int
exec SP_XoaNV 'NV05', @kq output
select @kq
declare @cc int
exec SP_XoaNV 'NV05', @cc output
select @cc
declare @dd int
exec SP_XoaNV 'NV03', @dd output
select @dd
select *from NhanVien
select *from PNhap
select *from PXuat

/*Viết thủ tục xóa dữ liệu bảng SanPham với tham biến là MaSP. Nếu MaSP chưa có thì 
trả về 1, ngược lại xóa SanPham với SanPham bị xóa là MaSP và trả về 0. (Lưu ý: xóa 
SanPham thì phải xóa các bảng Nhap, Xuat mà SanPham này cung ứng).*/

create proc SP_XoaSP(@MaSP nchar(10), @trave int output)
as
begin
	if(not exists(select *from SanPham where MaSP=@MaSP))
		set @trave = 1
	else 
		begin 
		delete from Nhap where MaSP=@MaSP
		delete from Xuat where MaSP=@MaSP
		delete from PNhap where SoHDN in (select SoHDN from Nhap where MaSP=@MaSP)
		delete from PXuat where SoHDX in (select SoHDX from Xuat where MaSP=@MaSP)
		delete from SanPham where MaSP=@MaSP
		set @trave = 0
		end
end

declare @kq1 int 
exec SP_XoaSP 'SP03', @kq1 output
select @kq1

select *from SanPham
select *from Nhap
select *from Xuat
