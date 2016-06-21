//
//  HeFindPasswordVC.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/17.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeFindPasswordVC.h"
#import "UIButton+Bootstrap.h"

@interface HeFindPasswordVC ()<UITextFieldDelegate>
@property(strong,nonatomic)IBOutlet UITextField *acountField;
@property(strong,nonatomic)IBOutlet UITextField *passwordField;
@property(strong,nonatomic)IBOutlet UITextField *verifyField;
@property(strong,nonatomic)IBOutlet UIButton *getCodeButton;
@property(strong,nonatomic)IBOutlet UIButton *commitButton;

@end

@implementation HeFindPasswordVC
@synthesize acountField;
@synthesize passwordField;
@synthesize verifyField;
@synthesize getCodeButton;
@synthesize commitButton;

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
        label.text = @"找回密码";
        [label sizeToFit];
        self.title = @"找回密码";
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
    
    [getCodeButton dangerStyle];
    getCodeButton.layer.borderWidth = 0;
    getCodeButton.layer.borderColor = [UIColor clearColor].CGColor;
    [getCodeButton setBackgroundImage:[Tool buttonImageFromColor:APPDEFAULTORANGE withImageSize:getCodeButton.frame.size] forState:UIControlStateNormal];
    [getCodeButton.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    
    [commitButton dangerStyle];
    commitButton.layer.borderWidth = 0;
    commitButton.layer.borderColor = [UIColor clearColor].CGColor;
    [commitButton setBackgroundImage:[Tool buttonImageFromColor:APPDEFAULTORANGE withImageSize:commitButton.frame.size] forState:UIControlStateNormal];
}

- (IBAction)getCodeButtonClick:(id)sender
{

}

- (IBAction)commitButtonClick:(id)sender
{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
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
