//
//  QuTableViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "QuTableViewController.h"
#import "QuTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
@interface QuTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
NSMutableArray *texts;
NSMutableArray *images;
@implementation QuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.tableview registerClass:[QuTableViewCell class] forCellReuseIdentifier:@"QuTableViewCell" ];
    texts=[NSMutableArray array];
    images=[NSMutableArray array];
    [self post];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return images.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mycell=@"QuTableViewCell";
    QuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    if (cell==nil) {
        cell=[[QuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
    }
    // Configure the cell...
    cell.label.text=texts[indexPath.row];
    cell.label.textColor=[UIColor purpleColor];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:images[indexPath.row]]];
    [cell.webview loadRequest:request];
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 310;
}
-(void)post{
    AFHTTPSessionManager *maanger =[AFHTTPSessionManager manager];
    NSDictionary *dic=@{@"key":@"294652109fb60e955943dabba6d95cc9",@"type":@"pic"};
   // maanger.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *string=@"http://v.juhe.cn/joke/randJoke.php";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [maanger POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"0");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"sucess");
//            id objects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"resp=%@",responseObject);
           NSArray *result=[responseObject objectForKey:@"result"];
           // NSArray *data=[result objectForKey:@"data"];
            [texts removeAllObjects];
            [images removeAllObjects];
            
            
            for(id object in result){
                NSLog(@"object=%@",object);
                NSDictionary *dic2=(NSDictionary*)object;
                NSString *text=[dic2 objectForKey:@"content"];
                NSString *image=[dic2 objectForKey:@"url"];
                [texts addObject:text];
                [images addObject:image];
                
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableview reloadData];
                
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error=%@",error);
        }];
        
    });
    //    [self.t1 reloadData];
    //                [self.t2 reloadData];
    //                [self.t3 reloadData];
    //                [self.t4 reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
