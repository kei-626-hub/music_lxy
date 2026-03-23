import { getSwiper } from '../apis';

@Component
export default struct Recommend {
  @Builder
  searchBuilder() {
    Row() {
      Row({ space:  5 }) {
        // 左侧的放大镜图标
        Image($r('app.media.ic_search'))
          .width(20)
          .fillColor('#7e7e7c')
        // 搜索框
        TextInput({ placeholder: '搜索歌曲' })
          .padding({ left: 3, top: 0, bottom: 0, right: 0} )
          .placeholderColor('#7e7e7c')
          .layoutWeight(1)
        // 右侧的扫二维码图标
        Image($r('app.media.ic_code'))
          .width(22)
          .fillColor('#7e7e7c')
      }
      .width('100%')
      .height(35)
      .backgroundColor('#2d2b29')
      .borderRadius(20)
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .padding({ top: 15, bottom: 10, left: 8, right: 8 })
  }

  @State swiperList: string[] = [];
  async aboutToAppear() {
    this.swiperList = await getSwiper() as string[];
  }
  @Builder
  swiperBuilder() {
    Swiper() {
      ForEach(this.swiperList, (item: string) => {
        Image(item)
          .width('100%')
          .aspectRatio(720 / 330)
          .borderRadius(8)
      })
    }
    .padding(8)
    .width('100%')
    .autoPlay(true)
  }

  build() {
    Scroll() {
      Column() {
        this.searchBuilder()
        this.swiperBuilder()
      }
      .constraintSize({ minHeight: '100%' })
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }


}

