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

@interface clockView : UIView
@property (nonatomic,assign) CGFloat arc;
- (void)drawRect:(CGRect)rect;

-(void)setArc:(CGFloat)degree;

@end

NS_ASSUME_NONNULL_END
