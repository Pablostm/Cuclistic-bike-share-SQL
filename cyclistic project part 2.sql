ALTER TABLE
  [dbo].[all_trips]
ADD
  ride_length int
UPDATE
  [dbo].[all_trips]
SET
  ride_length = DATEDIFF(
    MINUTE,
    cast(started_at AS datetime2),
    cast(ended_at AS datetime2)
  )
  -- Extracting month and year from datetime2 format and adding them as new columns
ALTER TABLE
  [cyclistic].[dbo].[all_trips]
ADD
  day_of_week nvarchar(50),
  month_m nvarchar(50),
  year_y nvarchar(50),
  hour_h nvarchar(50) 
  
  -- Extracting month and year from datetime2 format and adding them as new columns
UPDATE
  [cyclistic].[dbo].[all_trips]
SET
  day_of_week = DATENAME(WEEKDAY, cast(started_at AS datetime)),
  month_m = DATENAME(MONTH, cast(started_at AS datetime)),
  year_y = year(cast(started_at AS datetime)),
  hour_h = DATENAME(HOUR, cast(started_at AS datetime))
ALTER TABLE
  [cyclistic].[dbo].[all_trips]
ADD
  month_int int
UPDATE
  [cyclistic].[dbo].[all_trips] 
  
  -- Extracting month num from datetime2 format
SET
  month_int = DATEPART(MONTH, started_at)
ALTER TABLE
  [cyclistic].[dbo].[all_trips]
ADD
  hour_int int
UPDATE
  [cyclistic].[dbo].[all_trips] 
  
  -- Extracting hour num from datetime2 format
SET
  hour_int = DATEPART(HOUR, started_at)
ALTER TABLE
  [cyclistic].[dbo].[all_trips]
ADD
  date_yyyy_mm_dd date
UPDATE
  [cyclistic].[dbo].[all_trips] 
  
  -- Casting datetime2 format to date
SET
  date_yyyy_mm_dd = CAST(started_at AS date) 
  
  -- Deleted rows where (NULL values), (ride length = 0), (ride length < 0), (ride_length > 1440 mins) for accurate analysis
DELETE FROM
  [cyclistic].[dbo].[all_trips]
WHERE
  ride_id IS NULL
  OR start_station_name IS NULL
  OR end_station_name IS NULL
  OR start_lat IS NULL
  OR start_lng IS NULL
  OR end_lat IS NULL
  OR end_lng IS NULL
  OR ride_length IS NULL
  OR ride_length = 0
  OR ride_length < 0
  OR ride_length > 1440 -- this reprensent a hole day in minutes

-- Looking for duplicate values
SELECT
  Count(DISTINCT(ride_id)) AS uniq,
  Count(ride_id) AS total
FROM
  [cyclistic].[dbo].[all_trips] -- 9 duplicate ride_id values were found iN ride_id
  WITH DuplicateCTE AS (
    SELECT
      [ride_id],
      ROW_NUMBER() OVER (
        PARTITION BY [ride_id]
        ORDER BY
          [ride_id]
      ) DupRank
    FROM
      [cyclistic].[dbo].[all_trips]
  )
DELETE FROM
  DuplicateCTE
WHERE
  DupRank > 1 
  
-- calculating the number of member_casual in the year
SELECT
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  Count(ride_id) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual;

-- Calculating Number of Riders by months at the yar User Type 
SELECT
  month_m,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  Count(ride_id) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  month_m,
  month_int
ORDER BY
  month_int 
  
 -- Calculating Number of Riders Each Day by User Type and 
SELECT
  day_of_week,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  Count(ride_id) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  day_of_week 
  -- Calculating Number of Rides by hour of day
SELECT
  hour_h,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  count(ride_length) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  hour_h,
  hour_int
ORDER BY
  hour_int 
  -- Calculating average ride lenght of Rides in the year
SELECT
  year_y,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  avg(ride_length) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  year_y 
  -- Calculating average ride lenght of Rides by month
SELECT
  month_m,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  avg(ride_length) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  month_m,
  month_int
ORDER BY
  month_int 
  -- Calculating average ride lenght of Rides by month
SELECT
  day_of_week,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  avg(ride_length) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  day_of_week 
  -- Calculating average ride lenght of Rides by month
SELECT
  hour_h,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  avg(ride_length) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  hour_h,
  hour_int
ORDER BY
  hour_int 
  -- types of bike by users
SELECT
  rideable_type,
  CASE
    WHEN member_casual = 'casual' THEN 'casual'
    WHEN member_casual = 'member' THEN 'member'
  END AS members,
  Count(ride_id) AS total_users
FROM
  [cyclistic].[dbo].[all_trips]
GROUP BY
  member_casual,
  rideable_type
ORDER BY
  rideable_type 
  -- top 10 most visited stations by users
SELECT
  TOP (10) start_station_name,
  COUNT(ride_id) AS rides
FROM
  [cyclistic].[dbo].[all_trips]
WHERE
  start_station_name IS NOT NULL
GROUP BY
  start_station_name
ORDER BY
  COUNT(*) DESC 
  -- top 10 most visited stations by users
SELECT
  TOP (10) start_station_name,
  member_casual,
  COUNT(ride_id) AS rides
FROM
  [cyclistic].[dbo].[all_trips]
WHERE
  start_station_name IS NOT NULL
GROUP BY
  member_casual,
  start_station_name
ORDER BY
  COUNT(*) DESC 
