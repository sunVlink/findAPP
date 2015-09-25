//
//  ListViewController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/17.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "ImageDetailViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource,imageButtonDelegate>
{    
    int listPage;

}
@end

@implementation ListViewController


- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listArr = [NSMutableArray new];
    
    listPage = 1;
    
    
    [self initView];
}




- (void)initView{

    _listTableView  = [[UITableView alloc]initWithFrame:self.view.frame];
    _listTableView.backgroundColor = BACKGROUND_PUPCOLOR;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.separatorStyle = NO;
    [self.view addSubview:_listTableView];
    
    
#pragma mark - 下拉刷新
    
    // 添加传统的下拉刷新
    [_listTableView addLegendHeaderWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    //    或
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_listTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [_listTableView.header setTitle:@"Pull down to refresh" forState:MJRefreshHeaderStateIdle];
    [_listTableView.header setTitle:@"Release to refresh" forState:MJRefreshHeaderStatePulling];
    [_listTableView.header setTitle:@"Loading ..." forState:MJRefreshHeaderStateRefreshing];
    
    // 设置字体
    _listTableView.header.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    _listTableView.header.textColor = [UIColor redColor];
    
    
#pragma mark - 上拉刷新
    
    // 添加传统的上拉刷新
    [_listTableView addLegendFooterWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    //    或
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [_listTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData{
    listPage = 1;
    [_listArr removeAllObjects];
    
    NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    //请求地址
    NSString * methodStr = @"list/getList.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = [NSDictionary new];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"flag"],@"pageNumber":@"1",@"token":@""};
    }else{
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"isVisitor"],@"pageNumber":@"1",@"token":userData[@"token"]};
    }
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        
        NSArray * arr = [[NSArray alloc]initWithArray:result[@"data"]];
        
        for (int i = 0; i < arr.count; i++) {
            [_listArr addObject:arr[i]];
        }
        
        [_listTableView.header endRefreshing];
        [_listTableView reloadData];
        
        
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];
    
}


- (void)loadMoreData{
    
    listPage ++;
    NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    //请求地址
    NSString * methodStr = @"list/getList.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = [NSDictionary new];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"flag"],@"pageNumber":[NSString stringWithFormat:@"%d",listPage],@"token":@""};
    }else{
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"isVisitor"],@"pageNumber":[NSString stringWithFormat:@"%d",listPage],@"token":userData[@"token"]};
    }
    
    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */
        
        
        NSArray * arr = [[NSArray alloc]initWithArray:result[@"data"]];
        
        for (int i = 0; i < arr.count; i++) {
            [_listArr addObject:arr[i]];
        }
        
        [_listTableView.footer endRefreshing];
        [_listTableView reloadData];
        
        
    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"crazy123";
    ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID lenght:WIDTH_LENTH listDic:_listArr[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.delegate = self;

    //    设置cell的点击事件没有样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    去掉cell右边的小箭头
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    cell.backgroundColor = BACKGROUND_PUPCOLOR;
    
    tableView.rowHeight = 130 * WIDTH_LENTH;

    cell.titleLabel.text = [NSString stringWithFormat:@"#%@",_listArr[indexPath.row][@"tagName"]];
    
    return cell;
}


- (void)PressImageButtonDoSomething:(NSString *)str{
    
    
    NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    //请求地址
    NSString * methodStr = @"square/sharePictureInfo.cmd";
    //向后台请求提交的参数
    NSDictionary *parmasDic = [NSDictionary new];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"flag"],@"pictureId":str,@"token":@""};
    }else{
        parmasDic = @{@"userId":[NSString stringWithFormat:@"%@",userData[@"userId"]],@"isVisitor":userData[@"isVisitor"],@"pictureId":str,@"token":userData[@"token"]};
    }

    
    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
        /*
         请求返回数据
         */

        
        ImageDetailViewController * detailVC = [[ImageDetailViewController alloc]init];
        detailVC.imageDic = result[@"data"];
        [self.navigationController pushViewController:detailVC animated:YES];

    }fail:^(NSString *result) {
        NSLog(@"失败了！");
    }];

}



@end
