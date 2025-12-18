class ArticleModel {
  final String title;          // 文章标题
  final String summary;        // 文章摘要
  final String coverImage;     // 文章封面图
  final String source;         // 来源
  final String date;           // 日期
  final String id;             // 文章ID

  ArticleModel({
    required this.title,
    required this.summary,
    required this.coverImage,
    required this.source,
    required this.date,
    required this.id,
  });

  // 创建一些模拟数据
  static List<ArticleModel> getMockData() {
    return [
      ArticleModel(
        id: '1',
        title: 'Flutter 3.0 发布：性能提升与全新功能',
        summary: 'Flutter 3.0 带来了显著的性能提升，包括更快的启动时间和更流畅的动画效果。新版本还增加了多个平台的完整支持。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '技术日报',
        date: '2024-01-15',
      ),
      ArticleModel(
        id: '2',
        title: '人工智能在日常生活中的应用',
        summary: 'AI技术正在改变我们的生活方式，从智能家居到自动驾驶，从医疗诊断到金融服务，AI的应用无处不在。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '科技前沿',
        date: '2024-01-14',
      ),
      ArticleModel(
        id: '3',
        title: '区块链技术：超越加密货币的应用',
        summary: '区块链技术不仅应用于加密货币，还在供应链管理、数字身份认证、智能合约等领域展现出巨大潜力。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '财经周刊',
        date: '2024-01-13',
      ),
      ArticleModel(
        id: '4',
        title: '量子计算的未来展望',
        summary: '量子计算有望在密码学、药物研发、材料科学等领域带来革命性突破，各大科技公司纷纷投入研发。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '科学杂志',
        date: '2024-01-12',
      ),
      ArticleModel(
        id: '5',
        title: '5G网络的全球部署进展',
        summary: '5G网络正在全球范围内加速部署，为物联网、自动驾驶、远程医疗等应用提供了强有力的网络支持。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '通信世界',
        date: '2024-01-11',
      ),
      ArticleModel(
        id: '6',
        title: '元宇宙：虚拟与现实的新边界',
        summary: '元宇宙概念的兴起标志着互联网发展的新阶段，虚拟现实和增强现实技术正在重塑我们的社交和工作方式。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '数字时代',
        date: '2024-01-10',
      ),
      ArticleModel(
        id: '7',
        title: '新能源汽车产业的崛起',
        summary: '随着环保意识的增强和技术的进步，新能源汽车正逐渐取代传统燃油车，成为汽车产业的主流发展方向。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '汽车周刊',
        date: '2024-01-09',
      ),
      ArticleModel(
        id: '8',
        title: '云原生架构的优势与实践',
        summary: '云原生架构为企业带来了更高的灵活性、可扩展性和可靠性，微服务和容器化技术成为主流选择。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '架构师杂志',
        date: '2024-01-08',
      ),
      ArticleModel(
        id: '9',
        title: '机器学习在医疗诊断中的应用',
        summary: '机器学习算法在医学影像分析、疾病预测和个性化治疗等方面展现出巨大潜力，提高了诊断的准确性和效率。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '医疗科技',
        date: '2024-01-07',
      ),
      ArticleModel(
        id: '10',
        title: '边缘计算的兴起与挑战',
        summary: '边缘计算将数据处理推向网络边缘，减少了延迟和带宽需求，为物联网和实时应用提供了更好的支持。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '云计算资讯',
        date: '2024-01-06',
      ),
      ArticleModel(
        id: '11',
        title: '网络安全威胁的新趋势',
        summary: '随着数字化转型的深入，网络安全面临新的挑战，零信任架构和AI驱动的安全解决方案成为应对威胁的关键。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '网络安全报',
        date: '2024-01-05',
      ),
      ArticleModel(
        id: '12',
        title: '自动驾驶技术的商业化进程',
        summary: '自动驾驶技术从实验室走向商业化应用，L4级别自动驾驶在特定场景下已经实现，完全自动驾驶指日可待。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '智能汽车',
        date: '2024-01-04',
      ),
      ArticleModel(
        id: '13',
        title: '可持续发展的绿色IT解决方案',
        summary: '数据中心节能、绿色云计算和循环经济模式正在成为IT行业可持续发展的重要方向。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '绿色科技',
        date: '2024-01-03',
      ),
      ArticleModel(
        id: '14',
        title: 'AR/VR技术在教育领域的创新应用',
        summary: '增强现实和虚拟现实技术为教育带来了沉浸式体验，使抽象概念变得直观，提高了学习效果。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '教育科技',
        date: '2024-01-02',
      ),
      ArticleModel(
        id: '15',
        title: '金融科技：重塑银行业未来',
        summary: '数字支付、智能风控和区块链技术正在深刻改变传统银行业的运营模式，推动金融服务的数字化转型。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '金融创新',
        date: '2024-01-01',
      ),
      ArticleModel(
        id: '16',
        title: '物联网平台的标准化与互操作性',
        summary: '为了解决物联网设备碎片化问题，行业正在推动平台标准化，实现不同厂商设备之间的互联互通。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '物联网世界',
        date: '2023-12-31',
      ),
      ArticleModel(
        id: '17',
        title: '分布式数据库的技术演进',
        summary: '从关系型数据库到分布式数据库，数据存储技术不断演进，满足了大数据时代对高可用性和扩展性的需求。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '数据库技术',
        date: '2023-12-30',
      ),
      ArticleModel(
        id: '18',
        title: '电子竞技产业的蓬勃发展',
        summary: '电子竞技从娱乐活动发展成为庞大的产业，职业化、商业化进程加速，成为数字经济的重要组成部分。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '游戏产业',
        date: '2023-12-29',
      ),
      ArticleModel(
        id: '19',
        title: '智能制造：工业4.0的核心驱动力',
        summary: '通过物联网、大数据和人工智能技术，智能制造正在实现生产过程的数字化、网络化和智能化转型。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '工业互联网',
        date: '2023-12-28',
      ),
      ArticleModel(
        id: '20',
        title: '量子通信：绝对安全的未来通信',
        summary: '量子通信利用量子力学原理实现信息传输，理论上能够提供绝对安全的通信保障，已成为各国竞相发展的前沿技术。',
        coverImage: 'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '量子科技',
        date: '2023-12-27',
      ),
    ];
  }
}