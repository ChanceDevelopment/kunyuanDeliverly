//
//  HeUserVC.m
//  kunyuanseller
//
//  Created by HeDongMing on 16/8/15.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeUserVC.h"
#import "HeBaseTableViewCell.h"
#import "HeFinanceAccountVC.h"
#import "HeCooperateShopVC.h"
#import "HeUserInfoVC.h"
#import "UIButton+Bootstrap.h"

#define USERHEADTAD 200
#define USERNAMETAG 300

@interface HeUserVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)NSArray *dataSource;

@end

@implementation HeUserVC
@synthesize tableview;
@synthesize dataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"我的";
        [label sizeToFit];
        self.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initializaiton
{
    [super initializaiton];
    dataSource = @[@"个人信息设置",@"合作商管理",@"账单"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUser:) name:@"updateUser" object:nil];
}

- (void)initView
{
    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:tableview];
    
    CGFloat headH = 180;
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headH)];
    headerview.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = headerview;
    
    CGFloat headBgH = headH;
    UIView *userHeadBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headBgH)];
    userHeadBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]];
    [headerview addSubview:userHeadBg];
    
    CGFloat imageW = 70;
    CGFloat imageH = imageW;
    CGFloat imageX = (SCREENWIDTH - imageW) / 2.0;
    CGFloat imageY = (headBgH - imageH) / 2.0 - 10;
    UIImageView *userHead = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    userHead.tag = USERHEADTAD;
    userHead.image = [UIImage imageNamed:@"userDefalut_icon"];
    [headerview addSubview:userHead];
    userHead.layer.borderWidth = 1.0;
    userHead.layer.borderColor = [UIColor whiteColor].CGColor;
    userHead.layer.masksToBounds = YES;
    userHead.layer.cornerRadius = imageW / 2.0;
    [userHeadBg addSubview:userHead];
    
    NSString *name = @"外卖体验店";
    CGFloat nameX = 0;
    CGFloat nameY = CGRectGetMaxY(userHead.frame);
    CGFloat nameW = SCREENWIDTH;
    CGFloat nameH = 30;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    nameLabel.tag = USERNAMETAG;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = name;
    nameLabel.font = [UIFont systemFontOfSize:16.0];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [userHeadBg addSubview:nameLabel];
    
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    footerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    tableview.tableFooterView = footerview;
    footerview.userInteractionEnabled = YES;
    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton dangerStyle];
    [logoutButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerview addSubview:logoutButton];
    [logoutButton addTarget:self action:@selector(logoutButtonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:logoutButton];
}

- (void)logoutButtonButtonClick:(UIButton *)button
{
    NSLog(@"logoutButtonButtonClick");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeBaseTableViewCell";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeBaseTableViewCell *cell = (HeBaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.text = dataSource[row];

    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    switch (row) {
        case 0:
        {
            HeUserInfoVC *userInfoVC = [[HeUserInfoVC alloc] init];
            userInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:userInfoVC animated:YES];
            break;
        }
        case 1:
        {
            HeCooperateShopVC *cooperateShopVC = [[HeCooperateShopVC alloc] init];
            cooperateShopVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cooperateShopVC animated:YES];
            
            break;
        }
        case 2:{
            HeFinanceAccountVC *financeAccountVC = [[HeFinanceAccountVC alloc] init];
            financeAccountVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:financeAccountVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    headerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
