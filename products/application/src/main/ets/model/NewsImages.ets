/**
 * News cover images management.
 */
export class NewsImages {
  private static readonly newsCoverImages: Map<string, string> = new Map([
    ['1', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // AI芯片新闻
    ['2', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // 气候大会新闻
    ['3', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // 新能源汽车新闻
    ['4', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // 大飞机新闻
    ['5', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // 量子计算机新闻
    ['6', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // 城市更新新闻
    ['7', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'], // 教育改革新闻
    ['8', 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png']  // 医疗健康新闻
  ]);

  private static readonly localDefaultImage: Resource = $r('app.media.startIcon');

  /**
   * Get cover image URL by news id.
   */
  static getCoverImageUrl(newsId: string): string {
    return NewsImages.newsCoverImages.get(newsId) || NewsImages.getDefaultCoverImageUrl();
  }

  /**
   * Get default cover image URL.
   */
  static getDefaultCoverImageUrl(): string {
    return 'https://blog.aowu.tech/upload/2022/11/Icon-1669180904202.png'; // 你的博客图标
  }

  /**
   * Get local default image resource.
   */
  static getLocalDefaultImage(): Resource {
    return NewsImages.localDefaultImage;
  }

  /**
   * Get cover image by news id (backward compatibility).
   */
  static getCoverImage(newsId: string): string {
    return NewsImages.getCoverImageUrl(newsId);
  }

  /**
   * Get default cover image (backward compatibility).
   */
  static getDefaultCoverImage(): string {
    return NewsImages.getDefaultCoverImageUrl();
  }
}