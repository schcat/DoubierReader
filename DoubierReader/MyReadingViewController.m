//
//  MyReadingViewController.m
//  DoubierReader
//
//  Created by Zhixue Li on 12/2/15.
//  Copyright © 2015 Zhixue Li. All rights reserved.
//

#import "MyReadingViewController.h"

@interface MyReadingViewController ()

@end

@implementation MyReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    NSLog(@"ok5");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"ok6");
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
