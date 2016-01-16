//
//  SettingViewController.m
//  DoubierReader
//
//  Created by Zhixue Li on 12/3/15.
//  Copyright © 2015 Zhixue Li. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "otherViewController.h"
#import "MainViewController.h"
#import "LeftSlideViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"笑傲江湖";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"笑傲江湖";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"笑傲江湖";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"笑傲江湖";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"笑傲江湖";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"笑傲江湖";
    }else if (indexPath.row == 6){
        cell.textLabel.text = @"笑傲江湖";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    MainViewController *tempAppDelegate = (MainViewController *)[[UIApplication sharedApplication] delegate];
//    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:tempAppDelegate.main];
    otherViewController *otherset = [[otherViewController alloc] init];
//    [tempAppDelegate.LeftSlideVC closeLeftView];
    NSLog(@"ok");
    [self.mainNavigationController pushViewController:otherset animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
