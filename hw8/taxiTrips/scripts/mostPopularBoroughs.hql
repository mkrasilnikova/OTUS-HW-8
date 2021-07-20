SELECT tz.Borough, count(*) as num
FROM yellow_taxi yt
JOIN taxi_zones tz ON yt.DOLocationID = tz.LocationID
GROUP BY tz.Borough
ORDER BY num DESC;