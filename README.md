# AI + Digital Marketing Analysis

一个面向求职作品集的数字营销数据分析项目，展示从广告数据处理、SQL分析、核心指标诊断，到AI辅助广告优化与A/B Test设计的完整业务分析流程。

> 本项目使用模拟广告投放数据，仅用于展示数据分析与业务决策能力，不代表真实商业投放结果。

## 项目目标

围绕多平台广告投放数据，回答以下业务问题：

- 哪个平台的投放效率更高？
- 哪类素材更值得继续投放？
- 哪些广告存在“高点击、低转化”问题？
- 哪些广告具备追加预算潜力？
- 如何结合AI自动生成优化建议与A/B Test方案？

## 技术栈

- Python
- Pandas
- SQL
- SQLite
- Excel / CSV
- Prompt Design
- AI-assisted Marketing Analysis

## 核心指标

- CTR = Clicks / Impressions
- CVR = Conversions / Clicks
- CPC = Spend / Clicks
- CPA = Spend / Conversions
- ROAS = Revenue / Spend

## 分析流程

数据导入  
→ Python数据处理  
→ SQL分组聚合与业务诊断  
→ CTR / CVR / CPA / ROAS分析  
→ 广告分层  
→ AI诊断  
→ 优化建议  
→ A/B Test设计
## 可视化结果

### 各平台 ROAS 对比

![ROAS by Platform](images/platform_roas.png)

从模拟数据结果看，YouTube 的 ROAS 最高，为 6.06；小红书次之，为 5.74；TikTok 为 4.96；Instagram 最低，为 3.25。说明不同平台在投入产出效率上存在明显差异，预算分配不能仅依据点击量，还应结合转化效率与收入回报综合判断。
## 核心业务发现

### 1. YouTube整体投入产出效率最高

YouTube 的 ROAS 为 6.06，为四个平台中最高，说明单位广告投入带来的收入回报最强。

### 2. 小红书转化效率最好

小红书 CVR 为 5.67%，CPA 为 14.05，表现为最高转化率和最低获客成本。

### 3. Instagram存在明显“高点击、低转化”问题

Instagram CTR 为 3.08%，为四个平台最高，但 CVR 仅为 4.79%，CPA 高达 24.32，ROAS 仅为 3.25。

说明问题可能不在“素材没人点”，而在点击后的承接环节，例如受众匹配、卖点、价格或落地页。

## 广告决策规则

为展示分析流程，本项目设置了示例规则：

- Increase Budget：ROAS >= 10 且 CPA <= 15
- Optimize Conversion：CTR >= 3% 且 CVR < 4%
- Reduce / Review：ROAS < 3
- Monitor：其他情况

> 以上阈值仅用于模拟分析演示，真实业务中应结合毛利率、获客目标和历史基准调整。

## AI广告诊断案例

### Case 1：AD016 — Optimize Conversion

- Platform：Xiaohongshu
- Creative Type：Lifestyle
- Audience：Students
- CTR：3.37%
- CVR：1.87%
- CPA：42.76
- ROAS：1.50

核心问题：

高点击、低转化。素材具备一定吸引力，但用户点击后转化效率较弱。

建议：

- 优化学生群体受众定向
- 强化价格 / 产品价值表达
- 优化落地页承接
- 设计价格利益型 vs 场景价值型 A/B Test

详细分析：

`outputs/ai_review_AD016.md`

### Case 2：AD004 — Increase Budget

- Platform：YouTube
- Creative Type：Product Demo
- Audience：Young Professionals
- CTR：2.65%
- CVR：4.19%
- CPA：7.36
- ROAS：23.93

核心优势：

高投入产出、低获客成本，适合采用渐进式扩量。

建议：

- 小幅增加预算
- 复制高表现素材逻辑
- 拓展相似受众
- 持续监控CPA和ROAS

详细分析：

`outputs/ai_review_AD004.md`

## 项目结构

```text
ai-digital-marketing-analysis/
├── data/
│   └── sample_ads.csv
├── outputs/
│   ├── ads_with_metrics.csv
│   ├── ai_review_AD004.md
│   ├── ai_review_AD016.md
│   ├── creative_summary.csv
│   ├── platform_summary.csv
│   └── top_10_ads.csv
├── prompts/
│   └── creative_review_prompt.md
├── sql/
│   ├── 01_create_table.sql
│   └── 02_analysis_queries.sql
├── src/
│   └── analyze_ads.py
├── README.md
├── requirements.txt
└── .gitignore
