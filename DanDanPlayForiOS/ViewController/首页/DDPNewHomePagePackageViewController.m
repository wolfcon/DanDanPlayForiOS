//
//  DDPNewHomePagePackageViewController.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2018/10/4.
//  Copyright © 2018 JimHuang. All rights reserved.
//

#import "DDPNewHomePagePackageViewController.h"
#import "DDPNewHomePageViewController.h"
#import "DDPHomePageSearchPackageViewController.h"
#import "DDPFileManagerViewController.h"

@interface DDPNewHomePagePackageViewController ()
@property (strong, nonatomic) DDPNewHomePageViewController *homePageViewController;
@end

@implementation DDPNewHomePagePackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    [self addChildViewController:self.homePageViewController];
    [self.view addSubview:self.homePageViewController.view];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.homePageViewController.view.frame = self.view.bounds;
}

- (void)configLeftItem {
    
}

- (void)configRightItem {
    UIImage *fileIcon = [[UIImage imageNamed:@"file_phone"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIBarButtonItem *fileItem = [[UIBarButtonItem alloc] initWithImage:fileIcon configAction:^(UIButton *aButton) {
        [aButton addTarget:self action:@selector(touchLeftItem) forControlEvents:UIControlEventTouchUpInside];
        aButton.imageView.tintColor = UIColor.whiteColor;
    }];
    [self.navigationItem addLeftItemFixedSpace:fileItem];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_search"] configAction:^(UIButton *aButton) {
        [aButton addTarget:self action:@selector(touchRightItem) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.navigationItem addRightItemFixedSpace:searchItem];
}

- (void)touchLeftItem {
    let vc = [[DDPFileManagerViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.file = ddp_getANewRootFile();
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchRightItem {
    let vc = [[DDPHomePageSearchPackageViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - 懒加载
- (DDPNewHomePageViewController *)homePageViewController {
    if (_homePageViewController == nil) {
        _homePageViewController = [[DDPNewHomePageViewController alloc] init];
    }
    return _homePageViewController;
}

@end
