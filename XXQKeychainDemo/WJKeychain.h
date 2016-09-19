//
//  WJKeychain.h
//  XXQKeychainDemo
//
//  Created by 夏祥全 on 16/9/18.
//  Copyright © 2016年 夏祥全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJKeychain : NSObject


+ (void)saveDataForKey:(NSString *)key data:(id)data;
+ (void)saveForToken:(NSString *)token uid:(NSString *)uid data:(id)data;

+ (id)loadForToken:(NSString *)token uid:(NSString *)uid;
+ (id)load:(NSString *)service;
+ (void)deleteForToken:(NSString *)token uid:(NSString *)uid;
+ (void)deleteKeychainDataForKey:(NSString *)key;


@end
