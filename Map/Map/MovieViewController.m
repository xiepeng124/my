//
//  MovieViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MovieViewController.h"
#import "PiaoViewController.h"
#import "SearchMovieViewController.h"
#import "MytViewController.h"
#import "QuTableViewController.h"
#import "ConstellationViewController.h"
//#import "TVViewController.h"
@interface MovieViewController ()<UITableViewDelegate,UITableViewDataSource>

@end
UITableView *tableview;
NSArray *arr;
@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //tableview.backgroundColor=[UIColor redColor];
    tableview.delegate=self;
    tableview.dataSource=self;
    self.navigationItem.title=@"娱乐表单";
    NSLog(@"movie");
    arr=[NSArray arrayWithObjects:@"今日电影票房",@"影片查询",@"今日上映电影" ,@"影院上映影片信息",@"电视节目",@"趣图／笑话",@"星座运势",nil];
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"arr.count=%lu",arr.count);
    return arr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cells=@"mycell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cells];
    //cell.accessoryType= UITableViewCellAccessoryDetailButton;
    //cell.backgroundColor=[UIColor lightGrayColor];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];;
    }
    cell.textLabel.text=arr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PiaoViewController *piao=[storyboard instantiateViewControllerWithIdentifier:@"PiaoFang"];
            [self.navigationController pushViewController:piao animated:YES];
            //[self presentViewController:piao animated:YES completion:nil];
            break;
        }
        case 1:{
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           SearchMovieViewController *piao=[storyboard instantiateViewControllerWithIdentifier:@"SearchMovie"];
            [self.navigationController pushViewController:piao animated:YES];
            //[self presentViewController:piao animated:YES completion:nil];
            break;
        }
        case 2:
        {
            break;
        }

        case 3:
        {
            break;
        }
        case 4:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MytViewController *piao=[storyboard instantiateViewControllerWithIdentifier:@"TVshow"];
            [self.navigationController pushViewController:piao animated:YES];
            
            break;
        }
        case 5:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            QuTableViewController *piao=[storyboard instantiateViewControllerWithIdentifier:@"qututable"];
            [self.navigationController pushViewController:piao animated:YES];
            
            break;
        }
        
        case 6:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           ConstellationViewController *piao=[storyboard instantiateViewControllerWithIdentifier:@"constellation"];
            [self.navigationController pushViewController:piao animated:YES];
            
            break;
        }

        default:
            break;
    }
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
