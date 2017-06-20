//
//  LoginViewController.m
//  Pod
//
//  Created by Adam on 15/7/30.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self transLoginData:@"13524010590" passWord:@"123321"];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transLoginData:(NSString *)userName passWord:(NSString *)passWord
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:userName forKey:@"username"];
    [dataDict setObject:passWord forKey:@"password"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"userLogin"
                                                      dataDict:dataDict];
    
    [self showHUDWithText:@"正在加载"
                   inView:self.view
              methodBlock:^(ATMHudCompletionBlock completionBlock, ATMHud *hud)
     {
         
         [ZTHttpTool post:YCLJ_HOST_URL
                   params:paramDict
                  success:^(id json) {
                      
                      NSDictionary *backDic = json;
                      
                      if (backDic != nil) {
                          
                          NSString *errCodeStr = (NSString *)[backDic valueForKey:@"code"];
                          
                          if ( [errCodeStr integerValue] == 10000 ) {
                              
                              NSDictionary *resultDict = [backDic valueForKey:@"data"];
                              
                              NSString *userId = resultDict[@"user_id"];
                              NSString *mobile = resultDict[@"mobile"];
                              NSString *userName = resultDict[@"username"];
                              
                              NSLog(@"userId %@", userId);
                              NSLog(@"mobile %@", mobile);
                              NSLog(@"userName %@", userName);
                              
                        } else {
                            
                              [self showHUDWithText:[backDic valueForKey:@"msg"]];
                          }
                      }
                      
                      if (completionBlock) {
                          [hud hide];
                      }

                  } failure:^(NSError *error) {
                      
                      NSLog(@"请求失败-%@", error);
                      if (completionBlock) {
                          [hud hide];
                      }

                  }];
     }];
}

@end
