//
//  clockView.h
//  my
//
//  Created by duck on 2021/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define PI 3.141592653
#define clock_radis 350
#define bear_width 50

typedef enum{
    NOT_START=0,
    COUNTING=1,
    STOPPED=2,
    ENDED=3
} CLOCK_STATUS;//计时状态

@interface clockView : UIView
@property (nonatomic,assign) CGFloat arc;//弧度,3:00为零点，顺时针为正
@property (nonatomic,assign) NSInteger remainSec;//剩余的秒数
@property (nonatomic,assign) CLOCK_STATUS status;//计时状态
@property (nonatomic,assign) UILabel* timeDisplay;//正中间显示的时间

- (void)drawRect:(CGRect)rect;

- (void)setArc:(CGFloat)degree;//设置度数并重绘

- (void)initUI;//初始化按钮和数字

@end

NS_ASSUME_NONNULL_END
