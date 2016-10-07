//
//  BeginViewController.m
//  Map
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "BeginViewController.h"

@interface BeginViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

//@property(nonatomic,weak)UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (weak, nonatomic) IBOutlet UIButton *mybutton;
@property(nonatomic,strong) NSArray *images;
@end

@implementation BeginViewController
-(void)initiamges{
    self.images=[[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
    
}
-(void)initscrollview{
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    //self.scrollview.bounds=self.view.bounds;
    //self.scrollview.backgroundColor=[UIColor grayColor];
    NSLog(@"1234");
    for (int i = 0; i< self.images.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
    
                // 1.设置frame
               imageView.frame = CGRectMake(i * w, 0, w, h);
        imageView.backgroundColor=[UIColor redColor];
                // 2.设置图片
                //NSString *imgName = [NSString stringWithFormat:@"0%d.jpg", i + 1];
                 imageView.image = [UIImage imageNamed:self.images[i]];
        
                 [self.scrollview addSubview:imageView];
       self.scrollview.contentSize = CGSizeMake(self.images.count *w+2, 0);
        self.scrollview.showsHorizontalScrollIndicator = NO;
        self.scrollview.pagingEnabled = YES;
        self.scrollview.delegate = self;
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >3 * self.view.bounds.size.width) {
        scrollView.contentOffset=CGPointMake(-self.view.bounds.size.width, 0);
    }
//    if (scrollView.contentOffset.x<0) {
//        scrollView.contentOffset=CGPointMake(3*self.view.bounds.size.width, 0);
//    }
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"%d", page);
    
    // 设置页码
    self.pagecontrol.currentPage = page;
    if (self.pagecontrol.currentPage==3) {
        self.mybutton.hidden=NO;
    }
    else{
        self.mybutton.hidden=YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initiamges];
    [self initscrollview];
    self.mybutton.hidden=YES;
    self.pagecontrol.enabled=NO;
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
