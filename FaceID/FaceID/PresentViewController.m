//
//  PresentViewController.m
//  FaceID
//
//  Created by guojz on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PresentViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface PresentViewController ()
@property (nonatomic, strong)UITextField *textfield;
@property (nonatomic, strong)UIButton    *button;
@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, self.view.bounds.size.width-200, 30)];
    _textfield.placeholder = @"please input your password";
    _textfield.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textfield];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 150, self.view.bounds.size.width-200, 30);
    [_button setTitle:@"login" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];

}
- (void)loginButtonClick:(UIButton *)sender {
    if (self.faceIDResult) {
        self.faceIDResult(@"112233");
    }
//    [self dismissViewControllerAnimated:YES completion:nil];
    /**
     typedef NS_ENUM(NSInteger, LABiometryType)
     {
     /// The device does not support biometry.
     LABiometryTypeNone API_AVAILABLE(macos(10.13.2), ios(11.2)),
     LABiometryNone API_DEPRECATED_WITH_REPLACEMENT("LABiometryTypeNone", macos(10.13, 10.13.2), ios(11.0, 11.2)) = LABiometryTypeNone,
     
     /// The device supports Touch ID.
     LABiometryTypeTouchID,
     
     /// The device supports Face ID.
     LABiometryTypeFaceID API_UNAVAILABLE(macos),
     } API_AVAILABLE(macos(10.13.2), ios(11.0)) API_UNAVAILABLE(watchos, tvos);
     */
    //创建安全验证对象
    LAContext * context = [[LAContext alloc]init];
    NSError * error;
    //判断是否支持密码验证
    /**
     * LAPolicyDeviceOwnerAuthentication 可输入手机密码的验证方式
     * LAPolicyDeviceOwnerAuthenticationWithBiometrics 只有指纹的验证方式
     */
    
 
    BOOL can = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
//    context.biometryType =
    
    BOOL canAuthentication = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    
    if (canAuthentication) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证FaceID" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSLog(@"%@",error);
            }
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
