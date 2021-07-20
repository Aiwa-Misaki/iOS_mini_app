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
    NSLog(@"clockView对象初始化完毕");
    return self;
}

- (void)drawRect:(CGRect)rect {

    UIColor *cutePink=[UIColor colorWithRed:221/255.0 green:199/255.0 blue:222/255.0 alpha:0];
    [cutePink setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, bear_width);
    CGContextAddArc(context, self.center.x-self.frame.origin.x,self.center.y-self.frame.origin.y, rect.size.width/2-bear_width, -0.5*PI,self.arc , 0);
    [[UIColor whiteColor] set];
      CGContextStrokePath(context);
    
    [self initUI];

}

- (void)setArc:(CGFloat)arc{//设置角度
    NSLog(@"%@", [NSString stringWithFormat:@"现在时钟的角度为%f",self.arc*(180/PI)]);
    _arc=(arc-PI/2);
    if(_arc>2*PI)
        _arc-=2*PI;
    [self setNeedsDisplay];
}

- (void)initUI{//初始化按钮和数字
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    NSString *str=[NSString stringWithFormat:@"趣味儿童与i哦怕是对方过后就哭了自行车v不能买"];//时间标签
    //字体属性
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont fontWithName:@"DBLCDTempBlack" size:50], NSFontAttributeName,
                               [UIColor colorWithRed:114/255.0f green:128/255.0f blue:137/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    [str drawAtPoint:CGPointMake(self.center.x, self.center.y) withAttributes:dict];
    NSLog(@"数字绘制完成！");
}

@end
