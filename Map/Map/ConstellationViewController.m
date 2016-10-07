//
//  ConstellationViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/31.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ConstellationViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TodayTableViewCell.h"
#import "WeekTableViewCell.h"
@interface ConstellationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@end
NSMutableArray *qfriends;
NSMutableArray *dates;
NSString *alls;
NSString *colors;
NSString *healths;
NSString *loves;
NSString *moneys;
NSString *numbers;
NSString *works;
NSString *summarys;
@implementation ConstellationViewController
-(void)initwitharry{
    qfriends=[NSMutableArray array];
    dates=[NSMutableArray array];
}
- (IBAction)change:(UISegmentedControl *)sender {
    //NSLog(@"titiel=%@",[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    if (sender.selectedSegmentIndex==0||sender.selectedSegmentIndex==1) {
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
        NSDictionary *dic=@{@"consName":self.textfield.text,@"type":[sender titleForSegmentAtIndex:sender.selectedSegmentIndex],@"key":@"d5c3cc00c5ab1e8e29338c23f5f9799e"};
        // maanger.responseSerializer=[AFHTTPResponseSerializer serializer];
        NSString *string=@"http://web.juhe.cn:8080/constellation/getAll";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [qfriends removeAllObjects];
                NSLog(@"sucess=%@",responseObject);
                healths=[responseObject objectForKey:@"health"];
                
                
                NSString *string=[responseObject objectForKey:@"QFriend"];
                [qfriends addObject:string];
                alls=[responseObject objectForKey:@"all"];
                colors=[responseObject objectForKey:@"color"];
                healths=[responseObject objectForKey:@"health"];
                loves=[responseObject objectForKey:@"love"];
                moneys=[responseObject objectForKey:@"money"];
                numbers=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"number"]];
                summarys=[responseObject objectForKey:@"summary"];
                works=[responseObject objectForKey:@"work"];
                NSLog(@"///%@",string);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
            }];
            
        });

    }

    if (sender.selectedSegmentIndex==2||sender.selectedSegmentIndex==3) {
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
        NSDictionary *dic=@{@"consName":self.textfield.text,@"type":[sender titleForSegmentAtIndex:sender.selectedSegmentIndex],@"key":@"d5c3cc00c5ab1e8e29338c23f5f9799e"};
        // maanger.responseSerializer=[AFHTTPResponseSerializer serializer];
        NSString *string=@"http://web.juhe.cn:8080/constellation/getAll";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [dates removeAllObjects];
                NSLog(@"sucess=%@",responseObject);
                healths=[responseObject objectForKey:@"health"];
                
                
                NSString *string=[responseObject objectForKey:@"date"];
                [dates addObject:string];
//                alls=[responseObject objectForKey:@"all"];
//                colors=[responseObject objectForKey:@"color"];
                healths=[responseObject objectForKey:@"health"];
                loves=[responseObject objectForKey:@"love"];
                moneys=[responseObject objectForKey:@"money"];
                //numbers=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"number"]];
                //summarys=[responseObject objectForKey:@"summary"];
                works=[responseObject objectForKey:@"work"];
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
            }];
            
        });
        
    }

}
- (IBAction)search:(id)sender {
    [self.view endEditing:YES];
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
           manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    NSDictionary *dic=@{@"consName":self.textfield.text,@"type":[self.segmented titleForSegmentAtIndex:self.segmented.selectedSegmentIndex],@"key":@"d5c3cc00c5ab1e8e29338c23f5f9799e"};
    // maanger.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *string=@"http://web.juhe.cn:8080/constellation/getAll";
    if (self.segmented.selectedSegmentIndex==0||self.segmented.selectedSegmentIndex==1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [qfriends removeAllObjects];
                //NSLog(@"sucess=%@",responseObject);
                NSString *string=[responseObject objectForKey:@"QFriend"];
                [qfriends addObject:string];
                alls=[responseObject objectForKey:@"all"];
                colors=[responseObject objectForKey:@"color"];
                healths=[responseObject objectForKey:@"health"];
                loves=[responseObject objectForKey:@"love"];
                moneys=[responseObject objectForKey:@"money"];
                numbers=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"number"]];
                summarys=[responseObject objectForKey:@"summary"];
                works=[responseObject objectForKey:@"work"];
                NSLog(@"///%@",string);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
            }];
            
        });

    }
    
    if (self.segmented.selectedSegmentIndex==2||self.segmented.selectedSegmentIndex==3) {
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [dates removeAllObjects];
                NSLog(@"sucess=%@",responseObject);
                healths=[responseObject objectForKey:@"health"];
                
                
                NSString *string=[responseObject objectForKey:@"date"];
                [dates addObject:string];
                //                alls=[responseObject objectForKey:@"all"];
                //                colors=[responseObject objectForKey:@"color"];
                healths=[responseObject objectForKey:@"health"];
                loves=[responseObject objectForKey:@"love"];
                moneys=[responseObject objectForKey:@"money"];
                //numbers=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"number"]];
                //summarys=[responseObject objectForKey:@"summary"];
                works=[responseObject objectForKey:@"work"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
            }];
            
        });
        
    }

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.segmented.selectedSegmentIndex==0||self.segmented.selectedSegmentIndex==1) {
        return qfriends.count;
    }
    return dates.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmented.selectedSegmentIndex==0||self.segmented.selectedSegmentIndex==1) {
        TodayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
        UILabel *qfriend=(UILabel*)[cell viewWithTag:9];
        qfriend.text=qfriends[indexPath.row];
        UILabel *all=(UILabel*)[cell viewWithTag:1];
        UILabel *color=(UILabel*)[cell viewWithTag:2];
        UILabel *health=(UILabel*)[cell viewWithTag:3];
        UILabel *love=(UILabel*)[cell viewWithTag:4];
        UILabel *money=(UILabel*)[cell viewWithTag:5];
        UILabel *number=(UILabel*)[cell viewWithTag:6];
        UILabel *work=(UILabel*)[cell viewWithTag:7];
        all.text=alls;
        color.text=colors;
        health.text=healths;
        love.text=loves;
        money.text=moneys;
        number.text=numbers;
        work.text=works;
        UITextView *summary=(UITextView*)[cell viewWithTag:8];
        [summary setEditable:NO];
        summary.text=summarys;
        
        return cell;

    }
    WeekTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"mycell2" forIndexPath:indexPath];
    UITextField *date=(UITextField*)[cell viewWithTag:5];
    [date setEnabled:NO];
    date.text=dates[indexPath.row];
    UITextView *health=(UITextView*)[cell viewWithTag:1];
    [health setEditable:NO];
    health.text=healths;
    UITextView *love=(UITextView*)[cell viewWithTag:2];
    [love setEditable:NO];
    love.text=loves;
    UITextView *money=(UITextView *)[cell viewWithTag:3];
    [money setEditable:NO];
    money.text=moneys;
    UITextView *work=(UITextView *)[cell viewWithTag:4];
    [work setEditable:NO];
    work.text=works;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 450;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TodayTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"WeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell2"];
    [self initwitharry];
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
