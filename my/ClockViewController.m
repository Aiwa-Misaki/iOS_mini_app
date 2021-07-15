//
//  ClockViewController.m
//  my
//
//  Created by duck on 2021/7/10.
//

#import "ClockViewController.h"

@interface ClockViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *tmpH;
@property (weak, nonatomic) IBOutlet UILabel *tmpM;

@end

@implementation ClockViewController

-(void) timeChange{
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSDateComponents *cmp = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger minute=cmp.minute;
    NSInteger hour=cmp.hour;
    NSString *str=[NSString stringWithFormat:@"%ld",(long)hour];
    if(hour<10) str=[NSString stringWithFormat:@"0%ld",(long)hour];
    NSString *str1=[NSString stringWithFormat:@"%ld",(long)minute];
    if(minute<10) str1=[NSString stringWithFormat:@"0%ld",(long)minute];
    
//    //动画组
//    self.img.contentMode = UIViewContentModeCenter;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<=9; i++) {
        [array addObject:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"bear%d.PNG",i]]];
    }
//设置动画数组图片
    self.img.animationImages = array;
    //设置一个动画的时长
    self.img.animationDuration = 0.5;
    //设置动画循环的次数（0是无线循环）
    self.img.animationRepeatCount = 1;
    //开始动画

    [self.img startAnimating];
    self.tmpH.alpha=100;
    self.tmpM.alpha=100;
    self.tmpH.text=str;
    self.tmpM.text=str1;
    
    self.img.image=[UIImage imageNamed:@"bear0.PNG"];

    
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.img.image=[UIImage imageNamed:@"bear1.JPG"];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    self.tmpH.font = [UIFont fontWithName:@"DBLCDTempBlack" size:50];
    self.tmpM.font = [UIFont fontWithName:@"DBLCDTempBlack" size:50];
    [self timeChange];
}


@end
