//
//  HeSettingVC.m
//  kunyuanseller
//
//  Created by Tony on 16/6/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeSettingVC.h"
#import "HeBaseTableViewCell.h"

@interface HeSettingVC ()
@property(strong,nonatomic)IBOutlet UITableView *settingTable;

@end

@implementation HeSettingVC
@synthesize settingTable;

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
        label.text = @"设置";
        [label sizeToFit];
        self.title = @"设置";
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
}

- (void)initView
{
    [super initView];
    [Tool setExtraCellLineHidden:settingTable];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeSettingCell";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeBaseTableViewCell *cell = (HeBaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor blackColor];
    
    
    
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
