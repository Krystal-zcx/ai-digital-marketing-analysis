-- 01_create_table.sql
-- Project: AI Digital Marketing Analysis
-- Database: SQLite

DROP TABLE IF EXISTS ads;

CREATE TABLE ads (
    ad_id TEXT PRIMARY KEY,
    platform TEXT NOT NULL,
    creative_type TEXT NOT NULL,
    audience TEXT NOT NULL,
    impressions INTEGER NOT NULL,
    clicks INTEGER NOT NULL,
    conversions INTEGER NOT NULL,
    spend_usd REAL NOT NULL,
    revenue_usd REAL NOT NULL
);

-- 数据导入后，可先检查前 10 行
SELECT * FROM ads LIMIT 10;
