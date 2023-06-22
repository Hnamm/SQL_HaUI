use master
go
create database QLKHO_Bai6
on primary(
	name='QLKHO_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai6\QLKHO.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name='QLKHO_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai6\QLKHO.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go
use QLKHO_Bai6
go
create table Ton(
	MaVT varchar(20) not null primary key,
	TenVT nvarchar(20) not null,
	SoLuongT int
)
create table Nhap(
	SoHDN varchar(20) not null,
	MaVT varchar(20) not null,
	SoLuongN int,
	DonGiaN int,
	NgayN datetime,
	constraint pk_Nhap primary key(SoHDN, MaVT),
	constraint fk_Nhap_Ton foreign key (MaVT)
		references Ton(MaVT)
)
create table Xuat(
	SoHDX varchar(20) not null,
	MaVT varchar(20) not null,
	SoLuongX int,
	DonGiaX int,
	NgayX datetime,
	constraint pk_Xuat primary key(SoHDX,MaVT),
	constraint fk_Xuat_Ton foreign key (MaVT)
		references Ton(MaVT)
)
go
insert into Ton
	values
		('VT01', N'Ti Vi', 2),
		('VT02', N'Máy Giặt', 1),
		('VT03', N'Bếp', 4),
		('VT04', N'Tủ Lạnh', 6),
		('VT05', N'Điện Thoại', 3)
go
insert into Nhap 
	values
		('N1', 'VT01', 20, 1000, '1/2/2012'),
		('N2', 'VT04', 30, 2000, '1/2/2012'),
		('N3', 'VT02', 25, 4000, '1/2/2012')
go
insert into Xuat
	values
		('X1', 'VT01', 10, 1200, '3/2/2012'),
		('X2', 'VT04', 10, 2200, '3/2/2012')
go
--Câu 2 (1đ). đưa ra tên vật tư số lượng tồn nhiều nhất
create view vw_cau2
as
	select TenVT
	from Ton
	where SoLuongT = (select max(SoLuongT) from Ton)

--Câu 3 (1đ). đưa ra các vật tư có tổng số lượng xuất lớn hơn 100
create view vw_cau3
as 
	select Ton.MaVT, Ton.TenVT, SoLuongX
	from Ton inner join Xuat on Ton.MaVT=Xuat.MaVT
	
select MaVT, TenVT, sum(SoLuongX) as N'Tong so luong xuat'from vw_cau3 group by MaVT, TenVT
					having sum(SoLuongX) >100
--Câu 4 (1đ). Tạo view đưa ra tháng xuất, năm xuất, tổng số lượng xuất 
--thống kê theo tháng và năm xuất

create view vw_cau4
as
	select NgayX, SoLuongX
	from Xuat
	
select MONTH(NgayX) as 'Thang', YEAR(NgayX) as N'Nam', sum(SoLuongX) as N'Tong so luong xuat' from vw_cau4 group by MONTH(NgayX), YEAR(NgayX)

--Câu 5 (2đ). tạo view đưa ra mã vật tư. tên vật tư. số lượng nhập. số lượng xuất. 
--don giá N. đơn giá X. ngày nhập. Ngày xuất.

create view vw_cau5 
as
	select Nhap.MaVT, TenVT, SoLuongN, SoLuongX, SoLuongN, DonGiaN, DonGiaX, NgayN, NgayX
	from Nhap inner join Xuat on Nhap.MaVT=Xuat.MaVT
	inner join Ton on Nhap.MaVT=Ton.MaVT

--Câu 6 (2đ). Tạo view đưa ra mã vật tư. tên vật tư và tổng số lượng còn lại trong kho. 
--biết còn lại = SoluongN-SoLuongX+SoLuongT theo từng loại Vật tư trong năm 
--2015

create view vw_cau6
as 
	select Nhap.MaVT , TenVT, SoLuongX, SoLuongN, SoLuongT
	from Nhap inner join Xuat on Nhap.MaVT=Xuat.MaVT
	inner join Ton on Nhap.MaVT=Ton.MaVT
	where Year(NgayX) = 2012

	select MaVT, TenVT, SoLuongN - SoLuongX + SoLuongT as 'Hang con lai'
	from vw_cau6 
	group by MaVT, TenVT, SoLuongN - SoLuongX + SoLuongT

