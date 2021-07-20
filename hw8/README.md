Перечень команд:
```
docker exec -it hive-server /bin/bash
cd ..
cd taxiTrips
hive -f create_tables.hql


hive
use testdb
LOAD DATA LOCAL INPATH '/taxiTrips/data/yellow_taxi_jan_25_2018' OVERWRITE INTO TABLE yellow_taxi;
LOAD DATA LOCAL INPATH '/taxiTrips/data/taxi_zones.csv' OVERWRITE INTO TABLE taxi_zones;
```

Выводит общее число поездок в каждом районе, отсортированное по убыванию
```
SELECT tz.Borough, count(*) as num
FROM yellow_taxi yt
JOIN taxi_zones tz ON yt.DOLocationID = tz.LocationID
GROUP BY tz.Borough
ORDER BY num DESC;
```

Выводит количество поездок для каждого часа, отсортированное по убыванию
```
SELECT date_format(tpep_pickup_datetime,'HH') as hour, count(*) as num
FROM yellow_taxi
GROUP BY date_format(tpep_pickup_datetime,'HH')
ORDER BY num DESC;
```

Выводит долю поездок <5, 5-15, 16-25, 26-100
```
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
```



