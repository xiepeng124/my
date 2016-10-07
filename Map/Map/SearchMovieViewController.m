//
//  SearchMovieViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SearchMovieViewController.h"
#import "MovieModel.h"
#import <AFNetworking/AFNetworking.h>
@interface SearchMovieViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UITableView *tablelist;
@property(strong,nonatomic)MovieModel *model;
@end

@implementation SearchMovieViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mycell=@"cells";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycell];
    }
    cell.textLabel.text=self.model.titles[indexPath.row];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"评分:%@",self.model.ratings[indexPath.row]];
    return cell;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
    
    NSString *string=@"http://v.juhe.cn/movie/index";
    
    NSDictionary *dic=@{@"key":@"8bd68b4e91855bbf24158d1a0aad5953",@"title":@"魔戒"};

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"response=%@",responseObject);
            [self.model.ratings removeAllObjects];
            [self.model.titles removeAllObjects];
            NSDictionary *dic2=(NSDictionary*)responseObject;
            NSString *strings=[dic2 objectForKey:@"reason"];
            NSLog(@"strings=%@",strings);
            //NSArray *arr=[dic2 objectForKey:@"result"];
//            for(id objects in arr)
//            {
//                NSString *rating=[objects objectForKey:@"rating"];
//                NSString *genres=[objects objectForKey:@"genres"];
//                NSString *runtime=[objects objectForKey:@"runtime"];
//                NSString *title=[objects objectForKey:@"title"];
//                [self.model.ratings addObject:rating];
//                [self.model.titles addObject:title];
//            }
            [self.tablelist reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error=%@",error);
        }];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchbar.delegate=self;
    self.tablelist.delegate=self;
    self.tablelist.dataSource=self;
    // Do any additional setup after loading the view.
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
