//
//  BaseTableViewController.h
//  ArtSky
//
//  Created by Adam on 15/7/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface BaseTableViewController : RootViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *bannerDataArray; // banner 数据
    NSMutableDictionary *bannerDict; // banner 数据
    NSMutableArray *cellDataArray; // table cell 数据
    
    NSUInteger pageIndex; // 页面索引，从1开始
    NSUInteger pageCount; // 每页数据数目
    
    NSUInteger selBannerIndex;
    NSIndexPath *selIndexPath;
}

@property (strong, nonatomic) UITableView *mTableView;

- (void)initTabHeadView;

- (void)hiddenFooter;

#pragma mark - scroll table
- (void)scrollingToTopPosition;

#pragma mark - Banner Data
- (void)transBannerDataInfo;
- (void)transBannerDataInfoByType:(NSNumber *)bannerType;
- (void)createPosterScrollViewInView:(UIView *)headView;

- (void)transTableDataInfo;
- (void)handleTransTableDataInfo:(NSMutableDictionary *)dataDict;

#pragma mark - load data
- (void)clearTableData;
- (void)setTablePage;

- (void)loadCellDataDone;

- (void)loadNewData;
- (void)loadNewDataDone;

- (void)loadMoreData;
- (void)loadMoreDataDone;

#pragma mark - is Need Show Empty View
- (void)isNeedShowEmptyView;

- (void)endRefreshingView;

@end
