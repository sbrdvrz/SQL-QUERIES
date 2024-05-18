use ETRADE2

-- data manipilasyon komutlarý 
	-- Select - Update - Delete - Insert - Truncate
--Veritabaný manipilasyonlarý
	--Create Alter Drop

select * from customers where býrthdate between '19780101' and  '20041230' order by býrthdate,cýty

select * from customers where namesurname Like '%asd'
select * from customers where namesurname Like 'asd%'
select * from customers where namesurname Like '%asd%'

select * from customers where namesurname Not Like '%asd'
select * from customers where namesurname Not Like 'asd%'
select * from customers where namesurname Not Like '%asd%'



select * from CUSTOMERS

-- Ýnsert , Delete VE Update Komutu
insert into CUSTOMERS values('selimDevrez','E','2004-02-05','Çorum','Kargý','05522193919','Selim','Devrez')
insert into CUSTOMERS (NAMESURNAME,GENDER,BIRTHDATE,CITY,TOWN,TELNR,NAME_,SURNAME) values('selimBeraDevrez','E','2004-02-05','Ýstanbul','Pendik','05522193919','SelimBera','Devrez')
delete from CUSTOMERS Where NAMESURNAME='selinDevrez'
update CUSTOMERS set CITY='Adana' , TELNR='5531694562' Where NaMESURNAME='selimBeraDevrez'

--Truncate Komutu silme iþlemi yapýlýðýnda Otomatik artanýda sýfýrlar 
truncate TABLE CUSTOMERS  

--And Komutu VE or komutu
select * from CUSTOMERS where CITY='istanbul' and TOWN='KADIKÖY' and NAME_='Hasan'
select * from CUSTOMERS Where CITY='ÝSTANBUL' or CITY='ANKARA'

--Satýr Tekrarýnýn Önüne Geçme 
select DISTINCT CITY,TOWN from CUSTOMERS WHERE CITY='ÝSTANBUL'

--OrderBy Listeleme Yapýlýr
select * from CUSTOMERS where cýty='istanbul'order by cýty,town
select cýty,dýstrýct,sum(TOTALPRICE) from sales group by cýty,dýstrýct order by cýty,dýstrýct 

--Top Komutu
select top 100 * from CUSTOMERS order by CITY,NAMESURNAME


---------------------------------------------------------------------------------

-- AGGREGATE FUNCTIONS (SUM MIN MAX AVG COUNT)

select count(*) from sales
select MIN(amount) from sales
select MAX(amount) from sales
select SUM(amount) from sales  
select AVG(amount) from sales

select count(*),MIN(amount),MAX(amount),SUM(amount),AVG(amount) from sales
select count(*),MIN(amount),MAX(amount),SUM(amount),AVG(amount) from sales where cýty='izmir'

select count(*),MIN(totalprýce),MAX(totalprýce),SUM(totalprýce),AVG(totalprýce) from sales
select count(*),MIN(totalprýce),MAX(totalprýce),SUM(totalprýce),AVG(totalprýce) from sales where cýty='istanbul'

----------------------------------------------------------------------------------------------

--GroupBy 
select cýty,MIN(totalprýce) as EnAzSatýþTL ,MAX(totalprýce) as EnFazlaSatýþTL ,SUM(totalprýce) as ToplamSatýþ ,AVG(totalprýce) as BirimBaþýnaDüþenMiktarTL from sales group by cýty order by MIN(TOTALPRICE) 
select cýty,MIN(totalprýce) from sales group by cýty order by MIN(TOTALPRICE) 
select cýty,SUM(totalprýce) from sales group by cýty order by SUM(TOTALPRICE) desc
select top 10 cýty,sum(totalprýce) as ToplmamSatýþ from sales group by cýty order by sum(TOTALPRICE) desc

-- Group by Örnekler
	-- Bir maðazanýn günlük bazlý satýþ rakamlarýný geritirme
	select * from sales
	-- 1) YÖNTEM 
	select convert(Date,DATE_) as Date2 ,* from sales where cýty='ankara' order by DATE_  -- Sanal Olusturulmus bir date
	select cýty,date2,sum(totalprýce) as ToplamSatýþ from sales where cýty='Ankara' Group By cýty,Date2 order by cýty,Date2
	-- 2) YÖNTEM
	alter table SALES add DATE2 DATE
	update sales set date2=Convert(date,DATE_
	select cýty,date2,sum(totalprýce) as ToplamSatýþ from sales where cýty='Ankara' Group By cýty,Date2 order by cýty,Date2
	select cýty,date2,sum(totalprýce) as ToplamSatýþ from sales where cýty='Ankara' Group By cýty,Date2 order by sum(TOTALPRICE) desc

	-- Bir günün maðaza bazlý satýþ rakamlarýný getirme
	select date2,cýty,dýstrýct,sum(TOTALPRICE) as ToplamSatýþ from sales where DATE2='2019-01-01' group by DATE2,cýty,dýstrýct order by DATE2,cýty
	select date2,cýty,sum(totalprýce) as ToplamSatýþ from SALES where DATE2='2019-01-01' group by date2,cýty order by sum(TOTALPRICE) -- azdan çoka 
	select date2,cýty,sum(totalprýce) as ToplamSatýþ from SALES where DATE2='2019-01-01' group by date2,cýty order by sum(TOTALPRICE) desc -- çoktan aza

	-- Maðazalarýn aylara göre satýþ rakamlarý
    -- Aylar Tablomuz olmadýðýndan bizim eklememiz gerekiyor
	alter table sales add MONTHNAME_ varchar(50)
	update sales set MONTHNAME_='01.OCAK' where datepart(MONTH,date2)=1
	update sales set MONTHNAME_='02.ÞUBAT' where datepart(MONTH,date2)=2
	update sales set MONTHNAME_='03.MART' where datepart(MONTH,date2)=3
	update sales set MONTHNAME_='04.NÝSAN' where datepart(MONTH,date2)=4
	update sales set MONTHNAME_='05.MAYIS' where datepart(MONTH,date2)=5
	update sales set MONTHNAME_='06.HAZÝRAN' where datepart(MONTH,date2)=6
	update sales set MONTHNAME_='07.TEMMMUZ' where datepart(MONTH,date2)=7
	update sales set MONTHNAME_='08.AÐUSTOS' where datepart(MONTH,date2)=8
	update sales set MONTHNAME_='09.EYLÜL' where datepart(MONTH,date2)=9
	update sales set MONTHNAME_='10.EKÝM' where datepart(MONTH,date2)=10
	update sales set MONTHNAME_='11.KASIM' where datepart(MONTH,date2)=11
	update sales set MONTHNAME_='12.ARALIK' where datepart(MONTH,date2)=12
	select CITY,MONTHNAME_, SUM(TOTALPRICE) AS TOPLAMSATIÞ FROM SALES GROUP BY CITY,MONTHNAME_ ORDER BY CITY,MONTHNAME_
	select MONTHNAME_,CITY, SUM(TOTALPRICE) AS TOPLAMSATIÞ FROM SALES GROUP BY MONTHNAME_,CITY ORDER BY MONTHNAME_,SUM(TOTALPRICE) DESC

	-- Ürün Kategorilerine göre satýþ rakamlarýnýný getirme
	select  category1,category2,category3,category4,sum(TOTALPRICE) as TOPLAMSATIÞ, count(*) as TOPLAMSATIR , sum(amount) as ADETSATIÞI from sales group by category1,category2,category3,category4 order by category1,category2,category3,category4
	select category1,CATEGORY2,CATEGORY3,CATEGORY4,sum(TOTALPRICE) as ToplamSatýþ from sales where CATEGORY1='balýk' group by category1,CATEGORY2,CATEGORY3,CATEGORY4 order by sum(TOTALPRICE) desc

	-- Maðazalararýn müþteri sayýlarýný getirme 
	select * from SALES
	select cýty,count(DISTINCT CUSTOMERNAME) as TekilMüþteri ,count(DISTINCT fýcheno) as MüþteriSayýsý, count(*) as  ToplamFiþSayýsý from sales where MONTHNAME_='01.ocak'group by cýty order by cýty

	-- Belli bir cirounun üzerine satýþ yapan maðzalarý getirme 
	select cýty,sum(TOTALPRICE) as ToplamSatýþSayýsý ,count(DISTINCT CUSTOMERNAME) as TekilMüþteriSayýsý from sales group by cýty having sum(TOTALPRICE)>40000 order by sum(TOTALPRICE) desc


-- Ýki tablodaki Verileri Birlerþtirme  (PK_FK)
	use ETRADE4

select USERS .*, ADDRESS.ADDRESSTEXT from USERS,ADDRESS where USERS.ID=ADDRESS.USERID and USERS.ID=1
select U.NAMESURNAME AS AD_SOYAD ,U.EMAIL AS MAÝL_ADRESÝ,U.GENDER AS CÝNSÝYET ,U.BIRTHDATE AS DOÐUM_TARÝHÝ, A.ADDRESSTEXT AS AÇIK_ADRES from USERS U , ADDRESS A where U.ID=A.USERID and U.ID=4
select U.NAMESURNAME as AD_SOYAD ,U.EMAIL as MAÝL_ADRESÝ ,U.GENDER as CÝNSÝYET,U.BIRTHDATE as DOGUM_GUNU,C.COUNTRY as ULKE,CT.CITY as SEHIR,T.TOWN as ÝLCE,A.ADDRESSTEXT from USERS U , ADDRESS A , COUNTRIES C , CITIES CT , TOWNS T WHERE C.ID=A.COUNTRYID AND C.ID=A.COUNTRYID AND T.ID=A.COUNTRYID and ct.ID=A.CITYID and ct.CITY like 'AÐRI' order by U.NAMESURNAME

select  DISTINCT USERS.NAMESURNAME as TOPLAM_KISI_SAYISI from USERS ORDER BY USERS.NAMESURNAME
select U.NAMESURNAME from USERS U , ADDRESS A , COUNTRIES C , CITIES CT , TOWNS T WHERE U.ID=A.USERID AND C.ID=A.COUNTRYID AND CT.ID=A.CITYID AND T.ID=A.TOWNID ORDER BY U.NAMESURNAME
select U.NAMESURNAME,COUNT(DISTINCT A.ID) AS ADRES_SAYISI, COUNT(DISTINCT CNT.ID) AS ÜLKE_SAYISI , COUNT(DISTINCT CT.ID) AS SEHÝR_SAYISI from USERS U , ADDRESS A , COUNTRIES CNT, CITIES CT, TOWNS T, DISTRICTS D WHERE U.ID=A.USERID AND CNT.ID=A.COUNTRYID AND CT.ID=A.CITYID AND T.ID=A.TOWNID AND D.ID=DISTRICTID GROUP BY U.NAMESURNAME ORDER BY U.NAMESURNAME

SELECT CT.CITY,COUNT(U.ID) AS KULLANICI_SAYISI,COUNT(DISTINCT D.DISTRICT) AS ILCE_SAYISI FROM USERS U,ADDRESS A, COUNTRIES CNT, CITIES CT, TOWNS T, DISTRICTS D WHERE U.ID=A.USERID AND CNT.ID=A.COUNTRYID AND CT.ID=A.CITYID AND T.ID=A.TOWNID AND D.ID=DISTRICTID GROUP BY CT.CITY ORDER BY CT.CITY


-- JOÝN KULLANIMI 

--
SELECT U.ID , U.NAMESURNAME , CNT.COUNTRY , A.ADDRESSTEXT FROM USERS U 
JOIN ADDRESS A ON A.USERID=U.ID
JOIN COUNTRIES CNT ON A.COUNTRYID=CNT.ID
JOIN CITIES CT ON A.CITYID=CT.CITY
JOIN TOWNS T ON A.TOWNID=T.ID
JOIN DISTRICTS D ON A.DISTRICTID=D.ID 
--


SELECT U.NAMESURNAME , CNT.COUNTRY , CT.CITY , T.TOWN , A.ADDRESSTEXT FROM USERS U JOIN ADDRESS A ON A.USERID=U.ID
JOIN COUNTRIES CNT ON A.COUNTRYID=CNT.ID
JOIN CITIES CT ON A.CITYID=CT.ID
JOIN TOWNS T ON A.TOWNID=T.ID
JOIN DISTRICTS D ON A.DISTRICTID=D.ID
ORDER BY CT.CITY


-- LEFT - RIGHT - FULL 
SELECT U.ID,U.NAMESURNAME , A.ADDRESSTEXT from USERS U left join ADDRESS A ON A.USERID=U.ID
SELECT U.ID,U.NAMESURNAME , A.ADDRESSTEXT from USERS U right join ADDRESS A ON A.USERID=U.ID
SELECT U.ID,U.NAMESURNAME , A.ADDRESSTEXT from USERS U full join ADDRESS A ON A.USERID=U.ID

SELECT U.USERNAME_ AS KULLANCI_ADI , U.NAMESURNAME AS AD_SOYAD , CT.CITY AS ÝL , T.TOWN AS ÝLÇE , D.DISTRICT AS SEMT_MAHALLE , A.ADDRESSTEXT AS AÇIK_ADRES , O.ID AS SÝPARÝÞ_ID , O.DATE_ AS TARÝH , O.TOTALPRICE AS TOPLAM_TUTAR , P.DATE_ AS ÖDEME_TARÝHÝ , P.APPROVECODE AS BANKA_ONAY_KODU , I.DATE_ AS FATURA_TARÝHÝ , I.CARGOFICHENO AS KARGO_FÝÞÝ , ITM.ITEMCODE AS ÜRÜN_KOD , ITM.ITEMNAME AS ÜRÜN_AD , OD.AMOUNT AS ÜRÜN_MÝKTARI , OD.UNITPRICE AS BÝRÝM_FÝYATI , OD.LINETOTAL AS SATIR_TOPLAMI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN COUNTRIES CNT ON A.COUNTRYID=CNT.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN TOWNS T ON A.TOWNID=T.ID
INNER JOIN DISTRICTS D ON A.DISTRICTID=D.ID
INNER JOIN PAYMENTS P ON O.ID=P.ORDERID
INNER JOIN INVOICES I ON I.ORDERID=O.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID


-- ÞEHÝRLERE GÖRE TOPLAM VERÝLEN SÝPARÝÞ MÝKTARLARI 
	-- GEREKENLER 
		-- SEHÝR ADI 
		-- TOPLAM SÝPARÝÞ TUTARI
		-- TOPLAM SÝPARÝS ADET
		-- TOPLAM SÝPARÝS SAYISI

SELECT * FROM ORDERS
SELECT * FROM ORDERDETAILS

SELECT CT.CITY  AS SEHÝR_ADI , SUM(OD.LINETOTAL) AS TOPLAM_SÝPARÝÞ_TUTARI , SUM(AMOUNT) AS TOPLAM_SÝPARÝS_ADET , COUNT(OD.ID) AS TOPLAM_SÝPARÝS_SAYISI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
--WHERE CT.CITY LIKE 'ÝSTANBUL'
GROUP BY CT.CITY
ORDER BY SUM(OD.AMOUNT) DESC
-- ORDER BY 2 DESC


SELECT CT.CITY  AS SEHÝR_ADI , SUM(OD.LINETOTAL) AS TOPLAM_SÝPARÝÞ_TUTARI , SUM(AMOUNT) AS TOPLAM_SÝPARÝS_ADET , COUNT(OD.ID) AS TOPLAM_SÝPARÝS_SAYISI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN COUNTRIES CNT ON A.COUNTRYID=CNT.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN TOWNS T ON A.TOWNID=T.ID
INNER JOIN DISTRICTS D ON A.DISTRICTID=D.ID
INNER JOIN PAYMENTS P ON O.ID=P.ORDERID
INNER JOIN INVOICES I ON I.ORDERID=O.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID
--WHERE CT.CITY LIKE 'ÝSTANBUL'
GROUP BY CT.CITY

-- ÜRÜNÜN ÞEHÝR VE KATEGORÝLERÝNE GÖRE DAÐILIMI 
SELECT CT.CITY AS SEHÝR_ADI , ITM.CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4 , SUM(OD.LINETOTAL) AS TOPLAM_SÝPARÝÞ_TUTARI , SUM(AMOUNT) AS TOPLAM_SÝPARÝS_ADET , COUNT(OD.ID) AS TOPLAM_SÝPARÝS_SAYISI , SUM(OD.LINETOTAL) / SUM(OD.AMOUNT) AS ORTALAMA_BÝRÝM_FÝYATI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID
GROUP BY CT.CITY,CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY 6 DESC

-- ÜRÜNÜN (YIL TARÝH) - (AY TARÝH ) - TARÝH - SEHÝR - KATEGORÝNE - GÖRE DAÐILIMI

SELECT DATEPART(YEAR,DATE_) AS YIL , DATEPART(MONTH,DATE_) AS AY, CASE WHEN DATEPART(MONTH,DATE_)=1 THEN 'OCAK' WHEN DATEPART(MONTH,DATE_)=2 THEN 'ÞUBAT' WHEN DATEPART(MONTH,DATE_)=3 THEN 'MART' WHEN DATEPART(MONTH,DATE_)=4 THEN 'NÝSAN' WHEN DATEPART(MONTH,DATE_)=5 THEN 'MAYIS' WHEN DATEPART(MONTH,DATE_)=6 THEN 'HAZÝRAN' WHEN DATEPART(MONTH,DATE_)=7 THEN 'TEMMUZ' WHEN DATEPART(MONTH,DATE_)=8 THEN 'AÐUSTOS' WHEN DATEPART(MONTH,DATE_)=9 THEN 'EYLÜL' WHEN DATEPART(MONTH,DATE_)=10 THEN 'EKÝM' WHEN DATEPART(MONTH,DATE_)=11 THEN 'KASIM' WHEN DATEPART(MONTH,DATE_)=12 THEN 'ARALIK' END AS AYLAR, CONVERT(DATE,DATE_) AS TARÝH, CT.CITY AS SEHÝR_ADI , ITM.CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4 , SUM(OD.LINETOTAL) AS TOPLAM_SÝPARÝÞ_TUTARI , SUM(AMOUNT) AS TOPLAM_SÝPARÝS_ADET , COUNT(OD.ID) AS TOPLAM_SÝPARÝS_SAYISI , SUM(OD.LINETOTAL) / SUM(OD.AMOUNT) AS ORTALAMA_BÝRÝM_FÝYATI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID
GROUP BY CT.CITY,CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4,DATE_
ORDER BY 5,10 DESC

 -- ÖDEME TÜRÜNE GÖRE DAÐILIM 

SELECT DATEPART(YEAR,DATE_) AS YIL , DATEPART(MONTH,DATE_) AS AYLAR , CASE WHEN P.PAYMENTTYPE=1 THEN 'KREDÝ-KARTI' WHEN P.PAYMENTTYPE=2 THEN 'BANKA_HAVALESÝ' END AS ÖDEME_TÜRÜ_AÇIKLAMA , P.PAYMENTTOTAL FROM PAYMENTS P 


 -- ORTALAMA TESLÝMANT SÜRESÝNÝ BULMA 
 
SELECT MIN(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_TÜRÜNDE_EN_KISA_TESLÝMAT_SÜRESÝ, MAX(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_TÜRÜNDE_EN_UZUN_TESLÝMAT_SÜRESÝ ,AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_TÜRÜNDE_ORTALAMA_TESLÝMAT_SÜRESÝ FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN INVOICES I ON I.ORDERID=O.ID

SELECT 
O.ID,
O.DATE_,
I.DATE_,
(DATEDIFF(HOUR,O.DATE_,I.DATE_))
FROM ORDERS O 
INNER JOIN INVOICES I ON I.ORDERID=O.ID


SELECT 
U.NAMESURNAME,
CT.CITY,
T.TOWN,
D.DISTRICT,
MIN(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_TÜRÜNDE_EN_KISA_TESLÝMAT_SÜRESÝ ,
MAX(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_TÜRÜNDE_EN_UZUN_TESLÝMAT_SÜRESÝ ,
AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_TÜRÜNDE_ORTALAMA_TESLÝMAT_SÜRESÝ,
OD.AMOUNT AS ÜRÜN_MÝKTARI
FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN TOWNS T ON A.TOWNID=T.ID
INNER JOIN DISTRICTS D ON A.DISTRICTID=D.ID
INNER JOIN INVOICES I ON I.ORDERID=O.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
GROUP BY U.NAMESURNAME,CT.CITY,T.TOWN,D.DISTRICT,OD.AMOUNT
ORDER BY 7 DESC ,2 


 -- SUBQUERY KULLANIMI
	-- ÜRÜNLERÝN FÝYAT ANALÝZÝ

SELECT ITM.ITEMCODE AS ÜRÜN_KODU , ITM.ITEMNAME AS ÜRÜN_AD ,
(SELECT MIN(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_DÜÞÜK_FÝYAT,
(SELECT MAX(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_YÜKSEK_FÝYAT,
(SELECT AVG(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ORTALAMA_FÝYAT,
(SELECT SUM(AMOUNT) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_ADET_SAYISI,
(SELECT SUM(LINETOTAL) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_TUTAR
FROM ITEMS ITM
WHERE ITM.ITEMCODE=10983
---------------------------------------------------------------------------------
-- 1)												-- JOIN ÝLE YAPIMI 
SELECT ITM.ITEMNAME AS ÜRÜN_AD, 
MIN(OD.UNITPRICE) AS EN_DÜÞÜK_FÝYAT,
MAX(OD.UNITPRICE) AS EN_YÜKSEK_FÝYAT,
AVG(OD.UNITPRICE) AS ORTALAMA_FÝYAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
SUM(OD.AMOUNT) AS TOPLAM_MÝKTAR
FROM ORDERS O
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
GROUP BY ITM.ITEMNAME

------------------------------------------------------

-- 2)
SELECT ITM.ITEMNAME AS ÜRÜN_AD, 
MIN(OD.UNITPRICE) AS EN_DÜÞÜK_FÝYAT,
MAX(OD.UNITPRICE) AS EN_YÜKSEK_FÝYAT,
AVG(OD.UNITPRICE) AS ORTALAMA_FÝYAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
OD.AMOUNT AS TOPLAM_MÝKTAR
FROM ORDERS O
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
GROUP BY ITM.ITEMNAME,OD.AMOUNT

------------------------------------------------------

--3)
SELECT  ITM.ITEMNAME AS ÜRÜN_AD, 
MIN(OD.UNITPRICE) AS EN_DÜÞÜK_FÝYAT,
MAX(OD.UNITPRICE) AS EN_YÜKSEK_FÝYAT,
AVG(OD.UNITPRICE) AS ORTALAMA_FÝYAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
OD.AMOUNT AS TOPLAM_MÝKTAR
FROM ORDERS O
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
WHERE ITM.ITEMNAME='OYUNCAK PATEL RENK CINGIRAK KARMASI  '
GROUP BY ITM.ITEMNAME , OD.AMOUNT

--3.1)
SELECT CT.CITY, ITM.ITEMNAME AS ÜRÜN_AD, 
MIN(OD.UNITPRICE) AS EN_DÜÞÜK_FÝYAT,
MAX(OD.UNITPRICE) AS EN_YÜKSEK_FÝYAT,
AVG(OD.UNITPRICE) AS ORTALAMA_FÝYAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
OD.AMOUNT AS TOPLAM_MÝKTAR
FROM ORDERS O
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
WHERE ITM.ITEMNAME='OYUNCAK PATEL RENK CINGIRAK KARMASI  '
GROUP BY CT.CITY , ITM.ITEMNAME , OD.AMOUNT


---------------------------------------------------------------------------------------------------

	--ÜRÜNLERÝN FÝYAT ANALÝZÝ / EN ÇOK HANGÝ AY SATMIÞ 

	-- 1)
SELECT SUM(AMOUNT) FROM ORDERDETAILS OD
WHERE OD.ITEMID=1
	-- 2)
SELECT DATEPART(MONTH,DATE_) AS AYLAR , SUM(AMOUNT) AS SATILAN_ÜRÜN FROM ORDERDETAILS OD
INNER JOIN ORDERS O ON OD.ORDERID=O.ID
WHERE OD.ITEMID=1
GROUP BY DATEPART(MONTH,DATE_)
	-- 3)
SELECT TOP 1 DATEPART(MONTH,DATE_) AS AYLAR , SUM(AMOUNT) AS SATILAN_ÜRÜN FROM ORDERDETAILS OD
INNER JOIN ORDERS O ON OD.ORDERID=O.ID
WHERE OD.ITEMID=1
GROUP BY DATEPART(MONTH,DATE_)
ORDER BY SUM(AMOUNT) DESC
	-- 4)
SELECT TOP 1 DATEPART(MONTH,DATE_) AS AYLAR FROM ORDERDETAILS OD
INNER JOIN ORDERS O ON OD.ORDERID=O.ID
WHERE OD.ITEMID=1
GROUP BY DATEPART(MONTH,DATE_)
ORDER BY SUM(AMOUNT) DESC
	--5)
SELECT TOP 1 DATEPART(MONTH,DATE_) AS AYLAR FROM ORDERDETAILS OD
INNER JOIN ORDERS O ON OD.ORDERID=O.ID
WHERE OD.ITEMID=ITM.ID
GROUP BY DATEPART(MONTH,DATE_)
ORDER BY SUM(AMOUNT) DESC


SELECT ITM.ITEMCODE AS ÜRÜN_KODU , ITM.ITEMNAME AS ÜRÜN_AD ,
(SELECT MIN(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_DÜÞÜK_FÝYAT,
(SELECT MAX(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_YÜKSEK_FÝYAT,
(SELECT AVG(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ORTALAMA_FÝYAT,
(SELECT SUM(AMOUNT) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_ADET_SAYISI,
(SELECT SUM(LINETOTAL) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_TUTAR,
(SELECT TOP 1 DATEPART(MONTH,O.DATE_) AS AY 
	FROM ORDERDETAILS OD 
	INNER JOIN ORDERS O ON OD.ORDERID=O.ID
	WHERE OD.ITEMID=ITM.ID
	GROUP BY DATEPART(MONTH,O.DATE_)
	ORDER BY SUM(AMOUNT) DESC
)AS  EN_ÇOK_SATILAN_AY
FROM ITEMS ITM 
ORDER BY 7 DESC

-- Lower,Upper,Reverse,Peplicate
select LOWER('Selim') -- bütün harfleri küçük yapar
select UPPER('Selim') -- bütün harfleri büyük yapar
select REVERSE('Selim') -- yazýlan metni tersten yazar
select REPLICATE('0',10) --> soldaki týrnak içindeki veriler ne yazdýrmak istediðimizi
						 --> saðdaki týrnaksýz veriler ise kaç defa yazdýmak istedðimizi saðlar

select *,REPLICATE('0',8-LEN(sýrano))+CONVERT(varchar,sýrano) from test
update test set sýrano2=REPLICATE('0',8-LEN(sýrano))+CONVERT(varchar,sýrano)

-- replace (stirg bir ifadeyi bul ve yeri string veriyi ekle)
select 'selim bera'
select REPLACE('selim bera','bera','bera devrez')
			  --> 1.Týrnak neyi bulucam
			  --> 2.Týrnak neyi deðiþtiricem 
			  --> 3.Týrnak ne ekleyeceðim 


--> DECLARE ile deðiþken tanýmlayabiliriz 
	--> DECLARE @Yenideðiþken as varchar(Max)

	--> set @Yenideðiþken = 'Bir yazýyý þekil, anlatým ve noktalama 
	--						özellikleriyle oluþturan kelimelerin bütününe 
	--						metin adý verilir. Diðer bir ifadeyle metin, 
	--						iletiþim kurmak için oluþturulan cümleler topluluðudur. 
	--						Sözlü ya da yazýlý iletiþim için üretilen anlamlý yapýdýr. 
	--						Yazar, iletmek istediði mesajý metin aracýlýðýyla ifade eder.
	--						Bir metin, aralarýnda anlam, anlatým bakýmýndan iliþki ve bütünlük bulunan paragraflardan oluþur. 
	--						Ýyi kurgulanmýþ bir metinde, her paragraf bir düþünce birimidir. Metindeki paragraf sayýsý, 
	--						o metnin içerdiði düþünce sayýsýný verir. Bunun nedeniyse her düþüncenin bir paragrafta tam olarak ortaya konmasýdýr. 
	--						Sözcükler seslerden, cümleler sözcüklerden, paragraflar ise cümlelerden oluþur.'
	
	set @yenideðiþken=REPLACE(@yenideðiþken,'yazýyý','metni')
	select LEN(@yenideðiþken)
	set @yenideðiþken=REPLACE(@yenideðiþken,'bir','')
	select LEN(@yenideðiþken)
	select @yenideðiþken

	-- 2. yol 
		
		declare @len1 as int
		set @len1=LEN(@yenideðiþken)
		declare @len2 as int
		set @yenideðiþken=REPLACE(@yenideðiþken,'bir','')
		set @len2=LEN(@yenideðiþlen)
		select (@len1-@len2)/LEN('bir')








    






