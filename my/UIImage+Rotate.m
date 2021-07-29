//
//  UIImage+Rotate.m
//  my
//
//  Created by duck on 2021/7/29.
//

#import <Foundation/Foundation.h>
#import "UIImage+Rotate.h"

@implementation UIImage(Rotate)

- (UIImage*)rotateImageWithRadian:(CGFloat)radian cropMode:(SvCropMode)cropMode{
    {
        CGSize imgSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
        CGSize outputSize = imgSize;
        if (cropMode == enSvCropExpand) {
            CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
            rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(radian));
            outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
        }
        
        UIGraphicsBeginImageContext(outputSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
        CGContextRotateCTM(context, radian);
        CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
        
        [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}

@end
