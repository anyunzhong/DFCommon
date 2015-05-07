//
//  DFCommonRegisterController.m
//  coder
//
//  Created by Allen Zhong on 15/5/7.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFCommonRegisterController.h"
#import "UIButton+Corner.h"

@interface DFCommonRegisterController()

@property (nonatomic,strong) UITextField *phoneNumTextField;
@property (nonatomic,strong) UITextField *verifyCodeTextField;
@property (nonatomic,strong) UIButton *verifyCodeButton;

@end


@implementation DFCommonRegisterController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
        self.title = @"注册";
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

-(void) initView
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    NSString *identifier = [NSString stringWithFormat:@"cell_%ld",(long)row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    switch (row) {
            case 0:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                UIImageView *phoneImageView = [self getIconImageView:@"phone_line_dark"];
                [cell.contentView addSubview:phoneImageView];
                
                _phoneNumTextField =[self getTextField];
                _phoneNumTextField.placeholder = @"手机号";
                [cell.contentView addSubview:_phoneNumTextField];
                
            }
            break;
        }
            case 1:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
                
                UIImageView *codeImageView = [self getIconImageView:@"more_line_dark"];
                [cell.contentView addSubview:codeImageView];
                
            
                
                _verifyCodeTextField = [self getTextField];
                _verifyCodeTextField.placeholder = @"验证码";
                [cell.contentView addSubview:_verifyCodeTextField];
                
                
                _verifyCodeButton = [UIButton cornerButton:[self mainColor] text:@"获取验证码" font:[UIFont systemFontOfSize:14]];
                _verifyCodeButton.frame = CGRectMake(self.view.frame.size.width-100, 16, 90, 30);
                [cell.contentView addSubview:_verifyCodeButton];
            }
            
            
            break;
        }
            case 2:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                
            }
            
            break;
        }
        default:
            break;
    }
    
    
    return cell;
    
}



-(UIImageView *) getIconImageView:(NSString *)icon
{
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15, 32, 32)];
    iconImageView.image = [UIImage imageNamed:icon];
    return iconImageView;
}

-(UITextField *) getTextField
{
    UITextField  *textField = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, self.view.frame.size.width, 60)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTextField.borderStyle = UITextBorderStyleNone;
    return textField;
}


-(UIColor *) mainColor
{
    return [UIColor darkGrayColor];
}

@end
