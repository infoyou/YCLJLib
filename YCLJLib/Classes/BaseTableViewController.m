//
//  BaseTableViewController.m
//  ArtSky
//
//  Created by Adam on 15/7/29.
//  Copyright (c) 2015年 fule. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize mTableView;

- (void)viewDidLoad {
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT_OFFSET) style:UITableViewStylePlain];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    self.mTableView.backgroundColor = TRANSPARENT_COLOR;
    self.mTableView.separatorColor = TRANSPARENT_COLOR;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [self.view addSubview:self.mTableView];
    
    [super viewDidLoad];
}

- (void)addTapStatus
{
    
    self.mTableView.scrollsToTop = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self addTapStatus];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
}

- (void)setTablePage
{
    pageIndex = 1;
    pageCount = 10;
}

/*
- (void)adjustView
{
    
    mTableView.header = [MJHeaderAnimal headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    mTableView.footer = [MJFooterAnimal footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)hiddenFooter
{
    
    mTableView.footer.alpha = 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTabHeadView
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 取消选中
    
    selIndexPath = indexPath;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 9)];
    
    headView.backgroundColor = HEX_COLOR(VIEW_BG_COLOR);
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

#pragma mark - UITableViewDataSource method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([cellDataArray count] == 0) {
        return 0;
    } else {
        return [cellDataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - scroll table

- (void)scrollingToTopPosition
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.mTableView scrollToRowAtIndexPath:indexPath
                           atScrollPosition:UITableViewScrollPositionTop
                                   animated:YES];
}

- (void)transTableDataInfo
{
    // Request TableView List Data
}

- (void)handleTransTableDataInfo:(NSMutableDictionary *)paramDict
{
    
    [ZTHttpTool post:HOST_URL
              params:paramDict
             success:^(id json) {
                 
                 NSDictionary *backDic = json;
                 
                 if (backDic != nil) {
                     
                     NSString *errCodeStr = (NSString *)[backDic valueForKey:@"code"];
                     
                     if ( [errCodeStr integerValue] == 0 ) {
                         
                         NSArray *resultArray = (NSArray *)[(NSArray *)[backDic valueForKey:@"result"] valueForKey:@"list"];
                         
                         NSInteger logicCount = [resultArray count];
                         
                         for (NSInteger productIndex = 0; productIndex < logicCount; productIndex++) {
                             
                             NSMutableDictionary *logicDict = (NSMutableDictionary *)resultArray[productIndex];
                             
                             LogicModel *logicModel = [LogicModel newWithDict:logicDict];
                             
                             logicModel.pageIndex = [NSString stringWithFormat:@"%tu", pageIndex];
                             logicModel.pageCount = [NSString stringWithFormat:@"%tu", pageCount];
                             [cellDataArray addObject:logicModel];
                         }
                         
                         [self loadCellDataDone];
                     } else if ([errCodeStr integerValue] == NO_MORE_DATA) {
                         [self loadCellDataDone];
                     } else {
                         [self showHUDWithText:[backDic valueForKey:@"msg"]];
                     }
                 } else {
                     [self showHUDWithText:LocaleStringForKey(NSReturnDataIsEmpty, nil)];
                     [self isNeedShowEmptyView];
                 }
                 
             } failure:^(NSError *error) {
                 
                 DLog(@"请求失败-%@", error);
                 [self endRefreshingView];
                 [self showHUDWithText:@"请检查网络设置。"];
             }];
}

- (void)transRealTimeTableData
{
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:[AppManager instance].selCellResourceId forKey:@"resourceId"];
    [dataDict setObject:[AppManager instance].selCellType forKey:@"type"];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"resourceCountData"
                                                      dataDict:dataDict];
    
    [ZTHttpTool post:HOST_URL
              params:paramDict
             success:^(id json) {
                 
                 NSDictionary *backDic = json;
                 
                 if (backDic != nil) {
                     
                     NSString *errCodeStr = (NSString *)[backDic valueForKey:@"code"];
                     
                     if ( [errCodeStr integerValue] == 0 ) {
                         
                         NSMutableDictionary *logicDict = (NSMutableDictionary *)backDic[@"result"];
                         
                         NSString *browseCount = logicDict[@"browseCount"];
                         NSString *browseState = logicDict[@"browseState"];
                         NSString *commentCount = logicDict[@"commentCount"];
                         NSString *commentState = logicDict[@"commentState"];
                         NSString *loveCount = logicDict[@"loveCount"];
                         NSString *loveState = logicDict[@"loveState"];
                         NSString *subscribeState = logicDict[@"subscribeState"];
                         
                         if (cellDataArray != nil && [cellDataArray count] > 0) {
                             
                             if ([self isKindOfClass:ExhibitionMainViewController.class] ||
                                 [self isKindOfClass:LotListViewController.class] ||
                                 [self isKindOfClass:FoundViewController.class] ||
                                 [self isKindOfClass:FavoriteViewController.class] ||
                                 [self isKindOfClass:SearchViewController.class] ||
                                 [self isKindOfClass:InstitutionContentViewController.class]) {
                                 
                                 BaseModel *logicModel = cellDataArray[[AppManager instance].selCurrentIndexPath.row];
                                 logicModel.loveCount = loveCount;
                                 logicModel.loveState = loveState;
                                 logicModel.browseCount = browseCount;
                                 logicModel.browseState = browseState;
                                 logicModel.commentCount = commentCount;
                                 logicModel.commentState = commentState;
                                 
                             } else if ([self isKindOfClass:ExhibitionListViewController.class]) {
                                 
                                 ExhibitionListObject *exhibitionListObject = cellDataArray[[AppManager instance].selCurrentIndexPath.row];
                                 
                                 BaseModel *logicModel = exhibitionListObject.logicModel;
                                 logicModel.loveCount = loveCount;
                                 logicModel.loveState = loveState;
                                 logicModel.browseCount = browseCount;
                                 logicModel.browseState = browseState;
                                 logicModel.commentCount = commentCount;
                                 logicModel.commentState = commentState;
                                 
                             } else if ([self isKindOfClass:SpaceViewController.class]) {
                                 
                                 SpaceModel *spaceModel = cellDataArray[[AppManager instance].selCurrentIndexPath.row];
                                 spaceModel.subscribeState = subscribeState;
                             }
                         }
                         
                         [self refreashCustomeCell];
                     } else if ([errCodeStr integerValue] == NO_MORE_DATA) {
                         
                         [self loadCellDataDone];
                     } else {
                         
                         [self showHUDWithText:[backDic valueForKey:@"msg"]];
                     }
                 } else {
                     
                     [self showHUDWithText:LocaleStringForKey(NSReturnDataIsEmpty, nil)];
                     [self loadCellDataDone];
                 }
                 
             } failure:^(NSError *error) {
                 
                 DLog(@"请求失败-%@", error);
                 [self endRefreshingView];
                 [self showHUDWithText:@"请检查网络设置。"];
             }];
}

#pragma mark - Load Cell Data

- (void)clearTableData
{
    if (cellDataArray != nil &&
        [cellDataArray count] > 0) {
        
        [cellDataArray removeAllObjects];
    } else {
        
        cellDataArray = [NSMutableArray array];
    }
}

- (void)loadNewDataDone
{
    // 刷新表格
    [mTableView reloadData];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.mTableView.header endRefreshing];
}

- (void)loadMoreDataDone
{
    // 刷新表格
    [mTableView reloadData];
    
    // 拿到当前的上拉刷新控件，结束刷新状态
    [self.mTableView.footer endRefreshing];
}

- (void)endRefreshingView
{
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.mTableView.header endRefreshing];
    // 拿到当前的上拉刷新控件，结束刷新状态
    [self.mTableView.footer endRefreshing];
}

- (void)loadNewData
{
    DLog(@"load New Data");
    [self setTablePage];
    
    [self clearTableData];
    
    [self transTableDataInfo];
}

- (void)loadMoreData
{
    pageIndex ++;
    DLog(@"load More Data");
    [self transTableDataInfo];
}

- (void)refreashCustomeCell
{
    [self.mTableView reloadData];
    
    [AppManager instance].isUpdateCellFlag = NO;
}

- (void)loadCellDataDone
{
    
    if(pageIndex > 1) {
        [self loadMoreDataDone];
    } else {
        [self loadNewDataDone];
    }
    
}

#pragma mark - is Need Show Empty View
- (void)isNeedShowEmptyView
{
    
    
}

#pragma mark - handle del action
- (void)handleBtnDelActionFromCell:(UITableViewCell *)cell
{
    
    if (![self checkIsLogin]) {
        return;
    }
    
    selIndexPath = [self.mTableView indexPathForCell:cell];
    
    [self popDelView:cellDataArray[selIndexPath.row]];
}

#pragma mark - 处理上拉显示NaviBar，下拉隐藏NaviBar
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // Do your action here
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    static CGFloat lastY = 0;
    
    CGFloat currentY = scrollView.contentOffset.y;
    CGFloat headerHeight = self.mTableView.tableHeaderView.frame.size.height;
    
    if ((lastY <= headerHeight) && (currentY > headerHeight)) {
        NSLog(@" ******* Header view just disappeared");
        [self setDefaultStatusAndNavi];
    }
    
    if ((lastY > headerHeight) && (currentY <= headerHeight)) {
        NSLog(@" ******* Header view just appeared");
        [self setCoustomStatusAndNavi];
    }
    
    lastY = currentY;
}

#pragma mark - trans User Data
- (void)transUserData
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *paramDict = [CommonUtils getParamDict:@"userInfo"
                                                      dataDict:dataDict];
    
    [ZTHttpTool post:HOST_URL
              params:paramDict
             success:^(id json) {
                 
                 NSDictionary *backDic = json;
                 
                 
                 if (backDic != nil) {
                     
                     NSString *errCodeStr = (NSString *)[backDic valueForKey:@"code"];
                     
                     if ( [errCodeStr integerValue] == 0 ) {
                         
                         // 成功
                         NSDictionary *resultDic = [backDic valueForKey:@"result"];
                         [AppManager instance].userName = resultDic[@"username"];
                         [AppManager instance].balance = resultDic[@"balance"] ? resultDic[@"balance"]:@"0";
                         
                         if (![resultDic[@"nickname"] isEqual:[NSNull null]]) {
                             
                             [AppManager instance].userNickName = resultDic[@"nickname"];
                             
                             if ([[AppManager instance].userNickName isEqualToString:@""]) {
                                 
                                 [AppManager instance].userNickName = @"暂无昵称";
                             }
                         }
                         
                         if (![[[backDic valueForKey:@"result"] valueForKey:@"email"] isEqual:[NSNull null]]) {
                             
                             [AppManager instance].userEmail = resultDic[@"email"];
                         }
                         
                         [AppManager instance].userPoint = resultDic[@"credit"];
                         [AppManager instance].userImageUrl = resultDic[@"picUrl"];
                         
                         [[AppManager instance] rememberUserData:[AppManager instance].userId
                                                        userName:[AppManager instance].userName
                                                        nickName:[AppManager instance].userNickName
                                                          avator:[AppManager instance].userImageUrl
                                                           point:@""
                                                          mobile:[AppManager instance].userName];
                         
                         [self.mTableView reloadData];
                         [self initTabHeadView];
                         
                     } else {
                         
                         [self showHUDWithText:[backDic valueForKey:@"msg"]];
                     }
                 } else {
                     [self showHUDWithText:LocaleStringForKey(NSReturnDataIsEmpty, nil)];
                 }
                 
             } failure:^(NSError *error) {
                 
                 DLog(@"请求失败-%@", error);
                 [self showHUDWithText:@"请检查网络设置。"];
             }];
}

#pragma mark － 无网络时点击事件
- (void)btnNoNetWorkClicked:(id)sender
{
    
    [self transTableDataInfo];
}
*/
@end
