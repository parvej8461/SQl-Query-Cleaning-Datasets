select * 
from NashVilleHousing


select a.ParcelID, a.PropertyAddress,b.ParcelID,b.PropertyAddress
from NashVilleHousing a
join NashVilleHousing b
  on a.ParcelID=b.ParcelID
  and a.[UniqueID ]<> b.[UniqueID ]

where a.PropertyAddress is Null

---) 

--select PropertyAddress
from NashVilleHousing
select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as address,
 SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as address

from NashVilleHousing

alter table NashVilleHousing
add PropertySplitAddress NVARCHAR(255);

Update NashVilleHousing
SET PropertySplitAddress= SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

alter table NashVilleHousing 
add Propertysplitcity nvarchar(255);

Update NashVilleHousing
set Propertysplitcity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

Select PropertySplitAddress, Propertysplitcity
from NashVilleHousing

select OwnerName
 from NashVilleHousing
 where OwnerName is not null

 Select 
 PARSENAME(REPLACE(OwnerAddress,',',','),3)
,PARSENAME(REPLACE(OwnerAddress,',',','),2)
,PARSENAME(REPLACE(OwnerAddress,',',','),1)

 from NashVilleHousing


 --
 Alter table  NashVilleHousing
 Add ownersplitaddress NVARCHAR(255);

 UPDATE NashVilleHousing
 SET ownersplitaddress =PARSENAME(REPLACE(OwnerAddress,',','.'),3)

 Alter table  NashVilleHousing
 Add ownersplitcity NVARCHAR(255);

 UPDATE NashVilleHousing
 SET ownersplitcity =PARSENAME(REPLACE(OwnerAddress,',','.'),2)


 Alter table  NashVilleHousing
 Add ownersplitstate NVARCHAR(255);

  UPDATE NashVilleHousing
 SET ownersplitstate =PARSENAME(REPLACE(OwnerAddress,',','.'),1)




 select *
 from NashVilleHousing

 --
 select distinct(SoldAsVacant), COUNT(SoldAsVacant)
 from NashVilleHousing
 group by SoldAsVacant
 order by 2
 ---



Select SoldAsVacant
, (CASE when SoldAsVacant='Y' then 'Yes'
       when SoldAsVacant= 'N' then 'No'
	   else SoldAsVacant
	   end) as SoldasVacant

from NashVilleHousing


--
Update NashVilleHousing
set SoldAsVacant = CASE when SoldAsVacant='Y' then 'Yes'
       when SoldAsVacant= 'N' then 'No'
	   else SoldAsVacant
	   end

select distinct(SoldAsVacant)
from NashVilleHousing


--- Removing duplicates

with RowNumCTE As(
Select*,
   ROW_NUMBER() OVER(
   Partition by ParcelID,
   PropertyAddress,
   Saleprice,
   Saledate,
   LegalReference
   Order by 
    UniqueID)
	row_num
From NashVilleHousing
)
select*
from RowNumCTE
where row_num>1
order by PropertyAddress


-- deleting unused columns


Alter table NashVilleHousing
Drop Column OwnerAddress, PropertyAddress, TaxDistrict

Select * 
from NashVilleHousing
