//
//  SwichCell.m
//  FaceID
//
//  Created by guojz on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SwichCell.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface SwichCell()
@property (nonatomic, strong)UILabel     *labelItem;
@property (nonatomic, strong)UISwitch    *switchItem;
@end
@implementation SwichCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView andReuseIdentifier:(NSString *)reuseIdentifier {
    SwichCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[SwichCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutUI];
//        [self configData];
    }
    return self;
}
- (void)layoutUI {
    self.labelItem = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, self.bounds.size.height)];
    [self addSubview:self.labelItem];
    
    self.switchItem = [[UISwitch alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 0, 50, self.bounds.size.height)];
    self.switchItem.on = NO;
    [self.switchItem addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.switchItem];
}
- (void)configData {
    LAContext * context = [[LAContext alloc]init];
    NSError * error;
    if (context.biometryType == LABiometryTypeNone) {
        self.labelItem.text = @"您的手机啥JB都不支持啊";
    } else if (context.biometryType == LABiometryTypeTouchID) {
        self.labelItem.text = @"您的手机支持TouchID";
    } else if (context.biometryType == LABiometryTypeFaceID) {
        self.labelItem.text = @"您的手机支持FaceID";
    }
}
- (void)switchAction:(id)sender  {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
//        self.labelItem.text = @"A";
        LAContext * context = [[LAContext alloc]init];
        NSError * error;
        BOOL canAuthentication = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
        
        if (canAuthentication) {
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证FaceID" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    self.labelItem.text = @"开启成功";
                } else {
                    NSLog(@"%@",error);
                    self.labelItem.text = @"开启失败";
                }
            }];
        }
    } else {
        self.labelItem.text = @"关闭";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
