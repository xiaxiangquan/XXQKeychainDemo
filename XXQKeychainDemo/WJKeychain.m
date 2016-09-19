//
//  WJKeychain.m
//  XXQKeychainDemo
//
//  Created by 夏祥全 on 16/9/18.
//  Copyright © 2016年 夏祥全. All rights reserved.
//

#import "WJKeychain.h"

@implementation WJKeychain

+ (NSString *)getUDID {
    
    /*
    if (NSClassFromString(@"NSUUID")) {
        return [[NSUUID UUID] UUIDString];
    }
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    */
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword, (id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock, (id)kSecAttrAccessible, nil];
}

+ (void)saveDataForKey:(NSString *)key data:(id)data {
    [self save:key data:data];
}

+ (void)saveForToken:(NSString *)token uid:(NSString *)uid data:(id)data {
    NSString *key = [NSString stringWithFormat:@"%@%@",token, uid];
    [self save:key data:data];
}

+ (void)save:(NSString *)key data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)key {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = nil;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@",key, exception);
        } @finally {
            
        }
    }
    return ret;
}

+ (id)loadForToken:(NSString *)token uid:(NSString *)uid {
    NSString *key = [NSString stringWithFormat:@"%@%@",token, uid];
    NSLog(@"%@", [self getKeychainQuery:key]);

    return [self load:key];
}

+ (void)deleteKeyData:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (void)deleteForToken:(NSString *)token uid:(NSString *)uid {
    NSString *key = [NSString stringWithFormat:@"%@%@",token, uid];
    [self deleteKeyData:key];
}

+ (void)deleteKeychainDataForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}


@end

















