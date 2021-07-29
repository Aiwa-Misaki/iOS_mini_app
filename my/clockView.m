//
//  clockView.m
//  my
//
//  Created by duck on 2021/7/15.
//

#import "clockView.h"
#import "UIView+FrameMethods.h"
#import "UIImage+Rotate.h"



@implementation clockView

- (clockView *)init{//初始化函数
    self=[super init];
    //根据屏幕大小初始化radius和bear_width
    _clock_radius=UIScreen.mainScreen.bounds.size.width*0.4;
    _bear_width=_clock_radius*0.3;
    [self setWidth:_clock_radius*2];
    [self setHeight:_clock_radius*2];
    self.arc=0;
    self.remainSec=0;
    self.status=NOT_START;
    [self timeChange];
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 400)];
    [_timeLabel setText:_timeDisplay];
    [_timeLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:(NSInteger)(_clock_radius/3.5)]];
    [_timeLabel setCenter:CGPointMake(self.center.x-self.frame.origin.x, self.center.y-self.frame.origin.y)];
    [_timeLabel setTextAlignment:NSTextAlignmentCenter];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_timeLabel];
    return self;
}

- (void)drawRect:(CGRect)rect {//paint函数，每次重绘时自动调用
    //界面背景：粉色
    UIColor *cutePink=[UIColor colorWithRed:221/255.0 green:199/255.0 blue:222/255.0 alpha:1];
    [cutePink setFill];
    UIRectFill(rect);
    //圆形背景：浅粉
    [self drawArc:rect];
    //根据arc来设定秒数
    if(_status==NOT_START||_status==STOPPED){
        _remainSec=(_degree/360)*3600;
    }else if(_status==COUNTING){
        
    }
    //绘制熊头
    [self timeChange];
}

- (void)drawArc:(CGRect)rect{//绘制圆弧及其背景
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    NSInteger circle_radius=_clock_radius*2-_bear_width;
    CGRect aRect= CGRectMake(self.center.x-self.frame.origin.x-circle_radius/2,self.center.y-self.frame.origin.y-circle_radius/2,circle_radius,circle_radius);
    [[UIColor colorWithWhite:30 alpha:0.4] set];
    CGContextFillEllipseInRect(ctx, aRect);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //绘制根据arc角度绘制的圆弧
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _bear_width);
    CGContextAddArc(context, self.center.x-self.frame.origin.x,self.center.y-self.frame.origin.y, rect.size.width/2-_bear_width, -0.5*PI,self.arc , 0);
    [[UIColor whiteColor] set];
      CGContextStrokePath(context);
}

- (UIImage*)getRotatedBear{//旋转熊头（按照图片中心
    //arc和本体的arc一致
    CGFloat rotateArc=self.arc;
    UIImage *head = [UIImage imageNamed:@"bearHead.png"];
    return [head rotateImageWithRadian:rotateArc cropMode:enSvCropExpand];
}

- (void)drawBear{//绘制熊头
    UIImage *rotatedBear=[self getRotatedBear];
    NSInteger radius=_clock_radius+_bear_width;
    CGFloat normalArc=self.arc;//转换为12:00开始的arc值
    if(normalArc<0) normalArc+=2*PI;
    //画图基准点在左上角，往左上挪动
    
    [rotatedBear drawAtPoint:CGPointMake(self.center.x-self.frame.origin.x, self.center.y-self.frame.origin.y)];
}

- (void)setArc:(CGFloat)arc{//设置角度 这个arc是从12:00开始的
    _arc=(arc-PI/2);
    if(_arc>2*PI)
        _arc-=2*PI;
    [self setNeedsDisplay];
}

- (void)timeChange{//修改要显示的label
    //首先计算出分、秒
    NSInteger second=_remainSec % 60;
    NSInteger minute=(_remainSec-second)/60;
    NSString *s=[NSString stringWithFormat:@"%ld",(long)second];
    NSString *m=[NSString stringWithFormat:@"%ld",(long)minute];
    if(second<10) s=[NSString stringWithFormat:@"0%@",s];
    if(minute<10) m=[NSString stringWithFormat:@"0%@",m];
    _timeDisplay=[NSString stringWithFormat:@"%@:%@",m,s];
    NSLog(_timeDisplay);
    [_timeLabel setText:_timeDisplay];
    //修改arc和degree
}

- (void)timeMinus{
    if(self.remainSec>0){
        _remainSec=_remainSec-1;
        [self calcDegArc];
        [self timeChange];
        [self setNeedsDisplay];
    }
}

- (void)calcDegArc{
    _arc=(_remainSec/10)/(180/PI);
    _arc-=0.5*PI;
}

@end
