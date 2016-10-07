//
//  CoreplotViewController.m
//  Map
//
//  Created by 汪杰 on 16/9/4.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CoreplotViewController.h"
#import "PNChart.h"
@interface CoreplotViewController ()//<CPTPlotDataSource,CPTPieChartDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textf;
@property (strong, nonatomic) PNPieChart *pieChart;
@end

@implementation CoreplotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0,
                                                                 155.0,
                                                                 240.0,
                                                                 240.0) items:[NSArray array]];
    //设置颜色和字体
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:8.0];
    [self.textf setEnabled:NO];
    self.textf.text=[NSString stringWithFormat:@"%.0f万",self.f];
    NSLog(@"corechart1");
    self.navigationItem.title=@"票房统计表";
    //self.view.backgroundColor=[UIColor whiteColor];
    [self drawPieChart:self.percent];
   // NSLog(@"...%@",self.name);
    
    
    // Do any additional setup after loading the view.
}


//items为传入的原始数据参数，不需要转化为比例
- (void)drawPieChart:(NSArray *)items
{
    //获取要绘制的数据
    NSArray *dataitems =
    @[[PNPieChartDataItem dataItemWithValue: [self.percent[0] floatValue] color:PNDeepGreen  description:self.name[0]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[1] floatValue]  color:PNLightGreen description:self.name[1]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[2] floatValue]  color:[UIColor redColor] description:self.name[2]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[3] floatValue]  color:[UIColor orangeColor] description:self.name[3]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[4] floatValue]  color:[UIColor yellowColor] description:self.name[4]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[5] floatValue]  color:PNLightBlue description:self.name[5]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[6] floatValue]  color:[UIColor redColor] description:self.name[6]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[7] floatValue]  color:[UIColor orangeColor] description:self.name[7]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[8] floatValue]  color:[UIColor yellowColor] description:self.name[8]],
      [PNPieChartDataItem dataItemWithValue:[self.percent[9] floatValue]  color:PNLightBlue description:self.name[9]]];
    
    //更新需要绘制的数据并绘制
    [self.pieChart updateChartData:dataitems];
    [self.pieChart strokeChart];
    
    //设置标注
    self.pieChart.legendStyle = PNLegendItemStyleStacked;//标注摆放样式
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:10.0f];
//
    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
    [legend
     setFrame:CGRectMake(170,
                         400,
                         legend.frame.size.width,
                         legend.frame.size.height)];
    
    //将标注和饼状图添加到view上
    [self.view addSubview:legend];
    [self.view addSubview:self.pieChart];
    NSLog(@"corechart2");
    
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
