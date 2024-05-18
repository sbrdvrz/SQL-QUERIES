use ETRADE2

-- data manipilasyon komutlar� 
	-- Select - Update - Delete - Insert - Truncate
--Veritaban� manipilasyonlar�
	--Create Alter Drop

select * from customers where b�rthdate between '19780101' and  '20041230' order by b�rthdate,c�ty

select * from customers where namesurname Like '%asd'
select * from customers where namesurname Like 'asd%'
select * from customers where namesurname Like '%asd%'

select * from customers where namesurname Not Like '%asd'
select * from customers where namesurname Not Like 'asd%'
select * from customers where namesurname Not Like '%asd%'



select * from CUSTOMERS

-- �nsert , Delete VE Update Komutu
insert into CUSTOMERS values('selimDevrez','E','2004-02-05','�orum','Karg�','05522193919','Selim','Devrez')
insert into CUSTOMERS (NAMESURNAME,GENDER,BIRTHDATE,CITY,TOWN,TELNR,NAME_,SURNAME) values('selimBeraDevrez','E','2004-02-05','�stanbul','Pendik','05522193919','SelimBera','Devrez')
delete from CUSTOMERS Where NAMESURNAME='selinDevrez'
update CUSTOMERS set CITY='Adana' , TELNR='5531694562' Where NaMESURNAME='selimBeraDevrez'

--Truncate Komutu silme i�lemi yap�l���nda Otomatik artan�da s�f�rlar 
truncate TABLE CUSTOMERS  

--And Komutu VE or komutu
select * from CUSTOMERS where CITY='istanbul' and TOWN='KADIK�Y' and NAME_='Hasan'
select * from CUSTOMERS Where CITY='�STANBUL' or CITY='ANKARA'

--Sat�r Tekrar�n�n �n�ne Ge�me 
select DISTINCT CITY,TOWN from CUSTOMERS WHERE CITY='�STANBUL'

--OrderBy Listeleme Yap�l�r
select * from CUSTOMERS where c�ty='istanbul'order by c�ty,town
select c�ty,d�str�ct,sum(TOTALPRICE) from sales group by c�ty,d�str�ct order by c�ty,d�str�ct 

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
select count(*),MIN(amount),MAX(amount),SUM(amount),AVG(amount) from sales where c�ty='izmir'

select count(*),MIN(totalpr�ce),MAX(totalpr�ce),SUM(totalpr�ce),AVG(totalpr�ce) from sales
select count(*),MIN(totalpr�ce),MAX(totalpr�ce),SUM(totalpr�ce),AVG(totalpr�ce) from sales where c�ty='istanbul'

----------------------------------------------------------------------------------------------

--GroupBy 
select c�ty,MIN(totalpr�ce) as EnAzSat��TL ,MAX(totalpr�ce) as EnFazlaSat��TL ,SUM(totalpr�ce) as ToplamSat�� ,AVG(totalpr�ce) as BirimBa��naD��enMiktarTL from sales group by c�ty order by MIN(TOTALPRICE) 
select c�ty,MIN(totalpr�ce) from sales group by c�ty order by MIN(TOTALPRICE) 
select c�ty,SUM(totalpr�ce) from sales group by c�ty order by SUM(TOTALPRICE) desc
select top 10 c�ty,sum(totalpr�ce) as ToplmamSat�� from sales group by c�ty order by sum(TOTALPRICE) desc

-- Group by �rnekler
	-- Bir ma�azan�n g�nl�k bazl� sat�� rakamlar�n� geritirme
	select * from sales
	-- 1) Y�NTEM 
	select convert(Date,DATE_) as Date2 ,* from sales where c�ty='ankara' order by DATE_  -- Sanal Olusturulmus bir date
	select c�ty,date2,sum(totalpr�ce) as ToplamSat�� from sales where c�ty='Ankara' Group By c�ty,Date2 order by c�ty,Date2
	-- 2) Y�NTEM
	alter table SALES add DATE2 DATE
	update sales set date2=Convert(date,DATE_
	select c�ty,date2,sum(totalpr�ce) as ToplamSat�� from sales where c�ty='Ankara' Group By c�ty,Date2 order by c�ty,Date2
	select c�ty,date2,sum(totalpr�ce) as ToplamSat�� from sales where c�ty='Ankara' Group By c�ty,Date2 order by sum(TOTALPRICE) desc

	-- Bir g�n�n ma�aza bazl� sat�� rakamlar�n� getirme
	select date2,c�ty,d�str�ct,sum(TOTALPRICE) as ToplamSat�� from sales where DATE2='2019-01-01' group by DATE2,c�ty,d�str�ct order by DATE2,c�ty
	select date2,c�ty,sum(totalpr�ce) as ToplamSat�� from SALES where DATE2='2019-01-01' group by date2,c�ty order by sum(TOTALPRICE) -- azdan �oka 
	select date2,c�ty,sum(totalpr�ce) as ToplamSat�� from SALES where DATE2='2019-01-01' group by date2,c�ty order by sum(TOTALPRICE) desc -- �oktan aza

	-- Ma�azalar�n aylara g�re sat�� rakamlar�
    -- Aylar Tablomuz olmad���ndan bizim eklememiz gerekiyor
	alter table sales add MONTHNAME_ varchar(50)
	update sales set MONTHNAME_='01.OCAK' where datepart(MONTH,date2)=1
	update sales set MONTHNAME_='02.�UBAT' where datepart(MONTH,date2)=2
	update sales set MONTHNAME_='03.MART' where datepart(MONTH,date2)=3
	update sales set MONTHNAME_='04.N�SAN' where datepart(MONTH,date2)=4
	update sales set MONTHNAME_='05.MAYIS' where datepart(MONTH,date2)=5
	update sales set MONTHNAME_='06.HAZ�RAN' where datepart(MONTH,date2)=6
	update sales set MONTHNAME_='07.TEMMMUZ' where datepart(MONTH,date2)=7
	update sales set MONTHNAME_='08.A�USTOS' where datepart(MONTH,date2)=8
	update sales set MONTHNAME_='09.EYL�L' where datepart(MONTH,date2)=9
	update sales set MONTHNAME_='10.EK�M' where datepart(MONTH,date2)=10
	update sales set MONTHNAME_='11.KASIM' where datepart(MONTH,date2)=11
	update sales set MONTHNAME_='12.ARALIK' where datepart(MONTH,date2)=12
	select CITY,MONTHNAME_, SUM(TOTALPRICE) AS TOPLAMSATI� FROM SALES GROUP BY CITY,MONTHNAME_ ORDER BY CITY,MONTHNAME_
	select MONTHNAME_,CITY, SUM(TOTALPRICE) AS TOPLAMSATI� FROM SALES GROUP BY MONTHNAME_,CITY ORDER BY MONTHNAME_,SUM(TOTALPRICE) DESC

	-- �r�n Kategorilerine g�re sat�� rakamlar�n�n� getirme
	select  category1,category2,category3,category4,sum(TOTALPRICE) as TOPLAMSATI�, count(*) as TOPLAMSATIR , sum(amount) as ADETSATI�I from sales group by category1,category2,category3,category4 order by category1,category2,category3,category4
	select category1,CATEGORY2,CATEGORY3,CATEGORY4,sum(TOTALPRICE) as ToplamSat�� from sales where CATEGORY1='bal�k' group by category1,CATEGORY2,CATEGORY3,CATEGORY4 order by sum(TOTALPRICE) desc

	-- Ma�azalarar�n m��teri say�lar�n� getirme 
	select * from SALES
	select c�ty,count(DISTINCT CUSTOMERNAME) as TekilM��teri ,count(DISTINCT f�cheno) as M��teriSay�s�, count(*) as  ToplamFi�Say�s� from sales where MONTHNAME_='01.ocak'group by c�ty order by c�ty

	-- Belli bir cirounun �zerine sat�� yapan ma�zalar� getirme 
	select c�ty,sum(TOTALPRICE) as ToplamSat��Say�s� ,count(DISTINCT CUSTOMERNAME) as TekilM��teriSay�s� from sales group by c�ty having sum(TOTALPRICE)>40000 order by sum(TOTALPRICE) desc


-- �ki tablodaki Verileri Birler�tirme  (PK_FK)
	use ETRADE4

select USERS .*, ADDRESS.ADDRESSTEXT from USERS,ADDRESS where USERS.ID=ADDRESS.USERID and USERS.ID=1
select U.NAMESURNAME AS AD_SOYAD ,U.EMAIL AS MA�L_ADRES�,U.GENDER AS C�NS�YET ,U.BIRTHDATE AS DO�UM_TAR�H�, A.ADDRESSTEXT AS A�IK_ADRES from USERS U , ADDRESS A where U.ID=A.USERID and U.ID=4
select U.NAMESURNAME as AD_SOYAD ,U.EMAIL as MA�L_ADRES� ,U.GENDER as C�NS�YET,U.BIRTHDATE as DOGUM_GUNU,C.COUNTRY as ULKE,CT.CITY as SEHIR,T.TOWN as �LCE,A.ADDRESSTEXT from USERS U , ADDRESS A , COUNTRIES C , CITIES CT , TOWNS T WHERE C.ID=A.COUNTRYID AND C.ID=A.COUNTRYID AND T.ID=A.COUNTRYID and ct.ID=A.CITYID and ct.CITY like 'A�RI' order by U.NAMESURNAME

select  DISTINCT USERS.NAMESURNAME as TOPLAM_KISI_SAYISI from USERS ORDER BY USERS.NAMESURNAME
select U.NAMESURNAME from USERS U , ADDRESS A , COUNTRIES C , CITIES CT , TOWNS T WHERE U.ID=A.USERID AND C.ID=A.COUNTRYID AND CT.ID=A.CITYID AND T.ID=A.TOWNID ORDER BY U.NAMESURNAME
select U.NAMESURNAME,COUNT(DISTINCT A.ID) AS ADRES_SAYISI, COUNT(DISTINCT CNT.ID) AS �LKE_SAYISI , COUNT(DISTINCT CT.ID) AS SEH�R_SAYISI from USERS U , ADDRESS A , COUNTRIES CNT, CITIES CT, TOWNS T, DISTRICTS D WHERE U.ID=A.USERID AND CNT.ID=A.COUNTRYID AND CT.ID=A.CITYID AND T.ID=A.TOWNID AND D.ID=DISTRICTID GROUP BY U.NAMESURNAME ORDER BY U.NAMESURNAME

SELECT CT.CITY,COUNT(U.ID) AS KULLANICI_SAYISI,COUNT(DISTINCT D.DISTRICT) AS ILCE_SAYISI FROM USERS U,ADDRESS A, COUNTRIES CNT, CITIES CT, TOWNS T, DISTRICTS D WHERE U.ID=A.USERID AND CNT.ID=A.COUNTRYID AND CT.ID=A.CITYID AND T.ID=A.TOWNID AND D.ID=DISTRICTID GROUP BY CT.CITY ORDER BY CT.CITY


-- JO�N KULLANIMI 

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

SELECT U.USERNAME_ AS KULLANCI_ADI , U.NAMESURNAME AS AD_SOYAD , CT.CITY AS �L , T.TOWN AS �L�E , D.DISTRICT AS SEMT_MAHALLE , A.ADDRESSTEXT AS A�IK_ADRES , O.ID AS S�PAR��_ID , O.DATE_ AS TAR�H , O.TOTALPRICE AS TOPLAM_TUTAR , P.DATE_ AS �DEME_TAR�H� , P.APPROVECODE AS BANKA_ONAY_KODU , I.DATE_ AS FATURA_TAR�H� , I.CARGOFICHENO AS KARGO_F��� , ITM.ITEMCODE AS �R�N_KOD , ITM.ITEMNAME AS �R�N_AD , OD.AMOUNT AS �R�N_M�KTARI , OD.UNITPRICE AS B�R�M_F�YATI , OD.LINETOTAL AS SATIR_TOPLAMI FROM ORDERS O 
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


-- �EH�RLERE G�RE TOPLAM VER�LEN S�PAR�� M�KTARLARI 
	-- GEREKENLER 
		-- SEH�R ADI 
		-- TOPLAM S�PAR�� TUTARI
		-- TOPLAM S�PAR�S ADET
		-- TOPLAM S�PAR�S SAYISI

SELECT * FROM ORDERS
SELECT * FROM ORDERDETAILS

SELECT CT.CITY  AS SEH�R_ADI , SUM(OD.LINETOTAL) AS TOPLAM_S�PAR��_TUTARI , SUM(AMOUNT) AS TOPLAM_S�PAR�S_ADET , COUNT(OD.ID) AS TOPLAM_S�PAR�S_SAYISI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
--WHERE CT.CITY LIKE '�STANBUL'
GROUP BY CT.CITY
ORDER BY SUM(OD.AMOUNT) DESC
-- ORDER BY 2 DESC


SELECT CT.CITY  AS SEH�R_ADI , SUM(OD.LINETOTAL) AS TOPLAM_S�PAR��_TUTARI , SUM(AMOUNT) AS TOPLAM_S�PAR�S_ADET , COUNT(OD.ID) AS TOPLAM_S�PAR�S_SAYISI FROM ORDERS O 
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
--WHERE CT.CITY LIKE '�STANBUL'
GROUP BY CT.CITY

-- �R�N�N �EH�R VE KATEGOR�LER�NE G�RE DA�ILIMI 
SELECT CT.CITY AS SEH�R_ADI , ITM.CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4 , SUM(OD.LINETOTAL) AS TOPLAM_S�PAR��_TUTARI , SUM(AMOUNT) AS TOPLAM_S�PAR�S_ADET , COUNT(OD.ID) AS TOPLAM_S�PAR�S_SAYISI , SUM(OD.LINETOTAL) / SUM(OD.AMOUNT) AS ORTALAMA_B�R�M_F�YATI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID
GROUP BY CT.CITY,CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY 6 DESC

-- �R�N�N (YIL TAR�H) - (AY TAR�H ) - TAR�H - SEH�R - KATEGOR�NE - G�RE DA�ILIMI

SELECT DATEPART(YEAR,DATE_) AS YIL , DATEPART(MONTH,DATE_) AS AY, CASE WHEN DATEPART(MONTH,DATE_)=1 THEN 'OCAK' WHEN DATEPART(MONTH,DATE_)=2 THEN '�UBAT' WHEN DATEPART(MONTH,DATE_)=3 THEN 'MART' WHEN DATEPART(MONTH,DATE_)=4 THEN 'N�SAN' WHEN DATEPART(MONTH,DATE_)=5 THEN 'MAYIS' WHEN DATEPART(MONTH,DATE_)=6 THEN 'HAZ�RAN' WHEN DATEPART(MONTH,DATE_)=7 THEN 'TEMMUZ' WHEN DATEPART(MONTH,DATE_)=8 THEN 'A�USTOS' WHEN DATEPART(MONTH,DATE_)=9 THEN 'EYL�L' WHEN DATEPART(MONTH,DATE_)=10 THEN 'EK�M' WHEN DATEPART(MONTH,DATE_)=11 THEN 'KASIM' WHEN DATEPART(MONTH,DATE_)=12 THEN 'ARALIK' END AS AYLAR, CONVERT(DATE,DATE_) AS TAR�H, CT.CITY AS SEH�R_ADI , ITM.CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4 , SUM(OD.LINETOTAL) AS TOPLAM_S�PAR��_TUTARI , SUM(AMOUNT) AS TOPLAM_S�PAR�S_ADET , COUNT(OD.ID) AS TOPLAM_S�PAR�S_SAYISI , SUM(OD.LINETOTAL) / SUM(OD.AMOUNT) AS ORTALAMA_B�R�M_F�YATI FROM ORDERS O 
INNER JOIN USERS U ON O.USERID=U.ID
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID
GROUP BY CT.CITY,CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4,DATE_
ORDER BY 5,10 DESC

 -- �DEME T�R�NE G�RE DA�ILIM 

SELECT DATEPART(YEAR,DATE_) AS YIL , DATEPART(MONTH,DATE_) AS AYLAR , CASE WHEN P.PAYMENTTYPE=1 THEN 'KRED�-KARTI' WHEN P.PAYMENTTYPE=2 THEN 'BANKA_HAVALES�' END AS �DEME_T�R�_A�IKLAMA , P.PAYMENTTOTAL FROM PAYMENTS P 


 -- ORTALAMA TESL�MANT S�RES�N� BULMA 
 
SELECT MIN(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_T�R�NDE_EN_KISA_TESL�MAT_S�RES�, MAX(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_T�R�NDE_EN_UZUN_TESL�MAT_S�RES� ,AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_T�R�NDE_ORTALAMA_TESL�MAT_S�RES� FROM ORDERS O 
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
MIN(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_T�R�NDE_EN_KISA_TESL�MAT_S�RES� ,
MAX(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_T�R�NDE_EN_UZUN_TESL�MAT_S�RES� ,
AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) AS SAAT_T�R�NDE_ORTALAMA_TESL�MAT_S�RES�,
OD.AMOUNT AS �R�N_M�KTARI
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
	-- �R�NLER�N F�YAT ANAL�Z�

SELECT ITM.ITEMCODE AS �R�N_KODU , ITM.ITEMNAME AS �R�N_AD ,
(SELECT MIN(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_D���K_F�YAT,
(SELECT MAX(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_Y�KSEK_F�YAT,
(SELECT AVG(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ORTALAMA_F�YAT,
(SELECT SUM(AMOUNT) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_ADET_SAYISI,
(SELECT SUM(LINETOTAL) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_TUTAR
FROM ITEMS ITM
WHERE ITM.ITEMCODE=10983
---------------------------------------------------------------------------------
-- 1)												-- JOIN �LE YAPIMI 
SELECT ITM.ITEMNAME AS �R�N_AD, 
MIN(OD.UNITPRICE) AS EN_D���K_F�YAT,
MAX(OD.UNITPRICE) AS EN_Y�KSEK_F�YAT,
AVG(OD.UNITPRICE) AS ORTALAMA_F�YAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
SUM(OD.AMOUNT) AS TOPLAM_M�KTAR
FROM ORDERS O
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
GROUP BY ITM.ITEMNAME

------------------------------------------------------

-- 2)
SELECT ITM.ITEMNAME AS �R�N_AD, 
MIN(OD.UNITPRICE) AS EN_D���K_F�YAT,
MAX(OD.UNITPRICE) AS EN_Y�KSEK_F�YAT,
AVG(OD.UNITPRICE) AS ORTALAMA_F�YAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
OD.AMOUNT AS TOPLAM_M�KTAR
FROM ORDERS O
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
GROUP BY ITM.ITEMNAME,OD.AMOUNT

------------------------------------------------------

--3)
SELECT  ITM.ITEMNAME AS �R�N_AD, 
MIN(OD.UNITPRICE) AS EN_D���K_F�YAT,
MAX(OD.UNITPRICE) AS EN_Y�KSEK_F�YAT,
AVG(OD.UNITPRICE) AS ORTALAMA_F�YAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
OD.AMOUNT AS TOPLAM_M�KTAR
FROM ORDERS O
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
WHERE ITM.ITEMNAME='OYUNCAK PATEL RENK CINGIRAK KARMASI  '
GROUP BY ITM.ITEMNAME , OD.AMOUNT

--3.1)
SELECT CT.CITY, ITM.ITEMNAME AS �R�N_AD, 
MIN(OD.UNITPRICE) AS EN_D���K_F�YAT,
MAX(OD.UNITPRICE) AS EN_Y�KSEK_F�YAT,
AVG(OD.UNITPRICE) AS ORTALAMA_F�YAT,
SUM(OD.LINETOTAL) AS TOPLAM_TUTAR,
OD.AMOUNT AS TOPLAM_M�KTAR
FROM ORDERS O
INNER JOIN ADDRESS A ON O.ADDRESSID=A.ID
INNER JOIN CITIES CT ON A.CITYID=CT.ID
INNER JOIN ORDERDETAILS  OD ON OD.ORDERID=O.ID
INNER JOIN ITEMS ITM ON  OD.ITEMID=ITM.ID
WHERE ITM.ITEMNAME='OYUNCAK PATEL RENK CINGIRAK KARMASI  '
GROUP BY CT.CITY , ITM.ITEMNAME , OD.AMOUNT


---------------------------------------------------------------------------------------------------

	--�R�NLER�N F�YAT ANAL�Z� / EN �OK HANG� AY SATMI� 

	-- 1)
SELECT SUM(AMOUNT) FROM ORDERDETAILS OD
WHERE OD.ITEMID=1
	-- 2)
SELECT DATEPART(MONTH,DATE_) AS AYLAR , SUM(AMOUNT) AS SATILAN_�R�N FROM ORDERDETAILS OD
INNER JOIN ORDERS O ON OD.ORDERID=O.ID
WHERE OD.ITEMID=1
GROUP BY DATEPART(MONTH,DATE_)
	-- 3)
SELECT TOP 1 DATEPART(MONTH,DATE_) AS AYLAR , SUM(AMOUNT) AS SATILAN_�R�N FROM ORDERDETAILS OD
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


SELECT ITM.ITEMCODE AS �R�N_KODU , ITM.ITEMNAME AS �R�N_AD ,
(SELECT MIN(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_D���K_F�YAT,
(SELECT MAX(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS EN_Y�KSEK_F�YAT,
(SELECT AVG(UNITPRICE) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS ORTALAMA_F�YAT,
(SELECT SUM(AMOUNT) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_ADET_SAYISI,
(SELECT SUM(LINETOTAL) FROM ORDERDETAILS WHERE ITEMID=ITM.ID) AS TOPLAM_TUTAR,
(SELECT TOP 1 DATEPART(MONTH,O.DATE_) AS AY 
	FROM ORDERDETAILS OD 
	INNER JOIN ORDERS O ON OD.ORDERID=O.ID
	WHERE OD.ITEMID=ITM.ID
	GROUP BY DATEPART(MONTH,O.DATE_)
	ORDER BY SUM(AMOUNT) DESC
)AS  EN_�OK_SATILAN_AY
FROM ITEMS ITM 
ORDER BY 7 DESC

-- Lower,Upper,Reverse,Peplicate
select LOWER('Selim') -- b�t�n harfleri k���k yapar
select UPPER('Selim') -- b�t�n harfleri b�y�k yapar
select REVERSE('Selim') -- yaz�lan metni tersten yazar
select REPLICATE('0',10) --> soldaki t�rnak i�indeki veriler ne yazd�rmak istedi�imizi
						 --> sa�daki t�rnaks�z veriler ise ka� defa yazd�mak isted�imizi sa�lar

select *,REPLICATE('0',8-LEN(s�rano))+CONVERT(varchar,s�rano) from test
update test set s�rano2=REPLICATE('0',8-LEN(s�rano))+CONVERT(varchar,s�rano)

-- replace (stirg bir ifadeyi bul ve yeri string veriyi ekle)
select 'selim bera'
select REPLACE('selim bera','bera','bera devrez')
			  --> 1.T�rnak neyi bulucam
			  --> 2.T�rnak neyi de�i�tiricem 
			  --> 3.T�rnak ne ekleyece�im 


--> DECLARE ile de�i�ken tan�mlayabiliriz 
	--> DECLARE @Yenide�i�ken as varchar(Max)

	--> set @Yenide�i�ken = 'Bir yaz�y� �ekil, anlat�m ve noktalama 
	--						�zellikleriyle olu�turan kelimelerin b�t�n�ne 
	--						metin ad� verilir. Di�er bir ifadeyle metin, 
	--						ileti�im kurmak i�in olu�turulan c�mleler toplulu�udur. 
	--						S�zl� ya da yaz�l� ileti�im i�in �retilen anlaml� yap�d�r. 
	--						Yazar, iletmek istedi�i mesaj� metin arac�l���yla ifade eder.
	--						Bir metin, aralar�nda anlam, anlat�m bak�m�ndan ili�ki ve b�t�nl�k bulunan paragraflardan olu�ur. 
	--						�yi kurgulanm�� bir metinde, her paragraf bir d���nce birimidir. Metindeki paragraf say�s�, 
	--						o metnin i�erdi�i d���nce say�s�n� verir. Bunun nedeniyse her d���ncenin bir paragrafta tam olarak ortaya konmas�d�r. 
	--						S�zc�kler seslerden, c�mleler s�zc�klerden, paragraflar ise c�mlelerden olu�ur.'
	
	set @yenide�i�ken=REPLACE(@yenide�i�ken,'yaz�y�','metni')
	select LEN(@yenide�i�ken)
	set @yenide�i�ken=REPLACE(@yenide�i�ken,'bir','')
	select LEN(@yenide�i�ken)
	select @yenide�i�ken

	-- 2. yol 
		
		declare @len1 as int
		set @len1=LEN(@yenide�i�ken)
		declare @len2 as int
		set @yenide�i�ken=REPLACE(@yenide�i�ken,'bir','')
		set @len2=LEN(@yenide�i�len)
		select (@len1-@len2)/LEN('bir')








    






