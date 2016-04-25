//
//  ViewController.m
//  JellyeffectDemo
//
//  Created by kimi.zhang on 16/4/25.
//  Copyright © 2016年 kimi.zhang. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+ScalableCover.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL refreshStatus;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, assign) NSInteger Count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataCount=5;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.tableHeaderView=[[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    [self.tableView addScalableCoverWithImage:[UIImage imageNamed:@"mebg"]];
}
//监听滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ( scrollView.contentOffset.y>-50) {
        [self  loadMore];
        [self.tableView reloadData];
    }
}


//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataCount;
}



//返回cell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier=@"Identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]init];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"cell -- %ld",(long)_Count++];
    
    return cell;
}



//获取刷新数据
-(void)loadMore{
    
    self.dataCount=10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
