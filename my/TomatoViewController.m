//
//  TomatoViewController.m
//  my
//
//  Created by duck on 2021/7/10.
//

#import "TomatoViewController.h"
#import "clockView.h"
#include "PopupView.h"

@interface TomatoViewController ()
@property (nonatomic, strong) clockView  *clockSelect;
@end


@implementation TomatoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initUserInterface];
    
}
-(void)initUI{
    self.clockSelect=[[clockView alloc] init];
    self.clockSelect.center=self.view.center;
    [self.view addSubview:self.clockSelect];
    [self.clockSelect setNeedsDisplay];
}
// 触摸移动
- (void)touchesMoved:(UITapGestureRecognizer *)gesture{
    static CGPoint tmpLoc;
    CGPoint location = [gesture locationInView: self.view];
    tmpLoc=CGPointMake(location.x, location.y);
    if(gesture.state==UIGestureRecognizerStateBegan){
    }else if(gesture.state==UIGestureRecognizerStateChanged){
        CGFloat deltax=location.x-self.clockSelect.center.x;
        CGFloat deltay=location.y-self.clockSelect.center.y;
        CGFloat arc=0;
        if(deltay==0){
            if(deltax>0)
                arc=0;
            else if(deltax<0)
                arc=PI;
        }else if(deltax>=0 && deltay<0){//第一象限
            arc=atan(fabs(deltax/deltay));
        }else if(deltax>=0 && deltay>0){//第二象限
            arc=PI-atan(deltax/deltay);
        }else if(deltax<=0 && deltay>0){//第三象限
            arc=PI+atan(fabs(deltax/deltay));
        }else{//第四象限
            arc=2*PI-atan(fabs(deltax/deltay));
        }
        CGFloat degree=arc*(180/PI);
//        NSLog(@"当前与12:00夹角为%.1f度",degree);
        _clockSelect.degree=degree;
        [self.clockSelect setArc:arc];
        
        //这里计算sin和cos值，传入和12:00的角度（顺时针为正，[0,360)）
    }else if (gesture.state==UIGestureRecognizerStateEnded){
        //这里修改arc和degree，变成时间是5的倍数
        //封装得不好，为什么要传两个一样的参数
        //五分钟为30度
        _clockSelect.degree=roundf(_clockSelect.degree/30.0)*30;
        [_clockSelect setArc:_clockSelect.degree/(360/(2*PI))];
//        NSLog(@"此处的arc为%.2f",_clockSelect.arc);
        //这边重绘
    }
    
}

-(void)initUserInterface{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    [self.view addGestureRecognizer:panGesture];
}



@end
