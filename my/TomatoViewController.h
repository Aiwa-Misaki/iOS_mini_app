//
//  TomatoViewController.h
//  my
//
//  Created by duck on 2021/7/10.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TomatoViewController : UIViewController

// 触摸移动
- (void)touchesMoved:(UITapGestureRecognizer *)sender;
- (void)initUserInterface;
- (void)initUI;
- (void)initButton:(UIButton*)button buttontype:(NSInteger)type;
- (void)pulseButtonClicked:(UIButton *)sender;
- (void)startButtonClicked:(UIButton *)sender;
- (void)setButtonClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
