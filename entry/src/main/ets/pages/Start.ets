import { router } from '@kit.ArkUI';
import { SAFE_TOP, SAFE_BOTTOM } from '../contants';

@Entry
@Component
struct Start {
  @StorageProp(SAFE_TOP) safeTop: number = 0;
  private timerId: number | null = null;

  aboutToAppear(): void {
    console.info('[Start] aboutToAppear: 创建定时器，5秒后跳转首页');
    // 5秒后自动跳转到首页
    this.timerId = setTimeout(() => {
      router.replaceUrl({ url: 'pages/Index' });
    }, 5000);
  }

  aboutToDisappear(): void {
    if (this.timerId !== null) {
      console.info('[Start] aboutToDisappear: 清除定时器');
      // 清除定时器
      clearTimeout(this.timerId);
      this.timerId = null;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r('app.media.ad'))
      Button('跳')
        .margin({ top: this.safeTop + 10, right: 10 })
        .backgroundColor('#4d000000')
        .onClick(() => {
          console.info('[Start] 点击跳过按钮，立即跳转首页');
          router.replaceUrl({ url: 'pages/Index' });
        })
    }
  }  