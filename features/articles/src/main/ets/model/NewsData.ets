import { NewsItem } from './NewsItem';

/**
 * News data manager.
 */
export class NewsData {
  private static newsList: NewsItem[] = [
    new NewsItem('1', '科技巨头发布新一代AI芯片，算力提升10倍',
                '据最新消息，科技巨头今日发布了最新一代人工智能芯片，采用全新架构设计，算力相比上一代产品提升了10倍，能效比显著改善，将为AI应用带来更强大的性能支持。',
                new Date('2024-12-06 10:00:00'), '科技日报', '科技'),

    new NewsItem('2', '全球气候大会达成历史性协议',
                '在为期两周的激烈谈判后，全球气候大会今日达成历史性协议，各国承诺在2030年前大幅减少碳排放，并设立1000亿美元气候基金支持发展中国家应对气候变化。',
                new Date('2024-12-06 09:30:00'), '环境报', '环境'),

    new NewsItem('3', '新能源汽车销量创历史新高',
                '最新数据显示，今年新能源汽车销量创下历史新高，同比增长超过50%，市场渗透率首次突破30%，标志着汽车行业正在加速向电动化转型。',
                new Date('2024-12-06 08:45:00'), '汽车周刊', '汽车'),

    new NewsItem('4', '国产大飞机首次商业飞行成功',
                '国产大飞机今日完成了首次商业飞行任务，标志着我国航空工业发展迎来重要里程碑，打破了长期以来国外制造商在大型客机市场的垄断地位。',
                new Date('2024-12-05 16:20:00'), '航空报', '航空'),

    new NewsItem('5', '量子计算机实现重大突破',
                '科研团队成功研发出新一代量子计算机，在量子比特数量和稳定性方面都实现了重大突破，为量子计算的商业化应用奠定了坚实基础。',
                new Date('2024-12-05 14:15:00'), '科学杂志', '科学'),

    new NewsItem('6', '城市更新计划启动，老旧小区改造提速',
                '市政府宣布启动新一轮城市更新计划，将投入专项资金用于老旧小区改造，预计将惠及数万户居民，提升城市整体居住环境品质。',
                new Date('2024-12-05 11:30:00'), '城市快报', '城市'),

    new NewsItem('7', '教育改革新政策出台，素质教育全面推进',
                '教育部发布最新教育改革政策，将进一步推进素质教育，减轻学生课业负担，培养学生的创新能力和实践能力，促进教育公平发展。',
                new Date('2024-12-05 09:45:00'), '教育报', '教育'),

    new NewsItem('8', '医疗健康产业迎来发展新机遇',
                '随着人口老龄化加剧和健康意识提升，医疗健康产业迎来发展新机遇，智能医疗、远程诊疗等新兴业态快速发展，为传统医疗模式带来革新。',
                new Date('2024-12-04 15:20:00'), '健康报', '医疗')
  ];

  /**
   * Get all news data.
   */
  static getAllNews(): NewsItem[] {
    return [...NewsData.newsList];
  }

  /**
   * Search news by keyword.
   */
  static searchNews(keyword: string): NewsItem[] {
    if (!keyword.trim()) {
      return [...NewsData.newsList];
    }

    const lowerKeyword = keyword.toLowerCase();
    return NewsData.newsList.filter(news =>
      news.title.toLowerCase().includes(lowerKeyword) ||
      news.summary.toLowerCase().includes(lowerKeyword) ||
      news.category.toLowerCase().includes(lowerKeyword)
    );
  }
}