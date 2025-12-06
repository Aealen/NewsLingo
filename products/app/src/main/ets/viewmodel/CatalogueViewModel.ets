import { RESPONSIVE_ROUTE } from '../constants/RouteConstants';
import { CatalogueItemData } from './CatalogueItemData';

/**
 * Catalogue list page view model.
 */
class CatalogueViewModel {
  /**
   * Get Catalogue data.
   *
   * @return {Array<CatalogueItemData>} CatalogueData.
   */
  getCatalogueData(): CatalogueItemData[] {
    const catalogueData: CatalogueItemData[] =
      [new CatalogueItemData(0, $r('app.string.responsive_layout'), RESPONSIVE_ROUTE)];
    return catalogueData;
  }
}

const catalogueViewModel = new CatalogueViewModel();

export default catalogueViewModel;