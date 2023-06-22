use master
go
create database ThucTap
on primary(
	name= 'ThucTap_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai3\ThucTap.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'ThucTap_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai3\ThucTap.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go
use ThucTap
go
create table Khoa(
	makhoa char(10) not null primary key,
	tenkhoa char(30) not null,
	dienthoai char(10)
)
create table GiangVien(
	magv int not null primary key,
	hotengv char(30) not null,
	luong decimal(5,2) not null,
	makhoa char(10) not null,
	constraint fk_GiangVien_Khoa foreign key(makhoa)
		references Khoa(makhoa)
)
create table SinhVien(
	masv int not null primary key,
	hotensv char(30) not null,
	makhoa char(10) not null,
	namsinh int, 
	quequan char(30),
	constraint fk_SinhVien_Khoa foreign key(makhoa)
		references Khoa(makhoa)
)
create table DeTai(
	madt char(10) not null primary key,
	tendt char(30) not null,
	kinhphi int,
	noithuctap char(30)
)
create table HuongDan(
	masv int not null primary key,
	madt char(10) not null,
	magv int not null,
	ketqua decimal(5,2),
	constraint fk_HuongDan_GiangVien foreign key (magv)
		references GiangVien(magv),
	constraint fk_HuongDan_SinhVien foreign key(masv)
		references SinhVien(masv),
	constraint fk_HuongDan_DeTai foreign key(madt)
		references DeTai(madt)
)
go
insert into Khoa
	values 
		('K1', 'CNTT', '0978105061'),
		('K2', 'QLTN', '0978115161'),
		('K3', 'DIALY', '0972305061')
go
insert into GiangVien
	values 
		(01, 'Tran Son', 509.87, 'K1'),
		(02, 'Minh Duc', 569.73, 'K1'),
		(03, 'Dinh Tang', 504.57, 'K2'),
		(04, 'Duy Chien', 672.37, 'K3')
go
insert into SinhVien
	values 
		(01 ,'Hai Nam', 'K1', 2003, 'Thai Binh'),
		(02, 'Phuong Thao', 'K1', 2003, 'Ha Noi'),
		(03, 'Bui Hoang', 'K1', 2003, 'Thai Nguyen'),
		(04, 'Nam Hai', 'K2', 2003, 'Ninh Binh'),
		(05, 'Manh', 'K3', 2003, 'Thai Binh')
go
insert into DeTai
	values
		('DT1', 'TENDT1', 500, 'Que Nha'),
		('DT2', 'TENDT2', 200, 'Ha Noi'),
		('DT3', 'TENDT3', 400, 'Ninh Binh')
go
insert into HuongDan
	values
		(01, 'DT1', 01, 534.58),
		(02, 'DT1', 01, 633.45),
		(03, 'DT2', 01, 683.45),
		(04, 'DT2', 02, 943.45)
go
--1. Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
select DeTai.madt, tendt 
from DeTai inner join HuongDan on DeTai.madt=HuongDan.madt
			inner join GiangVien on HuongDan.magv=GiangVien.magv
where hotengv= 'Tran Son'
--2. Cho biết tên đề tài không có sinh viên nào thực tập
select DeTai.tendt
from DeTai
where DeTai.madt not in(select HuongDan.madt from HuongDan)
--3. Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên 
--trở lên.
SELECT GiangVien.magv,hotengv,tenkhoa
FROM GiangVien  inner join Khoa
ON GiangVien.Makhoa = Khoa.Makhoa
inner join HuongDan 
on GiangVien.magv=HuongDan.magv
group by GiangVien.magv,hotengv,tenkhoa
having count(HuongDan.masv)>=3
--4. Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
select DeTai.madt, tendt
from DeTai
where kinhphi= (select max(kinhphi) from DeTai)
--5. Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT DeTai.madt,DeTai.tendt
FROM DeTai
WHERE DeTai.madt in (
SELECT HuongDan.madt
FROM HuongDan
GROUP BY HuongDan.madt
HAVING COUNT(HuongDan.madt) > 2)
--6. Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
SELECT SinhVien.masv,SinhVien.hotensv,HuongDan.ketqua
FROM SinhVien inner join HuongDan
ON SinhVien.masv = HuongDan.masv
inner join Khoa 
ON Khoa.makhoa = SinhVien.makhoa
WHERE Khoa.tenkhoa = 'DIALY va QLTN'
--7. Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT Khoa.tenkhoa, COUNT(SinhVien.masv) AS Số_SV
FROM SinhVien inner join Khoa
ON SinhVien.makhoa = Khoa.makhoa
GROUP BY Khoa.tenkhoa
--8. Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT *
FROM SinhVien inner join HuongDan
ON HuongDan.masv = SinhVien.masv
inner join DeTai
ON DeTai.madt = HuongDan.madt
WHERE SinhVien.quequan = DeTai.noithuctap
--9. Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT *
FROM SinhVien 
WHERE SinhVien.masv not in (select HuongDan.masv from HuongDan)
--10.Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT SinhVien.masv,SinhVien.hotensv
FROM SinhVien inner join HuongDan
ON HuongDan.masv = SinhVien.masv
WHERE HuongDan.KetQua = 0
