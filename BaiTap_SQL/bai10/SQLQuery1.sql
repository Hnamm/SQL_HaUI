use master 
go
create database QLBH_KTRA1
go
use QLBH_KTRA1
go
create table SANPHAM (
	MaSP nchar(10) not null primary key,
	TenSP nvarchar(20) not null,
	SoLuong int,
	DonGia money,
	MauSac nvarchar(20)
)
create table NHAP(
	SoHDN nchar(10) not null,
	MaSP nchar(10) not null,
	NgayN date,
	SoLuongN int,
	DonGiaN money,
	constraint pk_NHAP primary key(SoHDN, MaSP),
	constraint fk_NHAP_SANPHAM foreign key(MaSP)
		references SANPHAM(MaSP)
)
create table XUAT(
	SoHDX nchar(10) not null,
	MaSP nchar(10) not null,
	NgayX date,
	SoLuongX int,
	constraint pk_XUAT primary key(SoHDX, MaSP),
	constraint fk_XUAT_SANPHAM foreign key(MaSP)
		references SANPHAM(MaSP)
)
go
insert into SANPHAM
values  ('SP01',N'Tủ Lạnh', 10, 100000, N'Trắng'),
		('SP02',N'Điện Thoại', 13, 123000, N'Đen'),
		('SP03',N'Iphone', 12, 10000, N'Trắng'),
		('SP04',N'Tai Nghe', 10, 12000, N'Xám'),
		('SP05',N'Bếp', 15, 15000, N'Đỏ')
insert into NHAP
values  ('N01', 'SP01', '2022-3-4', 5, 2000),
		('N02', 'SP03', '2022-2-6', 7, 3000),
		('N03', 'SP04', '2022-3-5', 9, 8000)
insert into XUAT
values  ('X01', 'SP02', '2022-5-6', 3),
		('X02', 'SP03', '2022-5-12', 1),
		('X03', 'SP05', '2022-5-29', 6)
go
select *from SANPHAM
select *from NHAP
select *from XUAT
go

/*câu 2: Tạo hàm thống kê tiền xuất (Tiền xuất = soluongx * dongia) của mặt hàng 
TenSP, NgãyX nahp tu ban phim
*/
create function fn_cau2(@TenSP nvarchar(20), @NgayX date)
returns money
as
begin
	declare @tienxuat money
	set @tienxuat = (select SoLuongX * DonGia  
					from SANPHAM inner join XUAT on SANPHAM.MaSP=XUAT.MaSP
					where TenSP=@TenSP and NgayX=@NgayX)
	return @tienxuat
end

select dbo.fn_cau2(N'Điện Thoại', '2022-5-6') as N'Tiền Xuất' 

create function fn_cau2_cach2(@TenSP nvarchar(20), @NgayX date)
returns @Bangtienxuat table(
					TenSP nvarchar(20),
					NgayX date,
					TienXuat money)
as
begin
	insert into @Bangtienxuat
		select TenSP, NgayX, SoLuongX * DonGia 
		from SANPHAM inner join XUAT on SANPHAM.MaSP=XUAT.MaSP
		where TenSP=@TenSP and NgayX=@NgayX
	return
end
select *from fn_cau2_cach2(N'Điện Thoại', '2022-5-6')

/* câu 3: tạo thủ tục cập nhật dữ liệu cho bảng Nhap với các tham biến truyền vào là 
sohdn, masp, soluongn, dongian,.Hãy kiểm tra xem MaSP có trong bảng sanpham hay không 
Nếu không đưa ra thông báo. ngược lại cho phép cập nhật theo SoHDN
*/
create proc SP_cau3(@SoHDN nchar(10), @MaSP nchar(10), @SoLuongN int, @DonGiaN money)
as
begin
	if(not exists(select *from SANPHAM where MaSP=@MaSP))
		print(N'Ma san pham khong co')
	else 
			begin
			update NHAP
			set MaSP=@MaSP,
				SoLuongN=@SoLuongN,
				DonGiaN=@DonGiaN
			where SoHDN=@SoHDN
			end
end

exec SP_cau3 'N07', 'SP01', 30, 19000

select *from NHAP
/* câu 4: Tạo trigger kiểm sáot việc cập nhật lại soluongx trong bảng xuất. hãy kiểm tra
xem masp cần xuất có trong bảng SanPhẩm không? SoluongX cập nhật lại có <soluong không?. nêu không
đưa ra thông báo. ngược lại cho phép cập nhật*/
alter trigger trg_CapNhat
on XUAT
for update
as
begin
	declare @masp nchar(10)
	set @masp = (select MaSP from inserted)
	declare @slco int
	declare @sltrc int
	declare @slsau int
	set @slco = (select SoLuong from SANPHAM where MaSP=@masp)
	set @sltrc = (select SoLuongX from deleted)
	set @slsau = (select SoLuongX from inserted)
	
	if(not exists(select *from SANPHAM where MaSP=@masp))
		begin
		raiserror(N'Khong co ma san pham nay', 16, 1)
		rollback transaction
		end
	else
		if(@slco<@slsau-@sltrc)
			begin
			raiserror(N'Khong du hang de cap nhat', 16, 1)
			rollback transaction
			end
		else
			begin
			update SANPHAM
			set SoLuong = SoLuong - (@slsau-@sltrc)
			where MaSP=@masp
			end
end

select *from SANPHAM
select *from XUAT
update XUAT
set SoLuongX=17
where MaSP='SP02'
