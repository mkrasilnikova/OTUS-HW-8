SELECT date_format(tpep_pickup_datetime,'HH') as hour, count(*) as num
FROM yellow_taxi
GROUP BY date_format(tpep_pickup_datetime,'HH')
ORDER BY num DESC;