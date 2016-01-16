//
//  MainViewController.m
//  DoubierReader
//
//  Created by Zhixue Li on 12/2/15.
//  Copyright © 2015 Zhixue Li. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "SettingViewController.h"
#define vBackBarButtonItemName  @"backArrow.png"

@interface MainViewController () <LSYViewPagerVCDataSource,LSYViewPagerVCDelegate>
{
    CGFloat _scalef;
}

@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic, strong) SettingViewController *settingview;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@property (nonatomic, strong) SearchingViewController *searchingview;

@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, strong) NSArray *headArray;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) CGFloat speedf;
@property (nonatomic,strong) UITableView *leftTableview;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic, assign) BOOL closed;
@property (nonatomic, strong) UITapGestureRecognizer *sideslipTapGes;

@property (nonatomic, strong) UITextField *text1_edit;
@property (nonatomic, strong) UITextField *text2_edit;

@end

@implementation MainViewController

-(void)loadView
{
    [super loadView];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主界面";
    self.speedf = vSpeedFloat;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = [[UIScreen mainScreen] bounds];
//    self.navigationController.title = @"逗比读书";
    //侧滑菜单按钮
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(22.5, 25, 30, 20);
    [menuBtn setBackgroundColor:[UIColor grayColor]];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBtn];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    //放大镜按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(322.5, 25, 30, 20);
    [searchBtn setBackgroundColor:[UIColor grayColor]];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBtn];
    [self.view setAutoresizesSubviews:NO];
    self.titleArray = @[@"我的", @"寻找", @"书评"];
        
    self.findingview = [[FindingViewController alloc] init];
 //   [self.findingview.view setFrame:CGRectMake(0, 50, 320, 518)];
    
    self.readingnotesview = [[ReadingNotesViewController alloc] init];
 //   [self.readingnotesview.view setFrame:CGRectMake(0, 50, 320, 518)];
    
    self.myreadingview = (MyReadingViewController *)[[UIViewController alloc] init];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageview.image = [UIImage imageNamed:@"IMG_4203"];
    [self.myreadingview.view addSubview:imageview];
    
    UILabel *text1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 130, 30)];
    text1.backgroundColor = [UIColor clearColor];
    text1.font = [UIFont fontWithName:@"Arial" size:20.0f];
    text1.textColor = [UIColor blackColor];
    text1.text = @"在读";
    [self.myreadingview.view addSubview:text1];
    
    _text1_edit = [[UITextField alloc] initWithFrame:CGRectMake(200, 180, 130, 30)];
    _text1_edit.borderStyle = UITextBorderStyleLine;
    _text1_edit.backgroundColor = [UIColor clearColor];
    _text1_edit.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _text1_edit.textColor = [UIColor blackColor];
    [self.myreadingview.view addSubview:_text1_edit];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.myreadingview.view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *text2 = [[UILabel alloc] initWithFrame:CGRectMake(200, 220, 130, 30)];
    text2.backgroundColor = [UIColor clearColor];
    text2.font = [UIFont fontWithName:@"Arial" size:20.0f];
    text2.textColor = [UIColor blackColor];
    text2.text = @"位置";
    [self.myreadingview.view addSubview:text2];

    _text2_edit = [[UITextField alloc] initWithFrame:CGRectMake(200, 250, 130, 30)];
    _text2_edit.borderStyle = UITextBorderStyleLine;
    _text2_edit.backgroundColor = [UIColor clearColor];
    _text2_edit.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _text2_edit.textColor = [UIColor blackColor];
    [self.myreadingview.view addSubview:_text2_edit];
 //   [self.myreadingview.view setFrame:CGRectMake(0, 50, 320, 518)];
 //   self.myreadingview.view.backgroundColor = [UIColor greenColor];
    
 //   self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
 //   [self.myreadingview.view addGestureRecognizer:self.pan];
    
    self.delegate = self;
    self.dataSource = self;

    [self reload];
    // Do any additional setup after loading the view from its nib.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_text1_edit resignFirstResponder];
    [_text2_edit resignFirstResponder];
}

#pragma View Pager Data Source
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager
{
    return 3;
}

-(UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index
{
    if (index == 0) {
        return self.myreadingview;
    }else if(index == 1){
        return self.findingview;
    }else{
        return self.readingnotesview;
    }
}

-(CGFloat)heightForHeaderOfViewPager:(LSYViewPagerVC *)viewPager
{
    return 100;
}
-(CGFloat)heightForTitleOfViewPager:(LSYViewPagerVC *)viewPager
{
    return 30;
}

-(NSString *)viewPager:(LSYViewPagerVC *)viewPager titleWithIndexOfViewControllers:(NSInteger)index
{
    return self.titleArray[index];
}

#pragma View Pager Delegate
-(void)viewPagerViewController:(LSYViewPagerVC *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ViewController
{
    
}
-(void)viewPagerViewController:(LSYViewPagerVC *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
//    self.myreadingview.view.bounds = self.view.bounds;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void) handlePan: (UIPanGestureRecognizer *)rec{

//    NSLog(@"speedf = %f", self.speedf);
//    NSLog(@"scalef = %f", _scalef);
    CGPoint point = [rec translationInView:self.view];
    _scalef = (point.x * self.speedf + _scalef);
//        NSLog(@"pointx = %f", point.x);
    
    BOOL needMoveWithTap = YES;  //是否还需要跟随手指移动
    if (((self.myreadingview.view.x <= 0) && (_scalef <= 0)) || ((self.myreadingview.view.x >= (kScreenWidth - kMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
//    NSLog(@"%@", (self.myreadingview.view.x <= 0)?@"YES":@"NO");
//    NSLog(@"%@", (_scalef <= 0)?@"YES":@"NO");
    //根据视图位置判断是左滑还是右边滑动
//    NSLog(@"sss");
//    NSLog(@"%@", needMoveWithTap?@"YES":@"NO");

    if (needMoveWithTap && (rec.view.frame.origin.x >= 0) && (rec.view.frame.origin.x <= (kScreenWidth - kMainPageDistance)))
    {
        CGFloat recCenterX = rec.view.center.x + point.x * self.speedf;
        if (recCenterX < kScreenWidth * 0.5 - 2) {
            recCenterX = kScreenWidth * 0.5;
        }
//        NSLog(@"yyy");
        CGFloat recCenterY = rec.view.center.y;
        
        rec.view.center = CGPointMake(recCenterX,recCenterY);
        
        //scale 1.0~kMainPageScale
             CGFloat scale = 1 - (1 - kMainPageScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
              rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        NSLog(@"%f",leftTabCenterX);
        
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        self.leftTableview.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.contentView.alpha = tempAlpha;
        
    }
    else
    {
        //超出范围，
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (self.view.x < 0)
        {
            [tempAppDelegate.LeftSlideVC closeLeftView];
            _scalef = 0;
        }
        else if (self.view.x > (kScreenWidth - kMainPageDistance))
        {
            [tempAppDelegate.LeftSlideVC openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded) {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.closed)
            {
                [tempAppDelegate.LeftSlideVC openLeftView];
            }
            else
            {
                [tempAppDelegate.LeftSlideVC closeLeftView];
            }
        }
        else
        {
            if (self.closed)
            {
                [tempAppDelegate.LeftSlideVC closeLeftView];
            }
            else
            {
                [tempAppDelegate.LeftSlideVC openLeftView];
            }
        }
        _scalef = 0;
    }
}



#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded)) //如果左侧抽屉是开的，而且手势已经识别完毕
    {
        [UIView beginAnimations:nil context:nil]; //开始动画块
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0); //对点击的视图进行缩放形变
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2); //中心位置
        self.closed = YES; //关闭左视图
        
        self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5); //与初始化时一样的缩放形变
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        self.contentView.alpha = kLeftAlpha; //蒙板的最大值
        
        [UIView commitAnimations]; //结束动画块
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [self.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.myreadingview.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
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
