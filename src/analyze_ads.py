import pandas as pd
from pathlib import Path

BASE = Path(__file__).resolve().parents[1]
INPUT = BASE / "data" / "sample_ads.csv"
OUTPUT_DIR = BASE / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

df = pd.read_csv(INPUT)

df["CTR"] = df["clicks"] / df["impressions"]
df["CVR"] = df["conversions"] / df["clicks"].replace(0, pd.NA)
df["CPC"] = df["spend_usd"] / df["clicks"].replace(0, pd.NA)
df["CPA"] = df["spend_usd"] / df["conversions"].replace(0, pd.NA)
df["ROAS"] = df["revenue_usd"] / df["spend_usd"].replace(0, pd.NA)

# Rank ads using a simple composite score
metrics = {
    "CTR": True,
    "CVR": True,
    "ROAS": True,
    "CPA": False
}
for metric, higher_is_better in metrics.items():
    df[f"{metric}_rank"] = df[metric].rank(
        ascending=not higher_is_better, method="min"
    )

df["performance_score"] = (
    df["CTR_rank"] * 0.20
    + df["CVR_rank"] * 0.25
    + df["ROAS_rank"] * 0.40
    + df["CPA_rank"] * 0.15
)

top_ads = df.sort_values("performance_score").head(10)
platform_summary = (
    df.groupby("platform", as_index=False)
      .agg(
          impressions=("impressions", "sum"),
          clicks=("clicks", "sum"),
          conversions=("conversions", "sum"),
          spend_usd=("spend_usd", "sum"),
          revenue_usd=("revenue_usd", "sum")
      )
)
platform_summary["CTR"] = platform_summary["clicks"] / platform_summary["impressions"]
platform_summary["CVR"] = platform_summary["conversions"] / platform_summary["clicks"]
platform_summary["CPA"] = platform_summary["spend_usd"] / platform_summary["conversions"]
platform_summary["ROAS"] = platform_summary["revenue_usd"] / platform_summary["spend_usd"]

creative_summary = (
    df.groupby("creative_type", as_index=False)
      .agg(
          impressions=("impressions", "sum"),
          clicks=("clicks", "sum"),
          conversions=("conversions", "sum"),
          spend_usd=("spend_usd", "sum"),
          revenue_usd=("revenue_usd", "sum")
      )
)
creative_summary["CTR"] = creative_summary["clicks"] / creative_summary["impressions"]
creative_summary["CVR"] = creative_summary["conversions"] / creative_summary["clicks"]
creative_summary["CPA"] = creative_summary["spend_usd"] / creative_summary["conversions"]
creative_summary["ROAS"] = creative_summary["revenue_usd"] / creative_summary["spend_usd"]

df.to_csv(OUTPUT_DIR / "ads_with_metrics.csv", index=False)
top_ads.to_csv(OUTPUT_DIR / "top_10_ads.csv", index=False)
platform_summary.to_csv(OUTPUT_DIR / "platform_summary.csv", index=False)
creative_summary.to_csv(OUTPUT_DIR / "creative_summary.csv", index=False)

print("Analysis complete.")
print("\nTop 5 ads:")
print(top_ads[["ad_id", "platform", "creative_type", "CTR", "CVR", "CPA", "ROAS"]].head())
