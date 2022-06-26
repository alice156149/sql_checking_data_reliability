/* CREATED BY: HIEN DO
	CREATED ON: 2022-06-26
    DESCRIPTION: Check for the reliability of the dataset*/
-- Check if the events table is reliable to use or not
SELECT *
FROM dsv1069.events_201701;

SELECT 
	DATE(event_time) AS date,
	COUNT(*) 		 AS rows
FROM
	dsv1069.events_201701
GROUP BY
	DATE(event_time);
/* - First browse the table to check all the columns
   - Then browse the date and group the data by event date
   - All records are from January 2017 only which we can also tell 
	by looking at the file's name
   - So this table only useful if we need specific information in
	this time period, else this is not the right table to use.*/
   
-- Check the table dsv1069.events_ex2
SELECT *
FROM dsv1069.events_ex2;

SELECT
	DATE(event_time) AS date,
    event_name,
    -- platform,
    COUNT(*)
FROM
	dsv1069.events_ex2
GROUP BY 
	DATE(event_time),
    event_name;
    -- platform;
    
/* - Browse the table to check all the columns
   - Using line chart to check the event and timeline match each other
	and it seems like all the records are sufficient
   - Next replace event_name with platform to check and there were 5 
   categories include server, web, mobile web, IOS and android we can
   see through chart that Android was recording since Jan 2016 and IOS
   was May 2016 so we should double check if these data were recorded
   in different places or not. Or we need to worry about those data*/
   
-- Check the table item_views_temp
SELECT *
FROM dsv1069.item_views_by_category_temp;

SELECT
	SUM(view_events) AS event_count
FROM 
	dsv1069.item_views_by_category_temp;

SELECT
	COUNT(DISTINCT event_id) AS event_count
FROM
	dsv1069.events
WHERE
	event_name = 'view_item';
    
/* - Use SUM to check for how many events in this table
   - Comparing to the total view_item in the event table
   I can see the huge gap in number of events
   - The table didn't show what time it was create
   - This is not reliable enough to use
   */
   
-- Check table raw_events

SELECT
	*
FROM 
	dsv1069.raw_events;
 
 
SELECT
	DATE(event_time) AS date,
    COUNT(*) 		 AS row_count,
    COUNT(event_id)  AS event_id,
    COUNT(user_id)   AS user_count
FROM
	dsv1069.raw_events
GROUP BY
	DATE(event_time);
/* - Using chart in the second SELECT statement I see that the user were not
	 recorded before Jan 2014*/
    
SELECT
	DATE(event_time) AS date,
    platform,
    COUNT(user_id)   AS user
FROM
	dsv1069.raw_events
GROUP BY 
	DATE(event_time),
    platform;

/*   - By checking again the the third SELECT statement I found out that the 
     user ID for website is NULL in the period before Jan 2014*/
     
-- Check the join between 2 tables
SELECT COUNT(*)
FROM
	dsv1069.orders o
JOIN 
	dsv1069.users  u 
ON o.user_id = u.parent_user_id; -- ON o.user_id = COALESCE(u.parent_user_id, u.id) ;

/* - The number of rows are too small just 1308 comparing to over 15 thounds rows in orders table
   - The parent_user_id has lots of NULL values to it reduce the
     size of data when joining
	- We can use u.id to join instead of u.parent_user_id
    - Or we can use COALESCE if we want to join using parent_user_id*/

SELECT COUNT(*)
FROM dsv1069.orders;
/*The number of rows are 15806*/
    
     

    