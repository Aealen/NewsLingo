import { responsiveLayout } from '@ohos/responsivelayout';

@Entry
@Component
struct ResponsiveIndex {
  build() {
    Column() {
      responsiveLayout();
    }
  }
}