//
//  MytViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MytViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TvlistViewController.h"
@interface MytViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation MytViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"...count=%lu",self.arr.count);
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath    {
    static NSString *mycells=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycells];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycells];
    }
    cell.textLabel.text=self.arr[indexPath.row];
    //[tableview2 reloadData];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.s=indexPath.row+1;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TvlistViewController *piao=[storyboard instantiateViewControllerWithIdentifier:@"Tvlist"];
    piao.s=indexPath.row+1;
    [self.navigationController pushViewController:piao animated:YES];
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.arr.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, tableView.rowHeight)];
//    imageView.backgroundColor=[UIColor greenColor];
//    [tableView addSubview:imageView];
//    return tableView;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr=[[NSMutableArray alloc]init];
    
    
    //self.tableview2.backgroundColor=[UIColor redColor];
    //[self.view addSubview:tableview2];
    // Do any additional setup after loading the view.
    //[self.tableview2 reloadData];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor lightGrayColor];
    [self post];
    self.navigationItem.title=@"电视分类";
}
-(void)post{
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
    
    NSString *string=@"http://japi.juhe.cn/tv/getCategory";
//    manager.requestSerializer=[AFHTTPResponseSerializer serializer];
    //manager.requestSerializer =[AFJSONResponseSerializer  serializer];
  
    NSDictionary *dic=@{@"key":@"c2cda7a7672f4e7faf1a90b4806a179b"};
    
    
        [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"response=%@",responseObject);
            [self.arr removeAllObjects];
            NSArray *results=[responseObject objectForKey:@"result"];
            for(id objects in results){
                NSString *name=[objects objectForKey:@"name"];
                [self.arr addObject:name];
            }
            NSLog(@"arr=%@",self.arr[2]);
            
            [self.tableview reloadData];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error=%@",error);
        }];
    //[tableview2 reloadData];
    

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
