import { getDailyRecommend, getSwiper } from '../apis';
import { DailyRecommendType } from '../models/Index';

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
  @State dailyRecommend: DailyRecommendType[] = [];
  async aboutToAppear() {
    this.swiperList = await getSwiper() as string[];
    this.dailyRecommend = await getDailyRecommend() as DailyRecommendType[];
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

  @Builder
  titleBuilder(title: string) {
    Row() {
      // 标题
      Text(title)
        .fontColor('#fff')
        .fontWeight(700)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  dailyBuilder() {
    this.titleBuilder('每日推荐')
    Scroll() {
      Row({ space: 10 }) {
        ForEach(this.dailyRecommend, (item: DailyRecommendType) => {
          Column() {
            // 类型
            Text(item.type)
              .width('100%')
              .backgroundColor(item.top)
              .padding(8)
              .fontColor('#fff')
            // 封面图
            Image(item.img)
              .width('100%')
              .aspectRatio(1)
            // 标题
            Text(item.title)
              .width('100%')
              .backgroundColor(item.bottom)
              .padding(8)
              .fontColor('#fff')
              .fontSize(14)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(18)
          }
          .width('40%')
          .borderRadius(8)
          .clip(true)
        })
      }
    }
    .width('100%')
    .padding(8)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }


  build() {
    Scroll() {
      Column() {
        this.searchBuilder()
        this.swiperBuilder()
        this.dailyBuilder()
      }
      .constraintSize({ minHeight: '100%' })
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }


}

