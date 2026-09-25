# AI + Digital Marketing Analysis

一个面向校招作品集的数字营销数据分析项目，展示从广告数据清洗、指标计算、效果诊断到 AI 辅助素材复盘的完整流程。

## 项目目标
通过模拟多平台广告投放数据，分析不同平台、素材类型和受众的表现，帮助回答：
- 哪些广告素材更值得继续投放？
- 哪个平台的转化效率更高？
- CTR / CVR / CPA / ROAS 分别说明了什么？
- 下一轮素材应该如何优化？

## 技术栈
- Python
- Pandas
- NumPy
- Excel / CSV
- Prompt Design
- 可扩展：SQL、Power BI、Tableau

## 核心指标
- CTR = Clicks / Impressions
- CVR = Conversions / Clicks
- CPC = Spend / Clicks
- CPA = Spend / Conversions
- ROAS = Revenue / Spend

## 项目结构
```text
ai-digital-marketing-analysis/
├── data/
│   └── sample_ads.csv
├── src/
│   └── analyze_ads.py
├── prompts/
│   └── creative_review_prompt.md
├── outputs/
├── requirements.txt
├── .gitignore
└── README.md
```

## 快速运行
```bash
pip install -r requirements.txt
python src/analyze_ads.py
```

运行后会生成：
- `ads_with_metrics.csv`
- `top_10_ads.csv`
- `platform_summary.csv`
- `creative_summary.csv`

## 项目亮点（可写进简历）
- 基于多平台广告投放模拟数据，使用 Python/Pandas 完成数据清洗、CTR/CVR/CPA/ROAS 等核心指标计算与效果诊断。
- 搭建广告素材表现排序逻辑，从平台、素材类型与受众维度识别高表现组合，并形成可执行的投放优化建议。
- 结合 Prompt Design 设计 AI 广告素材复盘模板，将投放数据与创意分析结合，支持下一轮 A/B Test 与素材迭代。

## 下一步可扩展
1. 用 SQL 建表并完成平台/素材/受众维度查询。
2. 使用 Power BI / Tableau 做可视化看板。
3. 接入真实公开营销数据。
4. 增加广告文案自动标签、情绪识别、卖点分类。
5. 增加简单的预算分配模型。

> 注：本仓库数据为模拟数据，仅用于作品展示和学习。
