//
//  TvlistViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TvlistViewController.h"
//#import "MytViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TvdetailViewController.h"
#import "TvlistTableViewCell.h"
@interface TvlistViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr;
    NSMutableArray *urls;
    NSMutableArray *rels;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TvlistViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mycells=@"TvlistTableViewCell";
    TvlistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycells];
    if (cell==nil) {
        cell=[[TvlistTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycells];
    }
    cell.label.text=arr[indexPath.row];
    [cell.button setTitle:urls[indexPath.row] forState:UIControlStateNormal];
    //[cell.button setTintColor:[UIColor blueColor]];
    cell.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    cell.button.backgroundColor=[UIColor blueColor];
   [cell.button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    //cell.detailTextLabel.textColor=[UIColor blueColor];
    //[tableview2 reloadData];
    return cell;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    arr=[NSMutableArray array];
    urls=[NSMutableArray array];
    rels=[NSMutableArray array];
    [self post];
    self.navigationItem.title=@"电视列表";
    [self.tableView registerClass:[TvlistTableViewCell class] forCellReuseIdentifier:@"TvlistTableViewCell"];
    
    // Do any additional setup after loading the view.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)post{
AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];

NSString *string=@"http://japi.juhe.cn/tv/getChannel";

  NSDictionary *dic=@{@"key":@"c2cda7a7672f4e7faf1a90b4806a179b",@"pId":[NSString stringWithFormat:@"%ld",(long)self.s]};
    

[manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"response=%@",responseObject);
    [arr removeAllObjects];
    [urls removeAllObjects];
    [rels removeAllObjects];
    NSArray *results=[responseObject objectForKey:@"result"];
    for(id objects in results){
        NSString *name=[objects objectForKey:@"channelName"];
        NSString *url=[objects objectForKey:@"url"];
        NSString *rel=[objects objectForKey:@"rel"];
        [arr addObject:name];
        [urls addObject:url];
        [rels addObject:rel];
    }
    //NSLog(@"arr=%@",self.arr[2]);
    
    [self.tableView reloadData];
    
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"error=%@",error);
}];
//[tableview2 reloadData];


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.s=indexPath.row+1;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TvdetailViewController *detail=[storyboard instantiateViewControllerWithIdentifier:@"Tvdetail"];
   detail.s=indexPath.row;
//    detail.rels=[NSMutableArray array];
    detail.rels=[rels copy];
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
