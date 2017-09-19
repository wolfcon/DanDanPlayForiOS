//
//  MineViewController.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 17/3/5.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "DownloadViewController.h"
#import "AttentionListViewController.h"

#import "UIApplication+Tools.h"
#import "SettingTitleTableViewCell.h"
#import "SettingDownloadTableViewCell.h"
#import "UIView+Tools.h"
#import <UMSocialCore/UMSocialCore.h>

#define TITLE_KEY @"titleLabel.text"

#define TITLE_VIEW_RATE 0.4

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, CacheManagerDelagate, UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray <NSDictionary *>*dataSourceArr;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIView *nameIconHoldView;
@property (strong, nonatomic) UIImageView *iconImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIVisualEffectView *blurView;
@end

@implementation MineViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameIconHoldView addMotionEffectWithMaxOffset:30];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.nameIconHoldView removeMotionEffect];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
//    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight;
    
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.view.height * TITLE_VIEW_RATE);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [[CacheManager shareCacheManager] addObserver:self];
    [[CacheManager shareCacheManager] addObserver:self forKeyPath:@"linkDownloadingTaskCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [[CacheManager shareCacheManager] addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)dealloc {
    [[CacheManager shareCacheManager] removeObserver:self];
    [[CacheManager shareCacheManager] removeObserver:self forKeyPath:@"linkDownloadingTaskCount"];
    [[CacheManager shareCacheManager] removeObserver:self forKeyPath:@"user"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"linkDownloadingTaskCount"]) {
        NSNumber *aNewCount = change[NSKeyValueChangeNewKey];
        NSNumber *aOldCount = change[NSKeyValueChangeOldKey];
        if ([aNewCount isEqual:aOldCount] == NO) {
            [self.tableView reloadData];
        }
    }
    else if ([keyPath isEqualToString:@"user"]) {
        [self reloadUserInfo];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataSourceArr[indexPath.row];
    
    OtherSettingTitleSubtitleTableViewCell *cell = nil;
    
    if ([dic[TITLE_KEY] isEqualToString:@"下载任务"]) {
        SettingDownloadTableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"SettingDownloadTableViewCell" forIndexPath:indexPath];
        aCell.downLoadCount = [CacheManager shareCacheManager].downloadTasks.count + [CacheManager shareCacheManager].linkDownloadingTaskCount;
        cell = aCell;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTitleTableViewCell" forIndexPath:indexPath];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.textColor = [UIColor blackColor];
    [self.dataSourceArr[indexPath.row] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [cell setValue:obj forKeyPath:key];
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.dataSourceArr[indexPath.row];
    
    if ([dic[TITLE_KEY] isEqualToString:@"设置"]) {
        SettingViewController *vc = [[SettingViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([dic[TITLE_KEY] isEqualToString:@"我的关注"]) {
        AttentionListViewController *vc = [[AttentionListViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([dic[TITLE_KEY] isEqualToString:@"下载任务"]) {
        DownloadViewController *vc = [[DownloadViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        AboutUsViewController *vc = [[AboutUsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44 + jh_isPad() * 10;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float y = -scrollView.contentOffset.y / self.view.height * 4 + 1;
    if (y <= 1) y = 1;

    self.blurView.transform = CGAffineTransformMakeScale(y, y);
}

#pragma mark - CacheManagerDelagate
- (void)SMBDownloadTasksDidChange:(NSArray <TOSMBSessionDownloadTask *>*)tasks type:(SMBDownloadTasksDidChangeType)type {
    [self.tableView reloadData];
}

#pragma mark - 私有方法
- (void)configLeftItem {
    
}

- (void)reloadUserInfo {
    JHUser *user = [CacheManager shareCacheManager].user;
    [self.blurView.layer jh_setImageWithURL:user.icoImgURL placeholder:[UIImage imageNamed:@"icon"]];
    [self.iconImgView jh_setImageWithURL:user.icoImgURL placeholder:[UIImage imageNamed:@"icon"]];
    if (user) {
        self.nameLabel.text = user.name;
    }
    else {
        self.nameLabel.text = @"点击登录";
    }
    
    self.dataSourceArr = nil;
    [self.tableView reloadData];
}

#pragma mark - 懒加载

- (UIView *)headView {
    if (_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * TITLE_VIEW_RATE)];
        _headView.clipsToBounds = YES;
        
        [_headView addSubview:self.nameIconHoldView];
        
        [self.nameIconHoldView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        @weakify(self)
        [_headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self)
            if (!self) return;

            if ([CacheManager shareCacheManager].user == nil) {
                [[ToolsManager shareToolsManager] loginInViewController:self completion:^(JHUser *user, NSError *err) {
                    
                }];
            }
            else {
                UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                [vc addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [CacheManager shareCacheManager].user = nil;
                    [self reloadUserInfo];
                }]];
                
                [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                
                [self presentViewController:vc animated:YES completion:nil];
            }
        }]];
        
        [self reloadUserInfo];
    }
    return _headView;
}

- (UIImageView *)iconImgView {
    if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.layer.cornerRadius = (90 + jh_isPad() * 40) / 2;
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.borderWidth = 5;
        _iconImgView.layer.borderColor = RGBACOLOR(255, 255, 255, 0.6).CGColor;
    }
    return _iconImgView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = NORMAL_SIZE_FONT;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UIView *)nameIconHoldView {
    if (_nameIconHoldView == nil) {
        _nameIconHoldView = [[UIView alloc] init];
        _nameIconHoldView.clipsToBounds = NO;
        [_nameIconHoldView addSubview:self.iconImgView];
        [_nameIconHoldView addSubview:self.nameLabel];
        
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(0);
            make.width.height.mas_equalTo(90 + jh_isPad() * 40);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImgView.mas_bottom).mas_offset(10);
            make.bottom.mas_offset(-10);
            make.centerX.mas_equalTo(0);
        }];
        
    }
    return _nameIconHoldView;
}

- (UIVisualEffectView *)blurView {
    if (_blurView == nil) {
        _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _blurView.layer.contentMode = UIViewContentModeScaleAspectFill;
        _blurView.layer.masksToBounds = YES;
        [self.view addSubview:_blurView];
    }
    return _blurView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[SettingTitleTableViewCell class] forCellReuseIdentifier:@"SettingTitleTableViewCell"];
        [_tableView registerClass:[SettingDownloadTableViewCell class] forCellReuseIdentifier:@"SettingDownloadTableViewCell"];
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray<NSDictionary *> *)dataSourceArr {
    if (_dataSourceArr == nil) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{TITLE_KEY: @"设置"},
                                                               @{TITLE_KEY: @"下载任务"},
                                                               @{TITLE_KEY: [NSString stringWithFormat:@"关于%@", [UIApplication sharedApplication].appDisplayName]}]];
        if ([CacheManager shareCacheManager].user) {
            [arr insertObject:@{TITLE_KEY: @"我的关注"} atIndex:0];
        }
        
        _dataSourceArr = arr;
    }
    return _dataSourceArr;
}

@end