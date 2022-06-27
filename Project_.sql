/*- **Ads(ad_id, campaign_id, status)**
- **the status could be active or inactive**
- **Events(event_id, ad_id, source, event_type, date, hour)**
- **event_type could be an impression, click, conversion***/

--1  The number of active ads.
SELECT 
	COUNT(*)
FROM ads
	WHERE status = 'active'

--2 All active campaigns. A campaign is active if there’s at least one active ad.
SELECT 
	DISTINCT campaign_id
FROM ads
	WHERE status = 'active'

--3 The number of active campaigns.

SELECT 
	COUNT(DISTINCT campaign id)
FROM ads
	WHERE status = 'active'

--4 The number of events per ad — broken down by event type

SELECT  
	COUNT(*)AS counter,
	event_id,
    event_type
FROM Events
	GROUP BY ad_id,event_type
	ORDER BY ad_id, counter

--The number of events over the last week per each active ad — broken down by event type and date (most recent first).
	   
SELECT a.ad_id, e.event_type, e.date, count(*) as "count"
FROM Ads AS a
  JOIN Events AS e
      ON a.ad_id = e.ad_id
WHERE a.status = 'active'
   AND e.date >= NOW - INTERVAL "1 WEEK" 
GROUP BY a.ad_id, e.event_type, e.date
ORDER BY e.date ASC, "count" DESC;


--The number of events per campaign — by event type.

SELECT 
	COUNT(*) AS no_of_campaigns,
	event_type,
FROM Ads a
	JOIN Events e
	ON a.ad_id = e.ad_id
	GROUP BY event_id,event_type
	ORDER BY event_id,event_type
	
-- The number of events over the last week per each campaign and event type — broken down by date (most recent first).



--- **8.  CTR (click-through rate) for each ad. CTR = number of clicks/number of impressions.**
    WITH
    total_impressions AS (
                    SELECT ad_id,
                            COUNT(*) AS impressions_count
                    FROM Events
                    WHERE event_type = 'impression'
                    GROUP BY ad_id
                    ),
    total_clicks as (
                SELECT 
                            ad_id,
                            COUNT(*) AS clicks_count
                    FROM Events
                    WHERE event_type = 'click'
                    GROUP BY ad_id
                    )
	  SELECT t1.ad_id,
           CAST(t2.clicks_count*100 / t1.impressions_count AS FLOAT) || '%' AS CTR 
    FROM total_impressions AS t1 
             JOIN total_clicks AS t2 
            ON t1.ad_id = t2.ad_id
    ORDER BY t1.ad_id
    
-- **9.  CVR (conversion rate) for each ad. CVR = number of conversions/number of clicks.**
WITH
    total_coversions AS (
                    SELECT  ad_id,
                            COUNT(*) AS conversions_count
                    FROM Events
                    WHERE event_type = 'conversion'
                    GROUP BY ad_id
                    ),
    total_clicks  AS (
                SELECT ad_id,
                      COUNT(*) AS clicks_count
                    FROM EVENTS
                    WHERE event_type = 'click'
                    GROUP BY ad_id
                    )
    SELECT t1.ad_id
            CAST(t1.coversions_count *100 / t2.clicks_coun AS FLOAT) || '%' AS CVR 
    FROM total_conversions as t1 
             JOIN total_clicks as t2 
            ON t1.ad_id = t2.ad_id
    ORDER BY t1.ad_id
-- **10.  CTR and CVR for each ad broken down by day and hour (most recent first).**
WITH 
        total_clicks AS (
                    SELECT 
                            ad_id, date,hour,
                            COUNT(*) AS clicks_count
                    FROM Events
                    WHERE event_type = 'click'
                    GROUPBY ad_id, date,hour
                        ),
        total_conversions AS (
                    SELECT  ad_id, date,hour,
                            COUNT(*) AS conversions_count
                    FROM Events
                    WHERE event_type = 'conversion'
                    GROUP BY ad_id, date, hour
                        ),
        total_impressions AS (
                    SELECT ad_id, date,hour,
                            COUNT(*) AS impressions_count
                    FROM Events
                    WHERE event_type = 'impression'
                    GROUPBY ad_id, date,hour
                        )
    SELECT 
            t1.ad_id, t1.date,t1.hour
            CAST(t1.coversions_count *100 / t2.clicks_count AS FLOAT) || '%' AS CVR 
            CAST(t1.clicks_count *100 / t3.impressions_count AS FLOAT) || '%' AS CTR 
    FROM total_conversions as t1 
             JOIN total_clicks as t2 
            ON t1.ad_id = t2.ad_id
            JOIN total_impressions as t3
            ON t1.ad_id = t3.ad_id 
    ORDERBY t1.ad_id, t1.date DESC,t1.hour DESC, "CTR" DESC, "CVR" DESC;
	
-- **11.  CTR for each ad broken down by source and day**