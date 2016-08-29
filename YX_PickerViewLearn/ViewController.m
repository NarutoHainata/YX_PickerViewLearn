//
//  ViewController.m
//  YX_PickerViewLearn
//
//  Created by yang on 16/8/29.
//  Copyright © 2016年 poplary. All rights reserved.
//

#import "ViewController.h"
#import "ChooseProView.h"
#import "CustomPickerView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ChooseProViewDelegate,UITextViewDelegate,CustomPickerViewDelegate>{
    NSIndexPath *saveIndexPath;
    NSInteger index;
    NSInteger numOfCom;
}
@property (nonatomic, strong)  CustomPickerView *cusPicView;
@property (nonatomic, strong) UITableView *tableView;
//数据
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) NSArray *detailArr;
//显示选中的职业显示
@property (nonatomic, strong) ChooseProView *proView;
@property (nonatomic, strong) NSMutableArray *forChange;
@property (nonatomic, strong) NSMutableArray *saveDetails;
@property (nonatomic, strong) UIImageView *searchImg;
@property (nonatomic, strong) UITextView *searchView;
//数据源
@property (nonatomic, strong) NSMutableArray *ageArr;
@property (nonatomic, strong) NSArray *enjoyDate;

@property (nonatomic, strong) NSString *titleStr;
//背景btn
@property (nonatomic, strong) UIButton *bgBtn;
@end

@implementation ViewController
//设置数据源 军龄
-(NSMutableArray *)ageArr{
    
    if (!_ageArr) {
        _ageArr = [[NSMutableArray alloc] init];
        for (int i = 1; i<=60; i++) {
            [_ageArr addObject:[NSNumber numberWithInt:i]];
        }
        
    }
    return _ageArr;
}
- (NSArray *)enjoyDate{
    
    if (_enjoyDate == nil) {
        
        NSMutableArray *year = [NSMutableArray array];
        NSMutableArray *month = [NSMutableArray array];
        NSMutableArray *day = [NSMutableArray array];
        for (int i = 1949; i<2016; i++) {
            [year addObject:[NSNumber numberWithInt:i]];
        }
        for (int j = 1; j<= 12; j++) {
            [month addObject:[NSNumber numberWithInt:j]];
        }
        for (int k = 1; k<= 31; k++) {
            [day addObject:[NSNumber numberWithInt:k]];
        }
        _enjoyDate = @[year,month,day];
    }
    return _enjoyDate;
}
// 背景图片
-(UIButton *)bgBtn{
    
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        [_bgBtn setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.7]];
        [_bgBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}


-(UITextView *)searchView{
    
    if (!_searchView) {
        _searchView = [[UITextView alloc] initWithFrame:CGRectMake(30, 15, self.view.frame.size.width-60, 30)];
        _searchView.delegate = self;
        _searchView.text = @"输入战友姓名";
        _searchView.textColor = [UIColor grayColor];
        _searchView.layer.borderColor = [UIColor grayColor].CGColor;
        _searchView.layer.cornerRadius = 5;
        _searchView.layer.borderWidth = 1;
        _searchView.textAlignment = NSTextAlignmentCenter;
    }
    return _searchView;
}
-(CustomPickerView *)cusPicView{
    
    if (!_cusPicView) {
        _cusPicView = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 184)];
        _cusPicView.delegate = self;
    }
    return _cusPicView;
}

-(NSMutableArray *)saveDetails{
    
    if (!_saveDetails) {
        _saveDetails = [[NSMutableArray alloc] initWithObjects:@"不限",@"不限",@"不限",@"不限",@"不限",@"不限",@"不限", nil];
    }
    return _saveDetails;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-64-60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
    }
    return _tableView;
}
-(NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = @[@"军龄",@"军区",@"退役地区",@"入伍时间",@"退伍时间",@"兵种",@"地区"];
    }
    return _dataArr;
}
-(UIView *)showView{
    if (_showView == nil) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _showView.backgroundColor = [UIColor greenColor];
    }
    return _showView;
}
-(NSArray *)detailArr{
    if (_detailArr == nil) {
        _detailArr = @[
                       @[@"硬件",@"软件",@"互联网",@"IT-管理",@"IT-品管"],
                       @[@"销售管理",@"销售人员",@"销售",@"客服"],
                       @[@"财务",@"证券",@"银行",@"保险"],
                       @[@"生产",@"质量",@"工程",@"汽车",@"技工"],
                       @[@"生物",@"生物",@"化工",@"医院"],
                       @[@"广告",@"公关",@"市场"],
                       @[@"建筑",@"房地产",@"物业"]
                       ];
        
    }
    return _detailArr;
}
-(ChooseProView*)proView{
    if (!_proView) {
        _proView = [[ChooseProView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _proView.proDelegate = self;
        
    }
    return _proView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择职业";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    index = 0;
    self.forChange = [[NSMutableArray alloc]init];
    
    UIImageView *ivSearch = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    ivSearch.image = [UIImage imageNamed:@"search"];
    [self.searchView addSubview:ivSearch];
    self.searchImg = ivSearch;
    [self.view addSubview:self.searchView];
    
    
    
}
#pragma mark 实现customView 代理 显示返回的数据
- (void)selectShow:(NSString *)title WithRow:(NSInteger)row WithCom:(NSInteger)com{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:saveIndexPath];
    
    for (UILabel *lab in cell.accessoryView.subviews) {
        if ([lab isKindOfClass:[UILabel class]]) {
            lab.text = title;
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    
    UIView *showDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UILabel *showdetails = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 70, 24)];
    showdetails.backgroundColor = [UIColor whiteColor];
    showdetails.text = [self.saveDetails objectAtIndex:indexPath.row];
    showdetails.textAlignment = NSTextAlignmentRight;
    showdetails.textColor = [UIColor grayColor];
    showdetails.font = [UIFont fontWithName:@"Arial" size:14];
    [showDetailView addSubview:showdetails];
    
    UIImageView *detailImg = [[UIImageView alloc]initWithFrame:CGRectMake(showDetailView.frame.size.width-24, 10, 24, 24)];
    detailImg.image = [UIImage imageNamed:@"go"];
    [showDetailView addSubview:detailImg];
    cell.accessoryView = showDetailView;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view addSubview:self.bgBtn];
    if (indexPath.row == 0) {
        self.cusPicView.dataArr = self.ageArr;
        self.cusPicView.numOfCom = 1;
        [self.view addSubview:self.cusPicView];
        saveIndexPath = indexPath;
        }
   
    if (indexPath.row == 3) {
        self.cusPicView.dataArr = self.enjoyDate;
        self.cusPicView.numOfCom = 3;
        [self.view addSubview:self.cusPicView];
        saveIndexPath = indexPath;
    }
}
-(void)detailChooseDidSelectRow:(NSIndexPath *)indexPath{
    //index = index+1;
    NSString *profession = [[NSString alloc]init];
    profession = [[self.detailArr objectAtIndex:saveIndexPath.row] objectAtIndex:indexPath.row];
    //    self.proView.cellTitle = profession;
    [self.saveDetails replaceObjectAtIndex:saveIndexPath.row withObject:profession];
    [self.tableView reloadData];
    //    [self.forChange addObject:profession];
    //    self.proView.titleArr = self.forChange;
    //[self.proView.titleArr addObject:@"123"];
    //    NSLog(@"%lu",(unsigned long)self.proView.titleArr.count);
    //    for (UICollectionView *view in self.proView.subviews) {
    //        if ([view isKindOfClass:[UICollectionView class]]) {
    //            [view reloadData];
    //        }
    //    }
    //[self.proView.subviews objectAtIndex:0]
    //    self.showBtn = [[UIButton alloc]initWithFrame:CGRectMake(60*index+10*(index+1), 0, 60, 20)];
    //    self.showBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    //    [self.showBtn setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    //    [self.showBtn setTitle:profession forState:UIControlStateNormal];
    //    [self.showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.showBtn setTag:index];
    //    [self.showBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.showView addSubview:self.showBtn];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
//    view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 20)];
//    lab.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
//    lab.text = @"选择行业";
//    lab.font = [UIFont fontWithName:@"Arial" size:12];
//    NSLog(@"%f",lab.frame.size.width);
//    [view addSubview:lab];
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, 40)];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    [view addSubview:btn];
    
    return view;
}
-(void)ChooseProViewRelodedata:(UICollectionView *)collectionView{
    
}
-(void)deleteBtn:(UIButton *)sender{
    UIButton *btn = (UIButton *)[self.showView viewWithTag:sender.tag];
    [btn removeFromSuperview];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"输入战友姓名"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        self.searchImg.hidden = YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickSearch{
    
    
}
-(void)bgBtnClick{
    //self.cusPicView = nil;
    [self.cusPicView removeFromSuperview];
    [self.bgBtn removeFromSuperview];
    
}

@end
