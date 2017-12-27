//
//  PresentViewController.h
//  FaceID
//
//  Created by guojz on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FaceIDResultBlock)(NSString *result);
@interface PresentViewController : UIViewController
/**<有返回值,没有参数的block*/
@property (nonatomic, copy) FaceIDResultBlock faceIDResult;
@end
