//
//  LoginView.m
//  RACDemo
//
//  Created by locojoy on 16/1/27.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

+ (instancetype)loginView{
    return [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil][0];
}



- (IBAction)loginButtonClick:(id)sender {
    
    NSLog(@"loginButton进行了点击");
    
    if (_delegate && [_delegate respondsToSelector:@selector(loginView:buttonSelect:)]) {
        [_delegate loginView:self buttonSelect:sender];
    }
    self.age ++;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ageChange" object:@{@"age--":@(self.age)}];
}
@end
