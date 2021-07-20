with t1 as (select 'from 0 to 5' as distance, count(1) as num
from yellow_taxi
where trip_distance < 5
UNION ALL
select 'from 5 to 15', count(1)
from yellow_taxi
where trip_distance >= 5 and trip_distance <= 15
UNION ALL
select 'from 16 to 25', count(1)
from yellow_taxi
where trip_distance >= 16 and trip_distance <= 25
UNION ALL
select 'from 26 to 100', count(1)
from yellow_taxi
where trip_distance >= 26 and trip_distance <= 100),
agg as
( select distance, num,
sum(num) over () num_total
from t1)
select distance, num, num_total, round((num*100)/num_total, 3) as percentage
from agg;