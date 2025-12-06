import { commonConstants } from '../constants/CommonConstants';
import { TabBarItem } from './TabBarItem';

/**
 * Binds data to components and provides interfaces.
 */
export class TabsViewModel {
  /**
   * Get item information for the tab.
   *
   * @return {Array<TabBarItem>} tabItems
   */
  getTabData(): TabBarItem[] {
    const tabItems: TabBarItem[] = [];
    const tabNames = [$r('app.string.tab_articles'), $r('app.string.tab_profile')];
    const tabIcons = [$r('sys.symbol.book_pages_fill'), $r('sys.symbol.person_fill')];

    for (let i = 0; i < commonConstants.tabSize; i++) {
      const itemInfo: TabBarItem = new TabBarItem();
      itemInfo.id = i;
      itemInfo.name = tabNames[i];
      itemInfo.icon = tabIcons[i];
      itemInfo.selectIcon = tabIcons[i];
      tabItems.push(itemInfo);
    }
    return tabItems;
  }
}

const tabsViewModel = new TabsViewModel();

export default tabsViewModel;