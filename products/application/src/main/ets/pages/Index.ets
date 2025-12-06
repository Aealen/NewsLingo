
import { NewsItem } from '../model/NewsItem';
import { NewsData } from '../model/NewsData';
import { NewsImages } from '../model/NewsImages';


@Entry
@Component
struct Index {
  @State searchKeyword: string = '';
  @State newsList: NewsItem[] = [];

  aboutToAppear() {
    // 初始化新闻列表
    this.newsList = NewsData.getAllNews();
    console.debug('🔍 新闻数据初始化完成，共 ' + this.newsList.length + ' 条');
    console.debug('🔍 第一条新闻图片URL: ' + (this.newsList[0]?.getCoverImageUrl() || '未知'));

    // 检查网络权限和图片URL
    this.debugNetworkAndPermissions();
  }

  /**
   * 调试网络权限和图片URL
   */
  private debugNetworkAndPermissions() {
    console.debug('🔍 === 网络和图片调试信息 ===');

    // 检查新闻数据
    if (this.newsList.length > 0) {
      const firstNews = this.newsList[0];
      const imageUrl = firstNews.getCoverImageUrl();

      console.debug('🔍 图片URL: ' + imageUrl);
      console.debug('🔍 URL协议: ' + (imageUrl.startsWith('https://') ? 'HTTPS' : 'HTTP'));
      console.debug('🔍 URL域名: ' + this.extractDomain(imageUrl));
      console.debug('🔍 新闻ID: ' + firstNews.id);
    }

    // 检查系统权限
    console.debug('🔍 检查网络权限...');
    try {
      const hasPermission = this.checkInternetPermission();
      console.debug('🔍 网络权限状态: ' + (hasPermission ? '已授权' : '未授权'));
    } catch (error) {
      console.error('❌ 权限检查失败: ' + error.message);
    }

    console.debug('🔍 === 调试信息结束 ===');
  }
  /**
   * 提取域名
   */
  private extractDomain(url: string): string {
    try {
      // 使用字符串处理方式提取域名
      if (url.startsWith('http://')) {
        const domainPart = url.substring(7).split('/')[0];
        return domainPart;
      } else if (url.startsWith('https://')) {
        const domainPart = url.substring(8).split('/')[0];
        return domainPart;
      } else {
        return url.split('/')[0];
      }
    } catch (error) {
      return '解析失败';
    }
  }

  /**
   * 检查网络权限（简化版本）
   */
  private checkInternetPermission(): boolean {
    // 在HarmonyOS中，这个方法可能需要使用权限API
    // 这里只是一个占位符，实际可能需要使用 @ohos.abilityAccessCtrl 等
    return true; // 假设权限已在module.json5中配置
  }

  /**
   * 处理搜索输入变化
   */
  onSearchInputChange(value: string) {
    this.searchKeyword = value;
    this.newsList = NewsData.searchNews(value);
  }

  /**
   * 清空搜索
   */
  clearSearch() {
    this.searchKeyword = '';
    this.newsList = NewsData.getAllNews();
  }

  build() {
    Column() {
      // 顶部搜索区域
      Row() {
        TextInput({
          placeholder: '搜索新闻资讯...',
          controller: new TextInputController()
        })
          .width('100%')
          .height(40)
          .backgroundColor('#f5f5f5')
          .borderRadius(20)
          .padding({ left: 16, right: 16 })
          .fontSize(14)
          .fontColor('#333333')
          .onChange((value: string) => {
            this.onSearchInputChange(value);
          })
      }
      .width('90%')
      .height(60)
      .padding({ top: 10, bottom: 10 })
      .justifyContent(FlexAlign.Center)

      // 新闻列表区域
      List() {
        ForEach(this.newsList, (newsItem: NewsItem) => {
          ListItem() {
            NewsListItem({ newsItem: newsItem })
          }
          .width('100%')
        }, (newsItem: NewsItem) => newsItem.id)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
  }
}

/**
 * 新闻列表项组件
 */
@Component
struct NewsListItem {
  @Prop newsItem: NewsItem;

  build() {
    Row() {
      // 左侧封面图片区域
      Image(this.newsItem.getCoverImageUrl())
        .width(60)
        .height(60)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .margin({ right: 12 })
        .alt(NewsImages.getLocalDefaultImage()) // 使用本地备用图片
        .border({ width: 1, color: '#f0f0f0' }) // 添加边框以便调试

      // 右侧内容区域（标题和摘要）
      Column() {
        // 新闻标题
        Text(this.newsItem.title)
          .width('100%')
          .fontSize(15)
          .fontColor('#000000')
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 6 })

        // 新闻摘要
        Text(this.newsItem.summary)
          .width('100%')
          .fontSize(13)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(18)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .margin({ bottom: 8 })
    .shadow({
      radius: 3,
      color: '#1f000000',
      offsetX: 0,
      offsetY: 1
    })
    .onClick(() => {
      // 点击新闻项的处理逻辑
      console.log('点击了新闻：' + this.newsItem.title);
    })
  }
}