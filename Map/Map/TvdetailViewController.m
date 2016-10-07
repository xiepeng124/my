//
//  TvdetailViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TvdetailViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface TvdetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *pname;
    NSMutableArray *times;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation TvdetailViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return pname.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mycells=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycells];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycells];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"节目名称:%@",pname[indexPath.row]];
    cell.textLabel.textColor=[UIColor redColor];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"播出时间:%@",times[indexPath.row]];    //[tableview2 reloadData];
    return cell;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    pname=[NSMutableArray array];
    times=[NSMutableArray array];
    [self post];
    //self.rels=[NSMutableArray array];
    // Do any additional setup after loading the view.
}
-(void)post{
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
    
    NSString *string=@"http://japi.juhe.cn/tv/getProgram";
    
    NSDictionary *dic=@{@"key":@"c2cda7a7672f4e7faf1a90b4806a179b",@"code":self.rels[self.s]};
    
    
    [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        //NSLog(@"response=%@",responseObject);
        [pname removeAllObjects];
        [times removeAllObjects];
        //[rels removeAllObjects];
        NSArray *results=[responseObject objectForKey:@"result"];
        for(id objects in results){
            NSString *name=[objects objectForKey:@"pName"];
            NSString *time=[objects objectForKey:@"time"];
            NSString *aname=[objects objectForKey:@"cName"];
            [pname addObject:name];
            [times addObject:time];
            
            self.navigationItem.title=aname;
        }
        //NSLog(@"arr=%@",self.arr[2]);
        
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
