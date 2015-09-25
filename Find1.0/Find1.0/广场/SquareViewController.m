//
//  SquareViewController.m
//  SquareDemo1.1
//
//  Created by APPLE on 15/6/6.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SquareViewController.h"
#import "SquareTableViewCell.h"
#import "UserCenterViewController.h"

@interface SquareViewController ()<SquareCellDelegate>
{
    UITapGestureRecognizer * _oneTap;
    UIButton * _cameraButton;
    NSArray * _tagsArr;
    int _listpage;
}
@end

@implementation SquareViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    _oneTap.enabled = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"getusertagtitle" object:nil];
    
#pragma mark - 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLogin:) name:@"isLogin" object:nil];
    
    _listpage = 1;
    
    self.squareArr = [NSMutableArray new];
    
    _praiseArr = [NSMutableArray new];
    
    _praiseNumberArr = [NSMutableArray new];

    self.view.backgroundColor = BACKGROUND_PUPCOLOR;
    
#pragma mark - 添加点击手势
    _oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OneTop)];
    _oneTap.numberOfTapsRequired = 1;
    _oneTap.delegate = self;
    [self.navigationController.navigationBar addGestureRecognizer:_oneTap];

    
    self.praiseArr = [[NSMutableArray alloc]init];
    self.praiseNumberArr = [[NSMutableArray alloc]init];
    
    self.indicator = [[YYAnimationIndicator alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40*WIDTH_LENTH, self.view.frame.size.height/2-150*WIDTH_LENTH, 80*WIDTH_LENTH, 80*WIDTH_LENTH)];
    [self.indicator setLoadText:@"正在加载..."];
    [self.view addSubview:self.indicator];
    
    [self StartIndicator];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isTourist"]){
        //请求地址
        NSString * methodStr = @"user/visitor.cmd";
        //向后台请求提交的参数
        NSDictionary *parmasDic = @{@"isVisitor":@"1"};
        
        [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
            /*
             请求返回数据
             */
            
            if (self.getSourceButton) {
                [self.getSourceButton removeFromSuperview];
            }
            
            [self StopIndicator];
            
            [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"userData"];                    [[NSUserDefaults standardUserDefaults] synchronize];
            [self getSource];
        }fail:^(NSString *result) {
            NSLog(@"失败了！");
            [self StopFailIndicator];
            
            if (!self.getSourceButton) {
                [self addGetSourceButton];
            }

        }];
    }else{
        [self getSource];
    }
    
    [self initWithSquareTableView];
    
}

- (void)OneTop{
    [self.squareTaleView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    _oneTap.enabled = NO;
    
}

- (void)getSource{
    
    [self StartIndicator];
    
        NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
        
        NSString * methodStr = @"square/getAllPicture.cmd";
    
        NSDictionary *parmasDic = [NSDictionary new];
    
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
          parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"flag"],@"pageNumber":[NSString stringWithFormat:@"%d",_listpage]};
        }else{
          parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"isVisitor"],@"pageNumber":[NSString stringWithFormat:@"%d",_listpage],@"token":userData[@"token"]};
        }
    
        //向后台请求提交的参数
            HttpRequstHelper *helper = [HttpRequstHelper sharedInstance];
            [[helper getSquareDelegate] getSquareListData:methodStr params:parmasDic success:^(NSArray *result) {
                /*
                 请求返回数据
                 */
                for (int i = 0; i < result.count; i++) {
                    [self.squareArr addObject:result[i]];
                }
            
                if (self.getSourceButton) {
                    [self.getSourceButton removeFromSuperview];
                }
                
                [self StopIndicator];
                
                [self.noInternetBackImageView removeFromSuperview];
                
                [self.squareTaleView reloadData];
                
            } fail:^(NSString *error) {
                [self StopFailIndicator];
                
                if (!self.getSourceButton) {
                    [self addGetSourceButton];
                }
            }];
}

- (void)addGetSourceButton{
    self.getSourceButton = [[UIButton alloc]initWithFrame:MainView_frame];
    [self.getSourceButton addTarget:self action:@selector(pressGetSourceButton) forControlEvents:UIControlEventTouchUpInside];
    [self.indicator addSubview:self.getSourceButton];

}

- (void)pressGetSourceButton{
    [self getSource];
}


-(void)StartIndicator
{
    [self.indicator startAnimation];  //开始转动
}

/*
 当Type为YES时消失  NO时不消失
 */
-(void)StopIndicator
{
    [self.indicator stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
}

-(void)StopFailIndicator
{
    [self.indicator stopAnimationWithLoadText:@"加载失败" withType:NO];//加载失败
}


- (void)initWithSquareTableView{
    
    self.squareTaleView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.squareTaleView.dataSource = self;
    self.squareTaleView.delegate = self;
    self.squareTaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.squareTaleView.backgroundColor = BACKGROUND_PUPCOLOR;
    [self.view addSubview:self.squareTaleView];
    
    [self.squareTaleView reloadData];

#pragma mark - 下拉刷新
    
    // 添加传统的下拉刷新
    [self.squareTaleView addLegendHeaderWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    //    或
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.squareTaleView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [self.squareTaleView.header setTitle:@"Pull down to refresh" forState:MJRefreshHeaderStateIdle];
    [self.squareTaleView.header setTitle:@"Release to refresh" forState:MJRefreshHeaderStatePulling];
    [self.squareTaleView.header setTitle:@"Loading ..." forState:MJRefreshHeaderStateRefreshing];
    
    // 设置字体
    self.squareTaleView.header.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    self.squareTaleView.header.textColor = [UIColor redColor];
    
#pragma mark - 上拉刷新
    
    // 添加传统的上拉刷新
    [self.squareTaleView addLegendFooterWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    //    或
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [self.squareTaleView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    _cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 -  43*WIDTH_LENTH,500*WIDTH_LENTH, 90*WIDTH_LENTH,90*WIDTH_LENTH)];
    _cameraButton.layer.cornerRadius = _cameraButton.frame.size.width / 2;
    [_cameraButton setBackgroundImage:[UIImage imageNamed:@"相机.png"] forState:UIControlStateNormal];
//    [_cameraButton addTarget:self action:@selector(pressCameraButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cameraButton];
    
}


#pragma mark - 下拉刷新事件

- (void)loadNewData{
    [self.squareTaleView reloadData];
    [self.squareTaleView.header endRefreshing];
}

#pragma mark 上拉加载更多数据

- (void)loadMoreData
{
    
    _listpage++;
    
    NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userData"]];
    
    NSString * methodStr = @"square/getAllPicture.cmd";
    
    //向后台请求提交的参数
    
    NSDictionary *parmasDic = [NSDictionary new];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"flag"],@"pageNumber":[NSString stringWithFormat:@"%d",_listpage]};
    }else{
        parmasDic = @{@"userId":userData[@"userId"],@"isVisitor":userData[@"isVisitor"],@"pageNumber":[NSString stringWithFormat:@"%d",_listpage],@"token":userData[@"token"]};
    }
        HttpRequstHelper *helper = [HttpRequstHelper sharedInstance];
        [[helper getSquareDelegate] getSquareListData:methodStr params:parmasDic success:^(NSArray *result) {
            /*
             请求返回数据
             */
            for (int i = 0; i < result.count; i++) {
                [self.squareArr addObject:result[i]];
            }
            
            [self.squareTaleView reloadData];
            [self.squareTaleView.footer endRefreshing];

        } fail:^(NSString *error) {
          
        }];
}


#pragma mark - 接受通知后的操作
- (void)tongzhi:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"title"]);
    NSLog(@"－－－－－接收到通知------");
}

- (void)isLogin:(NSNotification *)text{
    [self.squareTaleView reloadData];
    NSLog(@"登录了");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.squareArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"crazy123";
    SquareTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SquareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = BACKGROUND_PUPCOLOR;
    tableView.rowHeight = 530*WIDTH_LENTH;   //设置tableView  cell 的高度
    
    cell.delegate = self;
//    设置cell的点击样式关闭
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    去掉cell右侧的箭头
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.topHeadButton.tag = indexPath.row;
    
    // 设置cell的数据
    [cell configureCell:self.squareArr[indexPath.row]];
    
    cell.praiseButton.tag = indexPath.row;
    
#pragma mark -  添加弹幕
    
    return cell;
}

#pragma mark - <SquareCellDelegate>

#pragma mark - 点赞事件

- (void)pressPriseButton:(NSDictionary *)priseDic{
    
    //一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[priseDic[@"tag"] integerValue]inSection:0];
    [self.squareTaleView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationMiddle];
    

//    NSDictionary * userData = [[NSDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"touristData"]];
//    
//    //请求地址
//    NSString * methodStr = @"/comment/doComment.cmd";
//    
//    //向后台请求提交的参数
//    
//    NSDictionary *parmasDic = [NSDictionary new];
//    
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isTourist"]) {
//        parmasDic = @{@"userId":userData[@"userId"],@"token":@"",@"toUserId":@"",@"isVisitor":userData[@"flag"],@"pictureId":priseDic[@"pictureID"],@"fromUserId":userData[@"userId"],@"content":@"",@"type":@"2"};
//    }else{
//        parmasDic = @{@"userId":userData[@"userId"],@"token":@"",@"toUserId":@"",@"isVisitor":userData[@"isVisitor"],@"pictureId":priseDic[@"pictureID"],@"fromUserId":userData[@"userId"],@"content":@"",@"type":@"2"};
//    }
//    
//    [WebRequest webRequestWithURLMethod:methodStr parmas:parmasDic success:^(id result) {
//        /*
//         请求返回数据
//         */
//
//        
//    }fail:^(NSString *result) {
//        NSLog(@"失败了！%@",result);
//    }];

}

#pragma mark - 头像点击事件
- (void)UserHeadImageViewChick:(NSString *)tag{
//    UserCenterViewController * userCenterVC = [UserCenterViewController new];
    
//    [self presentViewController:userCenterVC animated:YES completion:^{
    
//    }];
    NSLog(@"%@",tag);
    
}


#pragma mark - 检测tableview

float lastContentOffset;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
}


#pragma mark - 检测tableview滚动的方向

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (lastContentOffset < scrollView.contentOffset.y) {
        NSLog(@"向上滚动");
                _cameraButton.alpha = 0;
        
    }else{
        NSLog(@"向下滚动");
                _cameraButton.alpha = 1;
    }
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (lastContentOffset < scrollView.contentOffset.y) {
//        
//        NSLog(@"向上滚动");
//
//    }else{
//        
//        NSLog(@"向下滚动");
//    }
//    
//}


#pragma mark - 监测tableview的当前行数

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",(long)indexPath.row);
    
}


@end
