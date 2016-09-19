//
//  ViewController.m
//  XXQKeychainDemo
//
//  Created by 夏祥全 on 16/9/18.
//  Copyright © 2016年 夏祥全. All rights reserved.
//

#import "ViewController.h"
#import "WJKeychain.h"
#import "SSKeychain.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",[[NSUUID UUID] UUIDString]);
    
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    NSLog(@"%@",uuid);
    // Do any additional setup after loading the view, typically from a nib.

    [SSKeychain setPassword:@"123456" forService:@"com.xxq.XXQKeychainDemo3" account:@"uid"];
    
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"从服务端获取数据：%@",operation.responseString);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if ([urlCache isCached:[NSURL URLWithString:@"http://www.baidu.com"]]) {
//            
//        }
//        NSCachedURLResponse *resp = [urlCache cachedResponseForRequest:request];
//        NSString  *str = [[NSString alloc] initWithData:resp.data encoding:NSUTF8StringEncoding];
//        NSLog(@"从缓存中获取数据：%@",str);  
//    }];  
//    [operation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
