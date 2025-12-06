import { responsiveLayout } from '@ohos/responsivelayout';


@Entry
@Component
struct Index {
  build() {
    Column() {
      responsiveLayout();
    }
  }
}