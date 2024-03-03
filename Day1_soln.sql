with cte as(
	select *,
			CASE WHEN brand1 < brand2 then CONCAT(brand1,brand2,year) 
			else concat(brand2,brand1,year) end as pair_id
	from brands),
	cte_rn as 
		(select * ,
			ROW_NUMBER() over(partition by pair_id order by pair_id) as rn
		 from cte)
select brand1,brand2,custom1,custom2,custom3,custom4
from cte_rn
where rn = 1
or (custom1 <> custom3 and custom2 <> custom4)