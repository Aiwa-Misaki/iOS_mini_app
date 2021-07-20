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
-(void)initUserInterface;
-(void)initUI;

@end

NS_ASSUME_NONNULL_END
