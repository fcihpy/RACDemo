//
//  LoginView.h
//  RACDemo
//
//  Created by locojoy on 16/1/27.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@protocol LoginViewDelegate <NSObject>

@optional

- (void)loginView:(LoginView *)loginView buttonSelect:(UIButton *)button;

@end




@interface LoginView : UIView

@property (weak, nonatomic) IBOutlet UITextField *usernameTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *passwdTextFeild;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,weak) id<LoginViewDelegate>delegate;

@property(nonatomic,assign)NSInteger age;

- (IBAction)loginButtonClick:(id)sender;

+ (instancetype)loginView;

@end
