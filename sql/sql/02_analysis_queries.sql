-- 02_analysis_queries.sql
-- Project: AI Digital Marketing Analysis
-- Database: SQLite

-- 1. 各平台整体投放表现
SELECT
    platform,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(spend_usd), 2) AS spend_usd,
    ROUND(SUM(revenue_usd), 2) AS revenue_usd,
    ROUND(1.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 4) AS ctr,
    ROUND(1.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 4) AS cvr,
    ROUND(1.0 * SUM(spend_usd) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(1.0 * SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
FROM ads
GROUP BY platform
ORDER BY roas DESC;


-- 2. 不同素材类型表现
SELECT
    creative_type,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(1.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 4) AS ctr,
    ROUND(1.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 4) AS cvr,
    ROUND(1.0 * SUM(spend_usd) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(1.0 * SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
FROM ads
GROUP BY creative_type
ORDER BY roas DESC;


-- 3. 不同受众表现
SELECT
    audience,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(1.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 4) AS cvr,
    ROUND(1.0 * SUM(spend_usd) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(1.0 * SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
FROM ads
GROUP BY audience
ORDER BY roas DESC;


-- 4. 单条广告核心指标
SELECT
    ad_id,
    platform,
    creative_type,
    audience,
    ROUND(1.0 * clicks / NULLIF(impressions, 0), 4) AS ctr,
    ROUND(1.0 * conversions / NULLIF(clicks, 0), 4) AS cvr,
    ROUND(1.0 * spend_usd / NULLIF(clicks, 0), 2) AS cpc,
    ROUND(1.0 * spend_usd / NULLIF(conversions, 0), 2) AS cpa,
    ROUND(1.0 * revenue_usd / NULLIF(spend_usd, 0), 2) AS roas
FROM ads
ORDER BY roas DESC;


-- 5. 找出高点击但低转化广告
WITH ad_metrics AS (
    SELECT
        ad_id,
        platform,
        creative_type,
        audience,
        1.0 * clicks / NULLIF(impressions, 0) AS ctr,
        1.0 * conversions / NULLIF(clicks, 0) AS cvr,
        1.0 * revenue_usd / NULLIF(spend_usd, 0) AS roas
    FROM ads
),
avg_metrics AS (
    SELECT
        AVG(ctr) AS avg_ctr,
        AVG(cvr) AS avg_cvr
    FROM ad_metrics
)
SELECT
    a.ad_id,
    a.platform,
    a.creative_type,
    a.audience,
    ROUND(a.ctr, 4) AS ctr,
    ROUND(a.cvr, 4) AS cvr,
    ROUND(a.roas, 2) AS roas
FROM ad_metrics a
CROSS JOIN avg_metrics b
WHERE a.ctr > b.avg_ctr
  AND a.cvr < b.avg_cvr
ORDER BY a.ctr DESC;


-- 6. 找出值得追加预算的广告
WITH ad_metrics AS (
    SELECT
        ad_id,
        platform,
        creative_type,
        audience,
        1.0 * spend_usd / NULLIF(conversions, 0) AS cpa,
        1.0 * revenue_usd / NULLIF(spend_usd, 0) AS roas
    FROM ads
),
avg_cpa AS (
    SELECT AVG(cpa) AS avg_cpa
    FROM ad_metrics
)
SELECT
    a.ad_id,
    a.platform,
    a.creative_type,
    a.audience,
    ROUND(a.cpa, 2) AS cpa,
    ROUND(a.roas, 2) AS roas
FROM ad_metrics a
CROSS JOIN avg_cpa b
WHERE a.roas >= 5
  AND a.cpa < b.avg_cpa
ORDER BY a.roas DESC;


-- 7. 平台 × 素材类型组合表现
SELECT
    platform,
    creative_type,
    SUM(conversions) AS conversions,
    ROUND(1.0 * SUM(spend_usd) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(1.0 * SUM(revenue_usd) / NULLIF(SUM(spend_usd), 0), 2) AS roas
FROM ads
GROUP BY platform, creative_type
HAVING SUM(conversions) >= 1
ORDER BY roas DESC;


-- 8. Top 10 广告
SELECT
    ad_id,
    platform,
    creative_type,
    audience,
    ROUND(1.0 * clicks / NULLIF(impressions, 0), 4) AS ctr,
    ROUND(1.0 * conversions / NULLIF(clicks, 0), 4) AS cvr,
    ROUND(1.0 * spend_usd / NULLIF(conversions, 0), 2) AS cpa,
    ROUND(1.0 * revenue_usd / NULLIF(spend_usd, 0), 2) AS roas
FROM ads
ORDER BY roas DESC, cpa ASC
LIMIT 10;
