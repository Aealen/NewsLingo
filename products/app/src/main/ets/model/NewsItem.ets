import { NewsImages } from './NewsImages';

/**
 * News data model for news list.
 */
export class NewsItem {
  id: string = '';
  title: string = '';
  summary: string = '';
  publishTime: Date = new Date();
  author: string = '';
  category: string = '';
  coverImageUrl?: string;

  constructor(id: string, title: string, summary: string, publishTime?: Date, author?: string, category?: string) {
    this.id = id;
    this.title = title;
    this.summary = summary;
    this.publishTime = publishTime || new Date();
    this.author = author || '';
    this.category = category || '';
    this.coverImageUrl = NewsImages.getCoverImageUrl(id);
  }

  /**
   * Get cover image URL for this news item.
   */
  getCoverImageUrl(): string {
    return this.coverImageUrl || NewsImages.getDefaultCoverImageUrl();
  }

  /**
   * Get cover image for this news item (backward compatibility).
   */
  getCoverImage(): string {
    return this.getCoverImageUrl();
  }
}