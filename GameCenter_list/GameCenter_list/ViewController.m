//
//  ViewController.m
//  GameCenter_list
//
//  Created by 毛韶谦 on 2016/10/3.
//  Copyright © 2016年 毛韶谦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加监听事件；
    [self registerFoeAuthenticationNotification];
    
    if ([self isGameCenterAvailable]) {
        
        [self authenticateLocalUser];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  GameCenter 的delegate 方法
 *
 *  @param  gameCenterViewController   GameCenter的控制器；
 *
 */
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    
    
}

//身份验证
- (void)authenticateLocalUser{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                // Get the default leaderboard identifier.
                
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        
                    }
                }];
            }
            
            else{
                
            }
        }
    };
    
}

//用户变更检测
- (void)registerFoeAuthenticationNotification{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}

- (void)authenticationChanged{
    if([GKLocalPlayer localPlayer].isAuthenticated){
        
    }else{
        
    }
}


/**
 *  判断设备是否支持GameCenter
 *
 *  @return YES 支持；
 *
 */
- (BOOL) isGameCenterAvailable {
    
    Class GKClass = NSClassFromString(@"GKLocalPlayer");
    
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    NSLog(@"GKClass = %@, currSysVer = %@",GKClass,currSysVer);
    return (GKClass && osVersionSupported);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
