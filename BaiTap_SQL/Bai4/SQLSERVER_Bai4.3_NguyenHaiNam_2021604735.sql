use master 
go

create database QLDH
on primary(
	name = 'QLBH_dat',
	filename = 'D:\QLBH.ldf',
	size = 10MB,
	maxsize = 100MB,
	filegrowth = 20%
)

log on(
name = 'QLBH_log',
	filename = 'D:\QLBH.mdf',
	size = 1MB,
	maxsize = 5MB,
	filegrowth = 20%
)
go

use QLDH
go

create table KhachHang(
	maKH nvarchar(5) not null primary key,
	Hoten nchar(25) not null,
	NgaySinh date not null,
	Que nvarchar(30) not null,
	Gt nchar(5) not null
)

create table NV(
	maNV nvarchar(5) not null primary key,
	HotenNV nchar(25) not null,
	Namlamviec int not null,
	luong money
)

create table DonDH(
	soHD nvarchar(5) not null,
	maKH nvarchar(5) not null,
	maNV nvarchar(5) not null,
	Sp nvarchar(20) not null
	constraint PK_DonDH primary key(soHD,maKH,maNV),
	constraint FK_DonDH_KhachHang foreign key(maKH)
		references KhachHang(maKH),
	constraint FK_DonDH_NV foreign key(maNV)
		references NV(maNV)
)
go

insert into KhachHang
	values('KH01', N'Trần Bình Minh', '1/5/1979', N'Hà Nội', 'Nam'),
	('KH02', N'Khổng Tước', '8/3/2000', N'Hà Tĩnh', 'Nam'),
	('KH03', N'Đặng Nga', '5/1/1997', N'Hà Nội', N'Nữ')


insert into NV
	values('N1', N'Trần An Nhiên', '2013', 60000000),
	('N2', N'Lê Bình An', '2018', 90000000),
	('N3', N'Phan Huy Văn', '2020', 50000000)


insert into DonDH
	values('H001', 'KH01', 'N1', N'SON MÔI'),
	('H002', 'KH02', 'N2', N'KEM DƯỠNG'),
	('H003', 'KH03', 'N2', N'TÚI')
go

select * from KhachHang 
select * from NV
select * from DonDH 

--C2: Đưa ra thông tin maNV, hotenNV, luong đặt hàng cho khách hàng Khổng Tước 

select NV.maNV, HotenNV, luong 
	from NV inner join DonDH
		on NV.maNV = DonDH.maNV
			inner join KhachHang
		on DonDH.maKH = KhachHang.maKH
	where Hoten = N'Khổng Tước'

--C3: Đưa ra thông tin: Manv, HotenNV, lương của những nhân viên có năm làm việc>2012 và có tên là Trần An Nhiên 

select NV.maNV, HotenNV, luong 
	from NV 
		where Namlamviec > 2012 and HotenNV = N'Trần An Nhiên'


--C4: Đưa ra thông tin nhân viên Lương cao nhất Thông tin hiển thị gồm có: Manv, Hoten, Lương

select NV.maNV, HotenNV, luong
	from NV	
		where luong in (select max(luong) from NV)
		
--C5 :  Đưa ra danh sách 2 khách hàng đầu tiên thông tin gồm :makh, hoten, tuổi của những khách hàng có quê là Hà Nội và sắp xếp giảm dần theo Hoten.
select top 2 KhachHang.maKH, Hoten, year(getdate()) - year(NgaySinh) as N'Tuổi'
	from KhachHang
	where Que = N'Hà Nội'
	order by Hoten desc 

--C6 : Thêm một bản ghi mới vào bảng dondathang,dữ liệu phù hợp( không được nhập giá trị null).
insert into DonDH 
	values('H004', 'KH03', 'N2', N'VÍ TIỀN')

--C7: Đưa ra makh, tên khách hàng, tuổi, sản phẩm đã mua của khách hàng mà nhân viên có tên Lê Bình an đã bán 
select KhachHang.maKH, Hoten,  year(getdate()) - year(NgaySinh) as N'Tuổi', Sp as N'Sản phẩm đã mua'	
	from KhachHang inner join DonDH
		on KhachHang.maKH = DonDH.maKH
			inner join NV
		on DonDH.maNV = NV.maNV
		where HotenNV = N'Lê Bình An'

--C8: Thống kê xem mỗi khách hàng đã mua bao nhiêu sản phẩm 
select KhachHang.maKH, Hoten, count(*) as N'Số sp đã mua'
	from KhachHang inner join DonDH
		on KhachHang.maKH = DonDH.maKH
		group by khachHang.maKH, Hoten

--C9: Đưa ra manv,hotennv đã bán sản phẩm son môi
select NV.maNV, HotenNV 
	from NV inner join DonDH
		on DonDH.maNV = NV.maNV
	where Sp = N'SON MÔI'
			
--C10: Đưa ra 2 nhân viên có lương thấp nhất
select top 2 NV.maNV, HotenNV, luong 
	from NV
	order by luong  

--C11: Đưa ra makh,hoten, tuoi có quê Hà Nội, đã mua hàng son môi do nhân viên Lê Bình An bán
select KhachHang.maKH, Hoten,  year(getdate()) - year(NgaySinh) as N'Tuổi' 
	from KhachHang inner join DonDH
		on KhachHang.maKH = DonDH.maKH
			inner join NV
		on DonDH.maNV = NV.maNV
		where HotenNV = N'Lê Bình An'
		and Sp = N'SON MÔI'
		and Que = N'Hà Nội'

--C12: Đưa ra thống kê mỗi nhân viên đã bán được bao nhiêu hàng
select NV.maNV, HotenNV, count(DonDH.soHD) as N'Số hàng bán được'
	from DonDH inner join NV
		on DonDH.maNV = NV.maNV
		group by NV.maNV, HotenNV

--C13: Thống kê xem mỗi quê có bao nhiêu khách hàng
select Que, count(KhachHang.maKH) as N'Số khách hàng '
	from KhachHang
	group by Que

--C14:  Đưa ra họ tên nv chưa bán được mặt hàng nào
select HotenNV, NV.maNV 
	from NV	
	where NV.maNV not in (select DonDH.maNV from DonDH) 

--C15: Đưa ra thông tin khách hàng chưa mua mặt hàng nào 
select KhachHang.maKH, Hoten 
	from KhachHang
	where KhachHang.maKH not in(select DonDH.maKH from DonDH)

--C16: đưa ra tất cả các khách hàng đã mua hàng
select * from KhachHang 
	where KhachHang.maKH in (select DonDH.maKH from DonDH)

--C17: Đưa ra manv, hotennv, luong, sanpham đã bán cho các khách hàng tên là Nga
select DonDH.maNV, HotenNV, luong, Sp
	from DonDH inner join NV		
		on DonDH.maNV = NV.maNV
			inner join KhachHang
		on KhachHang.maKH = DonDH.maKH
		where Hoten like N'%Nga%'

select * from KhachHang