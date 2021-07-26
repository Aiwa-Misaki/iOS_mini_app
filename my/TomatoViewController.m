//
//  TomatoViewController.m
//  my
//
//  Created by duck on 2021/7/10.
//

#import "TomatoViewController.h"
#import "clockView.h"
#import "myButton.h"
#include "PopupView.h"

@interface TomatoViewController ()
@property (nonatomic, strong) UIButton *setButton;//这个可以封装一下
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *pulseButton;
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
    [self initButton:_setButton];

}
-(void)initButton:(UIButton*)button{
    button=[UIButton buttonWithType:UIButtonTypeRoundedRect];//圆角按钮
    button.layer.cornerRadius =15;
    //设置属性
    CGPoint center=CGPointMake(0.5*self.view.bounds.size.width, 0.75*self.view.bounds.size.height);
    NSLog(@"%@",NSStringFromCGPoint(center));
    CGFloat height=65;
    CGFloat width=260;
    button.frame=CGRectMake(center.x-0.5*width, center.y-0.5*height, width, height);
    button.backgroundColor=[UIColor colorWithRed:155/255.0 green:144/255.0 blue:194/255.0 alpha:1.0];
    [button setTitle:@"SET" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setEnabled:YES];
    [self.view addSubview:button];
    [button setNeedsDisplay];
    NSLog(@"button init!");
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
        _clockSelect.degree=degree;
        [self.clockSelect setArc:arc];
        //这里计算sin和cos值，传入和12:00的角度（顺时针为正，[0,360)）
    }else if (gesture.state==UIGestureRecognizerStateEnded){
        //这里修改arc和degree，变成时间是5的倍数
        //五分钟为30度
        _clockSelect.degree=roundf(_clockSelect.degree/30.0)*30;
        [_clockSelect setArc:_clockSelect.degree/(360/(2*PI))];
        //这边重绘
    }
    
}

-(void)initUserInterface{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    [self.view addGestureRecognizer:panGesture];
}

@end
