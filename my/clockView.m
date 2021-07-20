//
//  clockView.m
//  my
//
//  Created by duck on 2021/7/15.
//

#import "clockView.h"
#include "UIView+FrameMethods.h"



@implementation clockView

-(clockView *)init{
    self=[super init];
    [self setWidth:clock_radis];
    [self setHeight:clock_radis];
    self.arc=0;
    NSLog(@"clockView对象初始化完毕");
    return self;
}

- (void)drawRect:(CGRect)rect {

    UIColor *cutePink=[UIColor colorWithRed:221/255.0 green:199/255.0 blue:222/255.0 alpha:10];
    [[UIColor systemGrayColor] setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, bear_width);
    CGContextAddArc(context, self.center.x-self.frame.origin.x,self.center.y-self.frame.origin.y, rect.size.width/2-bear_width, -0.5*PI,self.arc , 0);
    [[UIColor whiteColor] set];
      CGContextStrokePath(context);

}

-(void)setArc:(CGFloat)arc{//设置角度
    NSLog(@"%@", [NSString stringWithFormat:@"现在时钟的角度为%f",self.arc*(180/PI)]);
    _arc=(arc-PI/2);
    if(_arc>2*PI)
        _arc-=2*PI;
    [self setNeedsDisplay];
}

@end
