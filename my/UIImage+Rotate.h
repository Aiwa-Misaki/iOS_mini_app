//
//  UIImage+Rotate.h
//  my
//
//  Created by duck on 2021/7/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

enum {
    enSvCropClip,               // the image size will be equal to orignal image, some part of image may be cliped
    enSvCropExpand,             // the image size will expand to contain the whole image, remain area will be transparent
};
typedef NSInteger SvCropMode;


@interface UIImage (Rotate)

- (UIImage*)rotateImageWithRadian:(CGFloat)radian cropMode:(SvCropMode)cropMode;

@end

NS_ASSUME_NONNULL_END
