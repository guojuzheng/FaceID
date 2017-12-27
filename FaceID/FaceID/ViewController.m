//
//  ViewController.m
//  FaceID
//
//  Created by guojz on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
#import "SwichCell.h"
#define CellID       @"CellID"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    presentButton.frame = CGRectMake(100, 100, self.view.bounds.size.width-200 ,30);
//    [presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [presentButton setTitle:@"present a new view" forState:UIControlStateNormal];
//    [presentButton addTarget:self action:@selector(presentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:presentButton];

    _dataArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E", nil];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tableView registerClass:[SwichCell class] forCellReuseIdentifier:CellID];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwichCell *cell = [SwichCell cellWithTableView:tableView andReuseIdentifier:CellID];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",self.dataArray[indexPath.row]);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (void)presentButtonClick:(UIButton *)sender {
    PresentViewController *presentVC = [[PresentViewController alloc] init];
    presentVC.faceIDResult = ^(NSString *result) {
        NSLog(@"hahahaha%@",result);
    };
    [self presentViewController:presentVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
