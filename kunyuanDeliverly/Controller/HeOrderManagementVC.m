//
//  HeOrderManagementVC.m
//  kunyuanseller
//
//  Created by Tony on 16/6/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeOrderManagementVC.h"
#import "MJRefresh.h"
#import "HeOrderDetailVC.h"
#import "HeHandleOrderCell.h"

#define TextLineHeight 1.2f

@interface HeOrderManagementVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestReply; //是否请求已回复数据 1:未处理 2:今日订单  3:退单
}
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)UIView *sectionHeaderView;
@property(strong,nonatomic)NSMutableArray *dataSource;
@property(assign,nonatomic)NSInteger pageNo;

@end

@implementation HeOrderManagementVC
@synthesize tableview;
@synthesize sectionHeaderView;
@synthesize dataSource;
@synthesize pageNo;

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
        label.text = @"订单";
        [label sizeToFit];
        self.title = @"订单";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)initializaiton
{
    [super initializaiton];
    requestReply = 1;
    dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    pageNo = 1;
}

- (void)initView
{
    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor whiteColor];
    [Tool setExtraCellLineHidden:tableview];
    
    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    sectionHeaderView.userInteractionEnabled = YES;
    
    NSArray *buttonArray = @[@"抢单",@"已完成",@"配送中"];
    for (NSInteger index = 0; index < [buttonArray count]; index++) {
        CGFloat buttonW = SCREENWIDTH / [buttonArray count];
        CGFloat buttonH = sectionHeaderView.frame.size.height;
        CGFloat buttonX = index * buttonW;
        CGFloat buttonY = 0;
        CGRect buttonFrame = CGRectMake(buttonX , buttonY, buttonW, buttonH);
        UIButton *button = [self buttonWithTitle:buttonArray[index] frame:buttonFrame];
        button.tag = index + 100;
        if (index == 0) {
            button.selected = YES;
        }
        [sectionHeaderView addSubview:button];
    }
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block,刷新
        [self.tableview.header performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0];
    }];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.tableview.footer.automaticallyHidden = YES;
        self.tableview.footer.hidden = NO;
        // 进入刷新状态后会自动调用这个block，加载更多
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0];
    }];
}

- (void)endRefreshing
{
    [self.tableview.footer endRefreshing];
    self.tableview.footer.hidden = YES;
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.tableview.footer.automaticallyHidden = YES;
        self.tableview.footer.hidden = NO;
        // 进入刷新状态后会自动调用这个block，加载更多
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1.0];
    }];
}

- (UIButton *)buttonWithTitle:(NSString *)buttonTitle frame:(CGRect)buttonFrame
{
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:143.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[Tool buttonImageFromColor:[UIColor whiteColor] withImageSize:button.frame.size] forState:UIControlStateSelected];
    [button setBackgroundImage:[Tool buttonImageFromColor:sectionHeaderView.backgroundColor withImageSize:button.frame.size] forState:UIControlStateNormal];
    
    return button;
}

- (void)filterButtonClick:(UIButton *)button
{
    if ((requestReply == 1 && button.tag == 100) || (requestReply == 2 && button.tag == 101) || (requestReply == 3 && button.tag == 102)) {
        return;
    }
    switch (button.tag - 100) {
        case 0:
        {
            requestReply = 1;
            UIButton *button = [sectionHeaderView viewWithTag:100];
            button.selected = YES;
            button = [sectionHeaderView viewWithTag:101];
            button.selected = NO;
            button = [sectionHeaderView viewWithTag:102];
            button.selected = NO;
            break;
        }
        case 1:
        {
            requestReply = 2;
            UIButton *button = [sectionHeaderView viewWithTag:100];
            button.selected = NO;
            button = [sectionHeaderView viewWithTag:101];
            button.selected = YES;
            button = [sectionHeaderView viewWithTag:102];
            button.selected = NO;
            break;
        }
        case 2:
        {
            requestReply = 3;
            UIButton *button = [sectionHeaderView viewWithTag:100];
            button.selected = NO;
            button = [sectionHeaderView viewWithTag:101];
            button.selected = NO;
            button = [sectionHeaderView viewWithTag:102];
            button.selected = YES;
            break;
        }
        default:
            break;
    }
    [self loadMessageShow:YES];
}

- (void)loadMessageShow:(BOOL)show
{
    [tableview reloadData];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:@"detailOrder"]) {
        NSDictionary *orderDict = [[NSDictionary alloc] initWithDictionary:userInfo];
        HeOrderDetailVC *orderDetailVC = [[HeOrderDetailVC alloc] init];
        orderDetailVC.orderState = requestReply;
        orderDetailVC.orderBaseDict = [[NSDictionary alloc] initWithDictionary:orderDict];
        orderDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
        return;
    }
    [super routerEventWithName:eventName userInfo:userInfo];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString *cellIndentifier = @"HeMessageCellIndentifier";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    NSDictionary *orderDict = nil;
    //    @try {
    //        orderDict = [messageArray objectAtIndex:row];
    //    }
    //    @catch (NSException *exception) {
    //
    //    }
    //    @finally {
    //
    //    }
    
    HeHandleOrderCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeHandleOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize orderState:requestReply];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeaderView.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    //    UIFont *contentFont = [UIFont systemFontOfSize:16.0];
    //    MessageModel *messageModel = [messageArray objectAtIndex:row];
    //    CGFloat messageLabelW = SCREENWIDTH - 100;
    //    CGFloat messageLabelH = [MLLinkLabel getViewSizeByString:messageModel.messageContent maxWidth:messageLabelW font:contentFont lineHeight:TextLineHeight lines:0].height;
    //    if (messageLabelH < 20) {
    //        messageLabelH = 20;
    //    }
    //    CGFloat authorH = 20;
    //    CGFloat margin = 10;
    
    return 260;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
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
