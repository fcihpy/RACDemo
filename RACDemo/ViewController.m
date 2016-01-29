//
//  ViewController.m
//  RACDemo
//
//  Created by locojoy on 16/1/26.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import "ViewController.h"
#import "LoginView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()<LoginViewDelegate>

@property (nonatomic,strong) LoginView *loginView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView = [LoginView loginView];
    [self.view addSubview:self.loginView];
   
    //1、KVO方法
//    [self kvo];
    
    //2、通知方法
//    [self notify];
    
    //3、事件处理
//    [self event];
    
    //4、delegate
//    [self delegate];
    
    //5、文本框变化
//    [self textChange];
    
    
    //6、将文本变化绑定到label上
//    [self bindChange];
    
    // 7.处理多个请求，都返回结果的时候，统一做处理.
    [self handMutiEvent];
}

- (void)kvo{
    //rac
    [[self.loginView rac_valuesAndChangesForKeyPath:@"age" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"rac_KVO 监听到了-值的变化 %@",x);
    }];
    //系统
//    [self.loginView addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)notify{
    //rac
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"ageChange" object:nil] subscribeNext:^(id x) {
          NSLog(@"rac_notify 监听到了-按钮被点击了,且数值变化  %@",x);
    }];
    //系统
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ageChangeNotify:) name:@"ageChange" object:nil];
}

- (void)event{
    //rac
    [[self.loginView.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         NSLog(@"rac_event监听到了-按钮被点击了");
    }];
    //系统
    [self.loginView.submitButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)delegate{
    //rac
    //loginButtonClick是被监听的事件方法
    [[self.loginView rac_signalForSelector:@selector(loginButtonClick:)] subscribeNext:^(id x) {
         NSLog(@"rac_delegate监听到了-按钮被点击了");
    }];
    //系统
//    self.loginView.delegate = self;
}

//直接监听文本框变化
- (void)textChange{
    [self.loginView.usernameTextFeild.rac_textSignal subscribeNext:^(id x) {
         NSLog(@"文字改变了%@",x);
    }];
    
}

//将文本变化绑定到label上
- (void)bindChange{
    
    RAC(self.loginView.contentLabel,text) = self.loginView.usernameTextFeild.rac_textSignal;
}

- (void)handMutiEvent{
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(updateUIWithS1:s2:) withSignalsFromArray:@[request1,request2]];
    
}


#pragma mark  buttonDelegate
- (void)loginView:(LoginView *)loginView buttonSelect:(UIButton *)button{
    
}

// 更新UI
- (void)updateUIWithS1:(id)s1Data s2:(id)s2Data{
     NSLog(@"更新UI%@-- %@",s1Data,s2Data);
}

#pragma mark buttonDevent
- (void)buttonClick{
    
}


#pragma mark  kvo监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"kvo监听值 %@",change);
}

#pragma mark  通知监听
- (void)ageChangeNotify:(NSNotification *)notify{
    NSDictionary *dict = notify.object;
    NSLog(@"系统通知 %@",dict);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.loginView.age ++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
