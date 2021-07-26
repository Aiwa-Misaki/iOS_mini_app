//
//  clockView.m
//  my
//
//  Created by duck on 2021/7/15.
//

#import "clockView.h"
#include "UIView+FrameMethods.h"



@implementation clockView

- (clockView *)init{
    self=[super init];
    [self setWidth:clock_radis];
    [self setHeight:clock_radis];
    self.arc=0;
    self.remainSec=0;
    self.status=NOT_START;
    return self;
}

- (void)drawRect:(CGRect)rect {
    //界面背景：粉色
    UIColor *cutePink=[UIColor colorWithRed:221/255.0 green:199/255.0 blue:222/255.0 alpha:1];
    [cutePink setFill];
    UIRectFill(rect);
    //圆形背景：浅粉
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, bear_width*3);
    CGContextAddArc(ctx, self.center.x-self.frame.origin.x,self.center.y-self.frame.origin.y, rect.size.width/2-2*bear_width, 0,2*PI , 0);
    [[UIColor colorWithWhite:30 alpha:0.4] set];
      CGContextStrokePath(ctx);
    //绘制根据arc角度绘制的圆弧
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, bear_width);
    CGContextAddArc(context, self.center.x-self.frame.origin.x,self.center.y-self.frame.origin.y, rect.size.width/2-bear_width, -0.5*PI,self.arc , 0);
    [[UIColor whiteColor] set];
      CGContextStrokePath(context);
    //根据arc来设定秒数
    if(_status==NOT_START||_status==STOPPED){
        _remainSec=(_degree/360)*3600;
    }else if(_status==COUNTING){
        
    }

    //绘制中间的时间标签
    [self initUI];
    //绘制按钮

}

- (void)setArc:(CGFloat)arc{//设置角度 这个arc是从12:00开始的
    _arc=(arc-PI/2);
    if(_arc>2*PI)
        _arc-=2*PI;
    [self setNeedsDisplay];
}

- (void)initUI{//打印label
    [self timeChange];
    //字体属性
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont fontWithName:@"DBLCDTempBlack" size:50], NSFontAttributeName,
                               [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    //绘制，指定左上角坐标和字体属性
    [_timeDisplay drawAtPoint:CGPointMake(self.center.x-self.frame.origin.x-65, self.center.y-self.frame.origin.y-22) withAttributes:dict];

}

-(void) timeChange{//修改要显示的label
    //首先计算出分、秒
    NSInteger second=_remainSec % 60;
    NSInteger minute=(_remainSec-second)/60;
    NSString *s=[NSString stringWithFormat:@"%ld",(long)second];
    NSString *m=[NSString stringWithFormat:@"%ld",(long)minute];
    if(second<10) s=[NSString stringWithFormat:@"0%@",s];
    if(minute<10) m=[NSString stringWithFormat:@"0%@",m];
    _timeDisplay=[NSString stringWithFormat:@"%@:%@",m,s];
    //修改arc和degree
}

- (void)timeMinus{
    _remainSec=_remainSec-1;
    NSLog(@"%ld",_remainSec);
    [self calcDegArc];
    [self setNeedsDisplay];
}

- (void)calcDegArc{
    _arc=(_remainSec/10)/(180/PI);
    _arc-=0.5*PI;
}

@end
