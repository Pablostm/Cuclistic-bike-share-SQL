-- we should combine the data
CREATE TABLE all_trips(
ride_id nvarchar(255),
rideable_type nvarchar(50),
started_at datetime2,
ended_at datetime2,
start_station_name nvarchar(255),
end_station_name nvarchar(255),
start_lat float,
start_lng float,
end_lat float,
end_lng float,
member_casual nvarchar(50) )

INSERT INTO [dbo].[all_trips] (ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual)
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_01$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_02$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_03$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_04$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_05$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_06$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_07$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_08$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_09$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_10$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_11$])
UNION ALL
(SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.dbo.[tp_12$])

