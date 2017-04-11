//
//  AppDelegate.m
//  ASHEBShop
//
//  Created by xmfish on 17/3/15.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+CustomColor.h"
#import "ViewController.h"
#import "UIImage+ASHUtil.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <UMMobClick/MobClick.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initAliBC];
    [self initUMen];
//    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
//    nav.navigationBarHidden = YES;
//    self.window.rootViewController = nav;
    [self customSet];
    return YES;
}

- (void)initUMen
{
    UMConfigInstance.appKey = @"58ec79f9c62dca2aca001402";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
}
- (void)initAliBC{
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        NSLog(@"Init failed: %@", error.description);
    }];
    
    // 开发阶段打开日志开关，方便排查错误信息
    //默认调试模式打开日志,release关闭,可以不调用下面的函数
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];
    
    // 配置全局的淘客参数
    //如果没有阿里妈妈的淘客账号,setTaokeParams函数需要调用
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_49141657_22650840_74950410"; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    //设置全局的app标识，在电商模块里等同于isv_code
    //没有申请过isv_code的接入方,默认不需要调用该函数
//    [[AlibcTradeSDK sharedInstance] setISVCode:@"your_isv_code"];
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)customSet
{
    UINavigationBar * nav = [UINavigationBar appearance];
    UIImage* image = [UIImage ash_imageFromColor:[UIColor whiteColor] andSize:CGSizeMake(1, 1) opaque:0.2];
    image = [image imageByBlurWithTint:[UIColor mainColor]];
    [nav setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    nav.tintColor = [UIColor mainColor];
}
#pragma mark - open url
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    [[AlibcTradeSDK sharedInstance] application:app openURL:url options:options];
    return YES;
}
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    return [self application:application openURL:url options:@{}];
}
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return [self application:application openURL:url options:@{}];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
