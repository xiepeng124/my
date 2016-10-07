//
//  PiaoViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "PiaoViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "CoreplotViewController.h"
@interface PiaoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *t1;
@property (weak, nonatomic) IBOutlet UITableView *t2;
@property (weak, nonatomic) IBOutlet UITableView *t3;
@property (weak, nonatomic) IBOutlet UITableView *t4;
@property (weak, nonatomic) IBOutlet UITextField *textf;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end
NSMutableArray *names;
NSMutableArray *rids;
NSMutableArray *wboxoffices;
NSMutableArray *tboxoffices;
NSMutableArray *arr2;
float f;
@implementation PiaoViewController
-(void)inittable{
    self.t1.delegate=self;
    self.t1.dataSource=self;
    self.t1.layer.borderColor=[[UIColor redColor]CGColor];
    self.t1.layer.borderWidth=1;
    self.t2.layer.borderColor=[[UIColor redColor]CGColor];
    self.t2.layer.borderWidth=1;
    self.t3.layer.borderColor=[[UIColor redColor]CGColor];
    self.t3.layer.borderWidth=1;
    self.t4.layer.borderColor=[[UIColor redColor]CGColor];
    self.t4.layer.borderWidth=1;
    self.t2.delegate=self;
    self.t2.dataSource=self;
    self.t3.delegate=self;
    self.t3.dataSource=self;
    self.t4.delegate=self;
    self.t4.dataSource=self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.t1) {
        NSLog(@"rids.count=%lu",rids.count);
        return rids.count;
    }
    if (tableView==self.t2) {
        NSLog(@"t2");
        return names.count;
    }
    if (tableView==self.t3) {
        return wboxoffices.count;
    }
    return tboxoffices.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.t1) {
        static NSString *mycell=@"cells";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycell];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor redColor];
        cell.textLabel.text=rids[indexPath.row];
        return cell;
    }
    if (tableView==self.t2) {
        static NSString *mycell=@"cells";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycell];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor redColor];
        cell.textLabel.text=names[indexPath.row];
        return cell;
    }
    if (tableView==self.t3) {
        
            static NSString *mycell=@"cells";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycell];
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
            }
            cell.textLabel.font=[UIFont systemFontOfSize:5];
            cell.textLabel.textColor=[UIColor redColor];
            cell.textLabel.text=wboxoffices[indexPath.row];
            return cell;
    }
    static NSString *mycell=@"cells";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:5];
    cell.textLabel.textColor=[UIColor redColor];
    cell.textLabel.text=tboxoffices[indexPath.row];
    return cell;
    //return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.t2) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       CoreplotViewController  *pnchart=[storyboard instantiateViewControllerWithIdentifier:@"PNchat"];
        pnchart.name=names;
        pnchart.percent=arr2;
        pnchart.f=f;
        [self.navigationController pushViewController:pnchart animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"23445");
    self.navigationItem.title=@"电影票房";
    [self inittable];
    names=[[NSMutableArray alloc]init];
    rids=[[NSMutableArray alloc]init];
    wboxoffices=[[NSMutableArray alloc]init];
    tboxoffices=[[NSMutableArray alloc]init];
    arr2=[[NSMutableArray alloc]init];
    
    [self post];
    self.textf.enabled=NO;
    NSLog(@"....ok");
    // Do any additional setup after loading the view.
}
- (IBAction)piaofangmenu:(UISegmentedControl *)sender {
    NSInteger a=self.segment.selectedSegmentIndex;
    switch (a) {
        case 0:
       {

           AFHTTPSessionManager *maanger =[AFHTTPSessionManager manager];
            NSDictionary *dic=@{@"key":@"f926a1d2e0e4d05ad55ae3a6fdfb1ef4" ,@"area":@"CN"};
            NSString *string=@"http://v.juhe.cn/boxoffice/rank.php";
            [maanger POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //NSLog(@"resp=%@",responseObject);
                NSArray *name=[responseObject objectForKey:@"result"];
                [names removeAllObjects];
                           [rids removeAllObjects];
                           [tboxoffices removeAllObjects];
                           [wboxoffices removeAllObjects];
                [arr2 removeAllObjects];
                f=0;
                for(id object in name){
                    NSLog(@"object=%@",object);
                    NSDictionary *dic2=(NSDictionary*)object;
                    NSString *name=[dic2 objectForKey:@"name"];
                    NSString *rid=[dic2 objectForKey:@"rid"];
                    NSString *wboxoffice=[dic2 objectForKey:@"wboxoffice"];
                    float f1=[wboxoffice floatValue];
                    f=f+f1;
                    NSString *tboxoffice=[dic2 objectForKey:@"tboxoffice"];
                    [names addObject:name];
                    [rids addObject:rid];
                    [tboxoffices addObject:tboxoffice];
                    [wboxoffices addObject:wboxoffice];
                    self.textf.text=[dic2 objectForKey:@"wk"];
                                    }
                for (int i=0; i<wboxoffices.count; i++) {
                    float f2=[wboxoffices[i] floatValue]/f;
                    NSString *string2=[NSString stringWithFormat:@"%.2f",f2];
                    [arr2 addObject:string2];
                }
                [self.t1 reloadData];
                [self.t2 reloadData];
                [self.t3 reloadData];
                [self.t4 reloadData];

                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
                            
            }];
           
//           [names removeAllObjects];
//           [rids removeAllObjects];
//           [tboxoffices removeAllObjects];
//           [wboxoffices removeAllObjects];
       }
            break;
        
            case 1:
        {
            AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
            NSDictionary *dic=@{@"key":@"f926a1d2e0e4d05ad55ae3a6fdfb1ef4" ,@"area":@"US"};
            NSString *string=@"http://v.juhe.cn/boxoffice/rank.php";
            [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //NSLog(@"resp=%@",responseObject);
                NSArray *name=[responseObject objectForKey:@"result"];
                [names removeAllObjects];
                [rids removeAllObjects];
                [tboxoffices removeAllObjects];
                [wboxoffices removeAllObjects];
                [arr2 removeAllObjects];
                f=0;
                for(id object in name){
                    NSLog(@"object=%@",object);
                    NSDictionary *dic2=(NSDictionary*)object;
                    NSString *name=[dic2 objectForKey:@"name"];
                    NSString *rid=[dic2 objectForKey:@"rid"];
                    NSString *wboxoffice=[dic2 objectForKey:@"wboxoffice"];
                    float f1=[wboxoffice floatValue];
                    f=f+f1;
                    NSString *tboxoffice=[dic2 objectForKey:@"tboxoffice"];
                    [names addObject:name];
                    [rids addObject:rid];
                    [tboxoffices addObject:tboxoffice];
                    [wboxoffices addObject:wboxoffice];
                    self.textf.text=[dic2 objectForKey:@"wk"];
                }
                for (int i=0; i<wboxoffices.count; i++) {
                    float f2=[wboxoffices[i] floatValue]/f;
                    NSString *string2=[NSString stringWithFormat:@"%.2f",f2];
                    [arr2 addObject:string2];
                }

                [self.t1 reloadData];
                [self.t2 reloadData];
                [self.t3 reloadData];
                [self.t4 reloadData];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
            }];
            
        }
            break;
        case 2:
        {
            AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
            NSDictionary *dic=@{@"key":@"f926a1d2e0e4d05ad55ae3a6fdfb1ef4" ,@"area":@"HK"};
            NSString *string=@"http://v.juhe.cn/boxoffice/rank.php";
            [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"0");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //NSLog(@"resp=%@",responseObject);
                NSArray *name=[responseObject objectForKey:@"result"];
                [names removeAllObjects];
                [rids removeAllObjects];
                [tboxoffices removeAllObjects];
                [wboxoffices removeAllObjects];
                [arr2 removeAllObjects];
                f=0;
                for(id object in name){
                    NSLog(@"object=%@",object);
                    NSDictionary *dic2=(NSDictionary*)object;
                    NSString *name=[dic2 objectForKey:@"name"];
                    NSString *rid=[dic2 objectForKey:@"rid"];
                    NSString *wboxoffice=[dic2 objectForKey:@"wboxoffice"];
                    float f1=[wboxoffice floatValue];
                    f=f+f1;
                    NSString *tboxoffice=[dic2 objectForKey:@"tboxoffice"];
                    [names addObject:name];
                    [rids addObject:rid];
                    [tboxoffices addObject:tboxoffice];
                    [wboxoffices addObject:wboxoffice];
                    self.textf.text=[dic2 objectForKey:@"wk"];
                }
                for (int i=0; i<wboxoffices.count; i++) {
                    float f2=[wboxoffices[i] floatValue]/f;
                    NSString *string2=[NSString stringWithFormat:@"%.2f",f2];
                    [arr2 addObject:string2];
                }

                [self.t1 reloadData];
                [self.t2 reloadData];
                [self.t3 reloadData];
                [self.t4 reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error=%@",error);
            }];
            
            
        }
            break;

        default:
            break;
    }
    
    
}
-(void)post{
    AFHTTPSessionManager *maanger =[AFHTTPSessionManager manager];
    NSDictionary *dic=@{@"key":@"f926a1d2e0e4d05ad55ae3a6fdfb1ef4" ,@"area":@"CN"};
    NSString *string=@"http://v.juhe.cn/boxoffice/rank.php";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [maanger POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"0");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"resp=%@",responseObject);
            NSArray *name=[responseObject objectForKey:@"result"];
            [names removeAllObjects];
            [rids removeAllObjects];
            [tboxoffices removeAllObjects];
            [wboxoffices removeAllObjects];
           [arr2 removeAllObjects];
            f=0;
            for(id object in name){
                NSLog(@"object=%@",object);
                NSDictionary *dic2=(NSDictionary*)object;
                NSString *name=[dic2 objectForKey:@"name"];
                NSString *rid=[dic2 objectForKey:@"rid"];
                NSString *wboxoffice=[dic2 objectForKey:@"wboxoffice"];
                float f1=[wboxoffice floatValue];
                f=f+f1;
                NSString *tboxoffice=[dic2 objectForKey:@"tboxoffice"];
                self.textf.text=[dic2 objectForKey:@"wk"];
                [names addObject:name];
                [rids addObject:rid];
                [tboxoffices addObject:tboxoffice];
                [wboxoffices addObject:wboxoffice];
            }
            for (int i=0; i<wboxoffices.count; i++) {
                float f2=[wboxoffices[i] floatValue]/f;
                NSString *string2=[NSString stringWithFormat:@"%.2f",f2];
                [arr2 addObject:string2];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.t1 reloadData];
                [self.t2 reloadData];
                [self.t3 reloadData];
                [self.t4 reloadData];
                
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
