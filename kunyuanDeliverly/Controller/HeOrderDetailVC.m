//
//  HeOrderDetailVC.m
//  kunyuanseller
//
//  Created by HeDongMing on 16/9/5.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeOrderDetailVC.h"
#import "HeBaseTableViewCell.h"
#import "UIButton+Bootstrap.h"

@interface HeOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)UIView *sectionHeaderView;
@property(strong,nonatomic)NSArray *deliveryIfnoArray;

@end

@implementation HeOrderDetailVC
@synthesize orderBaseDict;
@synthesize orderDetailDict;
@synthesize tableview;
@synthesize sectionHeaderView;
@synthesize deliveryIfnoArray;
@synthesize orderState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = APPDEFAULTTITLETEXTFONT;
        label.textColor = APPDEFAULTTITLECOLOR;
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"订单详情";
        [label sizeToFit];
        
        self.title = @"订单详情";
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
    deliveryIfnoArray = @[@"物品名称",@"物品重量",@"支付状态",@"备注"];
}

- (void)initView
{
    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor whiteColor];
    [Tool setExtraCellLineHidden:tableview];
    
    CGFloat headH = 90;
    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headH)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    sectionHeaderView.userInteractionEnabled = YES;
    
    CGFloat bgHeight = headH - 10;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, bgHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.userInteractionEnabled = YES;
    [sectionHeaderView addSubview:bgView];
    
    NSArray *titleArray = @[@"总金额",@"配送距离",@"下单时间"];
    NSArray *contentArray = @[@"8.0元",@"5.0公里",@"17:30"];
    
    
    CGFloat labelX = 0;
    CGFloat labelY = 10;
    CGFloat labelW = SCREENWIDTH / ((CGFloat)([titleArray count]));
    CGFloat labelH = (bgHeight - 2 * labelY) / 2.0;
    for (NSInteger index = 0; index < [titleArray count]; index++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.text = titleArray[index];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY + labelH, labelW, labelH)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor redColor];
        contentLabel.font = [UIFont systemFontOfSize:15.0];
        contentLabel.text = contentArray[index];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:contentLabel];
        
        CGFloat middleX = labelX + labelW - 1;
        CGFloat middleY = 20;
        CGFloat middleW = 2;
        CGFloat middleH = bgHeight - 2 * middleY;
        UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
        middleLine.backgroundColor = [UIColor grayColor];
        [bgView addSubview:middleLine];
        
        labelX = CGRectGetMaxX(middleLine.frame);
    }
    
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    [footerview setBackgroundColor:[UIColor colorWithWhite:237.0 / 255.0 alpha:1.0]];
    tableview.tableFooterView = footerview;
    footerview.userInteractionEnabled = YES;
    
    CGFloat detailX = 20;
    CGFloat detailY = 10;
    CGFloat detailW = SCREENWIDTH - 2 * detailX;
    CGFloat detailH = 40;
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, detailH)];
    [detailButton infoStyle];
    switch (orderState) {
        case 1:
        {
            [detailButton setTitle:@"立即接单" forState:UIControlStateNormal];
            [detailButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor orangeColor] withImageSize:detailButton.frame.size] forState:UIControlStateNormal];
            break;
        }
        case 2:
        {
            [detailButton setTitle:@"已完成" forState:UIControlStateNormal];
            [detailButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor grayColor] withImageSize:detailButton.frame.size] forState:UIControlStateNormal];
            break;
        }
        case 3:
        {
            [detailButton setTitle:@"配送中" forState:UIControlStateNormal];
            [detailButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor orangeColor] withImageSize:detailButton.frame.size] forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
    
    
    [detailButton addTarget:self action:@selector(detailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:detailButton];
}

- (void)detailButtonClick:(UIButton *)button
{
    NSLog(@"detailButtonClick");
}

- (void)chargeBackWithOption:(BOOL)agree
{

}

- (void)addressButtonClick:(UIButton *)button
{
    NSLog(@"addressButtonClick");
}

- (void)phoneButtonClick:(UIButton *)button
{
    NSLog(@"phoneButtonClick");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 3;
            break;
        }
        case 1:
        {
            return [deliveryIfnoArray count];
            break;
        }
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *cellIndentifier = @"HeBaseTableViewCell";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    NSDictionary *orderDict = nil;
    
    HeBaseTableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    NSString *getDistance = @"距3.0km";
                    NSString *receiveDistacne = @"距2.0km";
                    NSString *tipString = [NSString stringWithFormat:@"我  %@  取  %@  收",getDistance,receiveDistacne];
                    
                    //获取要调整颜色的文字位置,调整颜色
                    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc]initWithString:tipString];
                    NSRange range1 = [[hintString string] rangeOfString:getDistance];
                    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];;
                    //获取要调整颜色的文字位置,调整颜色
                    range1 = [[hintString string]rangeOfString:receiveDistacne];
                    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
                    
                    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 55, cellSize.height)];
                    tipLabel.backgroundColor = [UIColor clearColor];
                    tipLabel.textColor = [UIColor blackColor];
                    tipLabel.font = [UIFont systemFontOfSize:15.0];
                    tipLabel.text = tipString;
                    tipLabel.textAlignment = NSTextAlignmentCenter;
                    tipLabel.attributedText = hintString;
                    
                    [cell addSubview:tipLabel];
                    
                    CGFloat middleY = 20;
                    CGFloat middleW = 2;
                    CGFloat middleX = SCREENWIDTH - 50;
                    CGFloat middleH = cellSize.height - 2 *middleY;
                    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
                    middleLine.backgroundColor = [UIColor grayColor];
                    [cell addSubview:middleLine];
                    
                    
                    CGFloat imageW = 20;
                    CGFloat imageX = SCREENWIDTH - 10 - imageW;
                    CGFloat imageH = 25;
                    CGFloat imageY = (cellSize.height - imageH) / 2.0;
                    UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
                    [icon setBackgroundImage:[UIImage imageNamed:@"icon_address"] forState:UIControlStateNormal];
                    [icon addTarget:self action:@selector(addressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:icon];
                    
                    break;
                }
                case 1:
                {
                    CGFloat imageX = 10;
                    CGFloat imageW = 30;
                    CGFloat imageH = imageW;
                    CGFloat imageY = (cellSize.height - imageH) / 2.0;
                    
                    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
                    icon.image = [UIImage imageNamed:@"icon_get"];
                    [cell addSubview:icon];
                    
                    CGFloat labelX = CGRectGetMaxX(icon.frame) + 5;
                    CGFloat labelY = 5;
                    CGFloat labelH = (cellSize.height - 2 * labelY) / 2.0;
                    CGFloat labelW = SCREENWIDTH - labelX - 10 - 30;
                    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
                    nameLabel.backgroundColor = [UIColor clearColor];
                    nameLabel.textColor = [UIColor grayColor];
                    nameLabel.text = @"何栋明";
                    nameLabel.font = [UIFont systemFontOfSize:16.0];
                    nameLabel.textAlignment = NSTextAlignmentLeft;
                    [cell addSubview:nameLabel];
                    
                    labelY = CGRectGetMaxY(nameLabel.frame);
                    UILabel  *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW - 5, labelH)];
                    addressLabel.backgroundColor = [UIColor clearColor];
                    addressLabel.textColor = [UIColor grayColor];
                    addressLabel.numberOfLines = 2;
                    addressLabel.text = @"广东省珠海市优特科技大厦8楼单耳兔";
                    addressLabel.numberOfLines = 2;
                    addressLabel.font = [UIFont systemFontOfSize:15.0];
                    [addressLabel sizeToFit];
                    addressLabel.textAlignment = NSTextAlignmentLeft;
                    [cell addSubview:addressLabel];
                    
                    
                    CGFloat middleY = 20;
                    CGFloat middleW = 2;
                    CGFloat middleX = SCREENWIDTH - 50;
                    CGFloat middleH = cellSize.height - 2 *middleY;
                    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
                    middleLine.backgroundColor = [UIColor grayColor];
                    [cell addSubview:middleLine];
                    
                    
                    CGFloat iconW = 20;
                    CGFloat iconX = SCREENWIDTH - 10 - iconW;
                    CGFloat iconH = iconW;
                    CGFloat iconY = (cellSize.height - iconH) / 2.0;
                    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
                    [phoneButton setBackgroundImage:[UIImage imageNamed:@"icon_phone_blue"] forState:UIControlStateNormal];
                    phoneButton.tag = 1;
                    [phoneButton addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:phoneButton];
                    break;
                }
                case 2:
                {
                    CGFloat imageX = 10;
                    CGFloat imageW = 30;
                    CGFloat imageH = imageW;
                    CGFloat imageY = (cellSize.height - imageH) / 2.0;
                    
                    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
                    icon.image = [UIImage imageNamed:@"icon_send"];
                    [cell addSubview:icon];
                    
                    CGFloat labelX = CGRectGetMaxX(icon.frame) + 5;
                    CGFloat labelY = 5;
                    CGFloat labelH = (cellSize.height - 2 * labelY) / 2.0;
                    CGFloat labelW = SCREENWIDTH - labelX - 10 - 30;
                    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
                    nameLabel.backgroundColor = [UIColor clearColor];
                    nameLabel.textColor = [UIColor grayColor];
                    nameLabel.text = @"张先生";
                    nameLabel.font = [UIFont systemFontOfSize:16.0];
                    nameLabel.textAlignment = NSTextAlignmentLeft;
                    [cell addSubview:nameLabel];
                    
                    labelY = CGRectGetMaxY(nameLabel.frame);
                    UILabel  *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW - 5, labelH)];
                    addressLabel.backgroundColor = [UIColor clearColor];
                    addressLabel.textColor = [UIColor grayColor];
                    addressLabel.text = @"广东省珠海市优特科技大厦8楼单耳兔";
                    addressLabel.numberOfLines = 2;
                    [addressLabel sizeToFit];
                    addressLabel.font = [UIFont systemFontOfSize:15.0];
                    addressLabel.textAlignment = NSTextAlignmentLeft;
                    [cell addSubview:addressLabel];
                    
                    
                    CGFloat middleY = 20;
                    CGFloat middleW = 2;
                    CGFloat middleX = SCREENWIDTH - 50;
                    CGFloat middleH = cellSize.height - 2 *middleY;
                    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
                    middleLine.backgroundColor = [UIColor grayColor];
                    [cell addSubview:middleLine];
                    
                    
                    CGFloat iconW = 20;
                    CGFloat iconX = SCREENWIDTH - 10 - iconW;
                    CGFloat iconH = iconW;
                    CGFloat iconY = (cellSize.height - iconH) / 2.0;
                    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
                    [phoneButton setBackgroundImage:[UIImage imageNamed:@"icon_phone_orange"] forState:UIControlStateNormal];
                    phoneButton.tag = 2;
                    [phoneButton addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:phoneButton];
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        
        case 1:
        {
            CGFloat tipX = 10;
            CGFloat tipY = 0;
            CGFloat tipW = 80;
            CGFloat tipH = cellSize.height;
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipX, tipY, tipW, tipH)];
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.textColor = [UIColor grayColor];
            tipLabel.font = [UIFont systemFontOfSize:18.0];
            tipLabel.text = deliveryIfnoArray[row];
            tipLabel.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:tipLabel];
            switch (row) {
                case 0:
                {
                    CGFloat contentX = CGRectGetMaxX(tipLabel.frame);
                    CGFloat contentY = 0;
                    CGFloat contentW = SCREENWIDTH - 10 - contentX;
                    CGFloat contentH = cellSize.height;
                    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
                    contentLabel.backgroundColor = [UIColor clearColor];
                    contentLabel.textColor = [UIColor grayColor];
                    contentLabel.font = [UIFont systemFontOfSize:18.0];
                    contentLabel.text = @"羊肉粉";
                    contentLabel.textAlignment = NSTextAlignmentRight;
                    [cell addSubview:contentLabel];
                    
                    break;
                }
                case 1:
                {
                    CGFloat contentX = CGRectGetMaxX(tipLabel.frame);
                    CGFloat contentY = 0;
                    CGFloat contentW = SCREENWIDTH - 10 - contentX;
                    CGFloat contentH = cellSize.height;
                    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
                    contentLabel.backgroundColor = [UIColor clearColor];
                    contentLabel.textColor = [UIColor grayColor];
                    contentLabel.font = [UIFont systemFontOfSize:18.0];
                    contentLabel.text = @"1公斤";
                    contentLabel.textAlignment = NSTextAlignmentRight;
                    [cell addSubview:contentLabel];
                    break;
                }
                case 2:
                {
                    CGFloat contentX = CGRectGetMaxX(tipLabel.frame);
                    CGFloat contentY = 0;
                    CGFloat contentW = SCREENWIDTH - 10 - contentX;
                    CGFloat contentH = cellSize.height;
                    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
                    contentLabel.backgroundColor = [UIColor clearColor];
                    contentLabel.textColor = [UIColor grayColor];
                    contentLabel.font = [UIFont systemFontOfSize:18.0];
                    contentLabel.text = @"已支付";
                    contentLabel.textAlignment = NSTextAlignmentRight;
                    [cell addSubview:contentLabel];
                    break;
                }
                case 3:
                {
                    CGFloat contentX = CGRectGetMaxX(tipLabel.frame);
                    CGFloat contentY = 0;
                    CGFloat contentW = SCREENWIDTH - 10 - contentX;
                    CGFloat contentH = cellSize.height;
                    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
                    contentLabel.backgroundColor = [UIColor clearColor];
                    contentLabel.textColor = [UIColor grayColor];
                    contentLabel.font = [UIFont systemFontOfSize:18.0];
                    contentLabel.text = @"麻烦尽快";
                    contentLabel.textAlignment = NSTextAlignmentRight;
                    [cell addSubview:contentLabel];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return sectionHeaderView;
    }
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    headerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 10;
    }
    return sectionHeaderView.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0 ) {
        return 80;
    }
    return 50;
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
