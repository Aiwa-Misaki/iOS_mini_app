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
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *pulseButton;
@property (nonatomic, strong) clockView  *clockSelect;
@end


@implementation TomatoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initUserInterface];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}
-(void)initUI{
    self.clockSelect=[[clockView alloc] init];
    self.clockSelect.center=CGPointMake(self.view.center.x, 0.88*self.view.center.y);
    [self.view addSubview:self.clockSelect];
    [self.clockSelect setNeedsDisplay];
    self.startButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self initButton:_startButton buttontype:1];
    self.pulseButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self initButton:_pulseButton buttontype:2];
}
-(void)initButton:(UIButton*)button buttontype:(NSInteger)type{
    button.layer.cornerRadius =15;
    //设置属性
    CGPoint center=CGPointMake(0.5*self.view.bounds.size.width, 0.75*self.view.bounds.size.height);
    CGFloat height=65;
    CGFloat width=260;
    button.frame=CGRectMake(center.x-0.5*width, center.y-0.5*height, width, height);
    button.backgroundColor=[UIColor colorWithRed:155/255.0 green:144/255.0 blue:194/255.0 alpha:1.0];
    NSString *str=@"";
    if(type==0)
        str=@"SET";
    else if(type==1)
        str=@"START";
    else
        str=@"PULSE";
    [button setTitle:str forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setEnabled:YES];
    if(type==0)
        [button addTarget:self action:@selector(setButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    else if(type==1){
        [button addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden=NO;
    }
    else{
        [button addTarget:self action:@selector(pulseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden=YES;
    }
    [self.view addSubview:button];
    [button setNeedsDisplay];
}


- (void)startButtonClicked:(UIButton *)sender{
    _clockSelect.status=COUNTING;
    _startButton.hidden=!_startButton.hidden;
    _pulseButton.hidden=!_pulseButton.hidden;
    //渐变效果
    UIColor *originalColor=self.view.backgroundColor;
    UIColor *nextColor=[UIColor colorWithRed:88/255.0 green:178/255.0 blue:220/255.0 alpha:1.0];
    NSInteger changeTime=20;
    NSTimeInterval interval=1;
    CGFloat *originalRGB=CGColorGetComponents(originalColor.CGColor);
    CGFloat *nextRGB=CGColorGetComponents(nextColor.CGColor);
    UIColor *delta=[UIColor colorWithRed:(nextRGB[0]-originalRGB[0])/(changeTime/interval) green:(nextRGB[1]-originalRGB[1])/(changeTime/interval) blue:(nextRGB[2]-originalRGB[2])/(changeTime/interval) alpha:1.0];
    [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(colorChange:) userInfo:delta repeats:NO];
}

- (void)colorChange:(NSTimer *)timer{//这个UIColor都是增量
    UIColor *delta=[timer userInfo];
    CGFloat *originalRGB=CGColorGetComponents(self.view.backgroundColor.CGColor);
    CGFloat *deltaRGB=CGColorGetComponents(delta.CGColor);
    originalRGB[0]+=deltaRGB[0];
    originalRGB[1]+=deltaRGB[1];
    originalRGB[2]+=deltaRGB[2];
    [self.view setBackgroundColor:[UIColor colorWithRed:originalRGB[0] green:originalRGB[1] blue:originalRGB[2] alpha:1.0]];
    [self.view setNeedsDisplay];
}

- (void)pulseButtonClicked:(UIButton *)sender{
    _clockSelect.status=STOPPED;
    _pulseButton.hidden=!_pulseButton.hidden;
    _startButton.hidden=!_startButton.hidden;
}
// 触摸移动
- (void)touchesMoved:(UITapGestureRecognizer *)gesture{
    if(_clockSelect.status!=COUNTING){
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
    
}

- (void)initUserInterface{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)timeChange{
    if(_clockSelect.status==COUNTING){
        [_clockSelect timeMinus];
    }
}

@end
