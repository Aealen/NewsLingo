import { responsiveLayout } from '@ohos/responsivelayout';
import router from '@ohos.router';

@Entry
@Component
struct Profile {
  build() {
    Column() {
      // 主内容区域
      Column() {
        // 用户头像区域
        Row() {
          Image($r('app.media.startIcon'))
            .width(80)
            .height(80)
            .borderRadius(40)
            .margin({ right: 16 })

          Column() {
            Text('用户名')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ bottom: 4 })

            Text('点击编辑个人资料')
              .fontSize(14)
              .fontColor('#666666')
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(20)
        .alignItems(VerticalAlign.Center)

        // 功能列表
        List() {
          ListItem() {
            Row() {
              Text('设置')
                .fontSize(16)
                .fontColor('#333333')
              Blank()
              SymbolGlyph($r('sys.symbol.chevron_left'))
                .width(20)
                .height(20)
                .fontColor(['#999999'])
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              console.log('点击设置');
            })
          }

          ListItem() {
            Row() {
              Text('关于')
                .fontSize(16)
                .fontColor('#333333')
              Blank()
              SymbolGlyph($r('sys.symbol.chevron_left'))
                .width(20)
                .height(20)
                .fontColor(['#999999'])
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              console.log('点击关于');
            })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#f5f5f5')

      // 底部菜单
      BottomMenuBar()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct BottomMenuBar {
  @State currentIndex: number = 1; // 默认选中"我"页面

  build() {
    Row() {
      // 文章菜单
      Column() {
        SymbolGlyph($r('sys.symbol.book_pages_fill'))
          .width(24)
          .height(24)
          .fontColor(this.currentIndex === 0 ?
            [$r('sys.color.ohos_id_color_text_primary_activated')] :
            [$r('sys.color.ohos_id_color_text_secondary')])
        Text('文章')
          .fontSize(12)
          .fontColor(this.currentIndex === 0 ?
            $r('sys.color.ohos_id_color_text_primary_activated') :
            $r('sys.color.ohos_id_color_text_secondary'))
          .margin({ top: 4 })
      }
      .flexGrow(1)
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .onClick(() => {
        if (this.currentIndex !== 0) {
          router.pushUrl({
            url: 'pages/Articles'

          }).catch(() => {
            console.error('导航到文章页面失败');
          });
        }
      })

      // 我的菜单
      Column() {
        SymbolGlyph($r('sys.symbol.person_fill'))
          .width(24)
          .height(24)
          .fontColor(this.currentIndex === 1 ?
            [$r('sys.color.ohos_id_color_text_primary_activated')] :
            [$r('sys.color.ohos_id_color_text_secondary')])
        Text('我')
          .fontSize(12)
          .fontColor(this.currentIndex === 1 ?
            $r('sys.color.ohos_id_color_text_primary_activated') :
            $r('sys.color.ohos_id_color_text_secondary'))
          .margin({ top: 4 })
      }
      .flexGrow(1)
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .onClick(() => {
        // 当前已在"我"页面，无需导航
      })
    }
    .width('100%')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .border({ width: { top: 1 }, color: '#e0e0e0' })
  }
}