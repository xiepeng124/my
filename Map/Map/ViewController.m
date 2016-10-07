//
//  ViewController.m
//  Map
//
//  Created by 汪杰 on 16/8/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "NearViewController.h"
#import <PopMenu/PopMenu.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "MovieViewController.h"
//#import "PiaoViewController.h"
@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,AMapNaviDriveManagerDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
     MAMapView *mapViews;
    AMapSearchAPI *Search;
    CLLocation *currectLocation;
    NSArray *pois;
    NSMutableArray * annotations;
    UITableView *TableView;
    UITableView *tableView2;
    AMapNaviDriveManager *driveManager;
    UILongPressGestureRecognizer *longG;
    MAPointAnnotation *destination;
    NSArray *pathPolylines;
    UITextField *distance;
    UISearchBar *searchbar;
    NSArray *searcharray;
    NSString *city;
    NSMutableArray *paths;
    NSMutableArray *path2;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableview3;

@property (weak, nonatomic) IBOutlet UITextField *one;
@property (weak, nonatomic) IBOutlet UISearchBar *Searchbar;
@property (weak, nonatomic) IBOutlet UIButton *SearchButton;
@property (weak, nonatomic) IBOutlet UITextField *two;
@property (weak, nonatomic) IBOutlet UIButton *sure;
@property (weak, nonatomic) IBOutlet UIStackView *stackview;
@property (nonatomic, readonly) AMapNaviRoute *naviRoute;
@property (weak, nonatomic) IBOutlet UIButton *walking;
@property (weak, nonatomic) IBOutlet UIButton *drving;
@property (weak, nonatomic) IBOutlet UIButton *busing;
@property (weak, nonatomic) IBOutlet UIStackView *Travstack;
@end

@implementation ViewController
-(void)initsearchbar{
    searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(120, 94, self.view.bounds.size.width-120, 40)];
    searchbar.text=nil;
    searchbar.showsSearchResultsButton=YES;
    searchbar.delegate=self;
    [self.view addSubview:searchbar];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    if (searchBar.text==nil) {
        tableView2.hidden=YES;
    }
    else{
    tableView2.hidden=NO;
    }
    self.tableview3.hidden=YES;
//    AMapInputTipsSearchRequest *request=[[AMapInputTipsSearchRequest alloc]init];
//    
//    searchBar.text=@"餐饮";
    //request.keywords=searchBar.text;
    //request.city=
    //[Search AMapInputTipsSearch:request];
    
    
    

    return YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    AMapInputTipsSearchRequest *request=[[AMapInputTipsSearchRequest alloc]init];
    
    //searchBar.text=@"餐饮";
    request.keywords=searchBar.text;
    request.city=city;
    NSLog(@"city=%@",city);
    [Search AMapInputTipsSearch:request];
    

}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
     tableView2.hidden=YES;
    
    [self.view endEditing:YES];
    searchbar.text=nil;
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search了");
//[self.view endEditing:YES];
}
    //    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
//    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格

-(void)initdistance {
    distance=[[UITextField alloc]initWithFrame:CGRectMake(0,100 ,120, 30)];
    distance.textColor = [UIColor orangeColor];
    distance.placeholder = @"距离";
    distance.hidden =YES;
    [self.view addSubview:distance];
}
-(void)initSearch {
    Search = [[AMapSearchAPI alloc]init];
    Search.delegate = self;
}
-(void)initString {
    pois = [NSArray array];
    annotations = [[NSMutableArray alloc]init];
    searcharray = [NSArray array];
    city=[[NSString alloc]init];
    paths=[[NSMutableArray alloc]init];
    path2=[[NSMutableArray alloc]init];
//    longG=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressaction:)];
//    longG.delegate=self;
//    [mapViews addGestureRecognizer:longG];
    
}
-(void)initTableview {
    CGFloat a = CGRectGetHeight(self.view.bounds)*0.5;
    NSLog(@"a =%f",a);
    TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, a*1.3, self.view.bounds.size.width, a*0.7) style:UITableViewStylePlain];
    TableView.delegate =self;
    TableView.dataSource=self;
  [TableView setHidden:YES];
    tableView2=[[UITableView alloc]initWithFrame:CGRectMake(0, 134, self.view.bounds.size.width, self.view.bounds.size.height-134) style:UITableViewStylePlain];
    tableView2.dataSource=self;
    tableView2.delegate=self;
    tableView2.hidden=YES;
    //tableView2=[]
    [self.view addSubview:TableView];
    [self.view addSubview:tableView2];
    
}

-(void)initsegmented {
    NSArray *arry=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    UISegmentedControl *seg=[[UISegmentedControl alloc]initWithItems:arry];
    seg.frame = CGRectMake(0, 64, self.view.bounds.size.width, 30);
    seg.tintColor = [UIColor blueColor];
    seg.selectedSegmentIndex=0;
    [seg setTitle:@"普通" forSegmentAtIndex:0];
    [seg setTitle:@"卫星" forSegmentAtIndex:1];
    [seg setTitle:@"夜间" forSegmentAtIndex:2];
    [seg addTarget:self action:@selector(didselectedsegment:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:seg];
}
- (void)initDriveManager
{
    if (driveManager == nil)
    {
        driveManager = [[AMapNaviDriveManager alloc] init];
        [driveManager setDelegate:self];
    }
}
-(void)initwithDrvButton {
    //CGFloat *a=
   // UITextField *one =[UITextField alloc]initWithFrame:<#(CGRect)#>
}
//
-(void)didselectedsegment:(UISegmentedControl*)segs{
    NSInteger index=segs.selectedSegmentIndex;
    NSLog(@"index=%lu",index);
    switch (index) {
        case 0:
            mapViews.mapType= MAMapTypeStandard;
//            MAMapTypeStandard = 0,  // 普通地图
//            MAMapTypeSatellite,  // 卫星地图
//            MAMapTypeStandardNight
            break;
        case 1:
            mapViews.mapType=  MAMapTypeSatellite;
            break;
        case 2:
            mapViews.mapType=  MAMapTypeStandardNight;
            break;

        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==TableView) {
        NSLog(@"%lu..",pois.count);
        return pois.count;

    }
    if (tableView==tableView2) {
       NSLog(@"table2");
        return searcharray.count ;

    }
    if (tableView==self.tableview3) {
        //NSLog(@"pathme");
        NSLog(@"path.count=%lu",paths.count);
        return paths.count ;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==TableView) {
        static NSString *cells=@"mycell";
        NSLog(@"tabel1");
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cells];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cells];
            
        }
        AMapPOI *poi = pois[indexPath.row];
        cell.textLabel.text = poi.name;
        cell.detailTextLabel.text = poi.address;
        //NSLog(@"cell.text=%@",cell.textLabel.text);
        return cell;

    }
   if (tableView==tableView2) {
        static NSString *cells=@"searchcell";
       NSLog(@"table2");
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cells];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cells];
        }
        AMapTip *tip=searcharray[indexPath.row];
        cell.textLabel.text=tip.name;
        cell.detailTextLabel.text=tip.address;
        return cell;

    }
    static NSString *cells=@"pathcell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cells];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cells];
    }
   // AMapSegment *segment =paths[indexPath.row];
    AMapStep *step=paths[indexPath.row];
    cell.textLabel.text=step.instruction;
    cell.textLabel.textColor=[UIColor purpleColor];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    NSLog(@"step.in=%@",step.instruction);
    cell.detailTextLabel.text=[NSString stringWithFormat:@"时间：%ld秒",(long)step.duration];
    return cell;
    }
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==TableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AMapPOI *poi =pois[indexPath.row];
        MAPointAnnotation *annotation2=[[MAPointAnnotation alloc]init];
        
        annotation2.coordinate= CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        annotation2.title=poi.name;
        annotation2.subtitle=poi.address;
        [annotations addObject:annotation2];
        NSLog(@"annotions=%@",annotations);
        [mapViews addAnnotation:annotation2];
    }
    if (tableView==tableView2) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        AMapTip *tip =searcharray[indexPath.row];
        MAPointAnnotation *annotation3=[[MAPointAnnotation alloc
                                         ]init];
        annotation3.coordinate=CLLocationCoordinate2DMake(tip.location.latitude, tip.location.longitude);
        annotation3.title=tip.name;
        NSLog(@"title=%@..,subtitile=%@",annotation3.title,annotation3.subtitle);
        annotation3.subtitle=tip.address;
        [mapViews addAnnotation:annotation3];
        [annotations addObject:annotation3];
        [searchbar resignFirstResponder];
    }
    
}
- (IBAction)diving2:(id)sender {
    NSLog(@"dring");
    [paths removeAllObjects];
     self.tableview3.hidden=NO;
    AMapDrivingRouteSearchRequest *requst=[[AMapDrivingRouteSearchRequest alloc]init];
    requst.origin = [AMapGeoPoint locationWithLatitude:currectLocation.coordinate.latitude longitude:currectLocation.coordinate.longitude];
    NSLog(@"%f..%f",currectLocation.coordinate.latitude ,currectLocation.coordinate.longitude);
    requst.destination=[AMapGeoPoint locationWithLatitude:destination.coordinate.latitude longitude:destination.coordinate.longitude];
    //destination=[[MAPointAnnotation alloc]init];
    //destination=view.annotation;
    //NSLog(@"%f,%f",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    [Search AMapDrivingRouteSearch:requst];

}
- (IBAction)walking:(id)sender {
    NSLog(@"walking");
    [paths removeAllObjects];
     self.tableview3.hidden=NO;
    AMapWalkingRouteSearchRequest *requst=[[AMapWalkingRouteSearchRequest alloc]init];
    requst.origin = [AMapGeoPoint locationWithLatitude:currectLocation.coordinate.latitude longitude:currectLocation.coordinate.longitude];
    NSLog(@"%f..%f",currectLocation.coordinate.latitude ,currectLocation.coordinate.longitude);
    requst.destination=[AMapGeoPoint locationWithLatitude:destination.coordinate.latitude longitude:destination.coordinate.longitude];
  
    [Search AMapWalkingRouteSearch:requst];

}
- (IBAction)busing:(id)sender {
    [paths removeAllObjects];
     self.tableview3.hidden=NO;
//    AMapTransitRouteSearchRequest *requst=[[AMapTransitRouteSearchRequest alloc]init];
//    requst.origin = [AMapGeoPoint locationWithLatitude:currectLocation.coordinate.latitude longitude:currectLocation.coordinate.longitude];
//    NSLog(@"%f..%f",currectLocation.coordinate.latitude ,currectLocation.coordinate.longitude);
//    requst.destination=[AMapGeoPoint locationWithLatitude:destination.coordinate.latitude longitude:destination.coordinate.longitude];
//    
//    [Search AMapTransitRouteSearch:requst];
//    

}


- (IBAction)dirving:(id)sender {
    MovieViewController *movie=[[MovieViewController alloc]init];
    [self.navigationController pushViewController:movie animated:YES];
    
//        AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:39.989614 longitude:116.481763];
//        AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:39.983456 longitude:116.315495];
//        
//        NSArray *startPoints = @[startPoint];
//        NSArray *endPoints   = @[endPoint];
//        
//        //驾车路径规划（未设置途经点、导航策略为速度优先）
//        [driveManager calculateDriveRouteWithEndPoints:endPoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyDefault];
    
}
- (IBAction)sure:(id)sender {
    [self.view endEditing:YES ];
}
//附近搜索请求
- (IBAction)LocationSearch:(id)sender {
    [self.view endEditing:YES];
    distance.hidden=YES;
    self.tableview3.hidden=YES;
    //self.stackview.hidden=YES;
    
      AMapPOIAroundSearchRequest *request2 = [[AMapPOIAroundSearchRequest alloc]init];
    request2.location=[AMapGeoPoint locationWithLatitude:currectLocation.coordinate.latitude longitude:currectLocation.coordinate.longitude];
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    MenuItem *menuitem=[[MenuItem alloc]initWithTitle:@"美食" iconName:nil glowColor:[UIColor orangeColor] index:0];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"饮品" iconName:nil glowColor:[UIColor orangeColor] index:1];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"购物" iconName:nil glowColor:[UIColor orangeColor] index:2];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"旅行" iconName:nil glowColor:[UIColor orangeColor] index:3];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"服务" iconName:nil glowColor:[UIColor orangeColor] index:4];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"休闲" iconName:nil glowColor:[UIColor orangeColor] index:5];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"健康" iconName:nil glowColor:[UIColor orangeColor] index:6];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"交通" iconName:nil glowColor:[UIColor orangeColor] index:7];
    [arry addObject:menuitem];
    menuitem=[[MenuItem alloc]initWithTitle:@"返回" iconName:nil glowColor:[UIColor redColor] index:8];
    [arry addObject:menuitem];
     PopMenu *popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:arry];
    popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase; // kPopMenuAnimationTypeSina
    popMenu.perRowItemCount = 3; // or 2
    [popMenu showMenuAtView:self.view];
    popMenu .didSelectedItemCompletion=^(MenuItem* selected){
        switch (selected.index) {
            case 0:
                request2.keywords = @"美食";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 1:
                request2.keywords = @"饮品";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 2:
                request2.keywords = @"购物";
                 [Search AMapPOIAroundSearch:request2];
                break;
            case 3:
                request2.keywords = @"旅行";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 4:
                request2.keywords = @"服务";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 5:
                request2.keywords = @"休闲";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 6:
                request2.keywords = @"健康";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 7:
                request2.keywords = @"交通";
                [Search AMapPOIAroundSearch:request2];
                break;
            case 8:
                [TableView setHidden:YES];
                [mapViews removeAnnotations:annotations];
                
                [annotations removeAllObjects];
                break;

            default:
                break;
                
        }
        
    };
    
    [TableView setHidden:NO];
}
//定位逆编码请求
-(void)reSearchAction {
    if (currectLocation) {
        NSLog(@"3...");
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
        request.location = [AMapGeoPoint locationWithLatitude:currectLocation.coordinate.latitude longitude:currectLocation.coordinate.longitude];
        [Search AMapReGoecodeSearch:request];
    }
}
//请求错误回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"2...");
    NSLog(@"request = %@,error = %@",request,error);
}
//逆编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSLog(@"response =%@",response);
    NSLog(@"1...");
    NSString *title = response.regeocode.addressComponent.province;
     NSLog(@"city2=%@",city);
    city=response.regeocode.addressComponent.province;
    if (title.length == 0) {
        title = response.regeocode.addressComponent.city;
        city=response.regeocode.addressComponent.city;
       
    }
    mapViews.userLocation.title = title;
    mapViews.userLocation.subtitle = response.regeocode.formattedAddress;
}
//附近搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"5..");
    NSLog(@"count = %lu",(unsigned long)response.pois.count);
    if (response.pois.count > 0) {
        pois=response.pois;
        [TableView reloadData];
        [mapViews removeAnnotations:annotations];
        //[Search cancelAllRequests];
        [annotations removeAllObjects];
    }
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    NSLog(@"respone.count=%lu",response.tips.count
          
          );
    if (response.tips.count>0) {
        searcharray=response.tips;
        [tableView2 reloadData];
        [mapViews removeAnnotations:annotations];
        [annotations removeAllObjects];
    }
}
//选择位置
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"4...");
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self reSearchAction];
    }
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]]) {
        [mapViews setCenterCoordinate:view.annotation.coordinate animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initSearch];
    [self initString];
    
    mapViews = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    mapViews.delegate = self;
    //mapView.showsLabels = NO;
   mapViews.showsUserLocation = YES;
    mapViews.showTraffic = YES;
    mapViews.showsIndoorMap = YES;
    mapViews.customizeUserLocationAccuracyCircleRepresentation = YES;
    mapViews.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    mapViews.pausesLocationUpdatesAutomatically = NO;
    //mapViews.showTraffic= YES;
    //mapViews.sho
    mapViews.allowsBackgroundLocationUpdates = YES;
    //mapViews.zoomLevel = 10;
    [self.view insertSubview:mapViews atIndex:0];
    [self initTableview];
    [self initsegmented];
    [self initdistance];
    [self initsearchbar];
    
    self.one.hidden= YES;
    self.two.hidden= YES;
    self.sure.hidden= YES;
    self.tableview3.hidden=YES;
    self.tableview3.delegate=self;
    self.tableview3.dataSource=self;
   [self.view bringSubviewToFront:self.one];
    [self.view bringSubviewToFront:self.two];
    [self.view bringSubviewToFront:self.sure];
    [self.view bringSubviewToFront:self.tableview3];
    [self.walking setHidden:YES];
    [self.busing setHidden:YES];
    [self.drving setHidden:YES];

   

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    //[self reSearchAction];
    NSLog(@"2222222");
}
//获取定位坐标
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        currectLocation = [userLocation.location copy];
    }
}

// 路径覆盖
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleRenderer;
    }
    NSLog(@"shut..");
//    CLLocationCoordinate2D *points = malloc([mutablePoints count] * sizeof(CLLocationCoordinate2D));
//    for(int i = 0; i < [mutablePoints count]; i++) {
//        [[mutablePoints objectAtIndex:i] getValue:(points + i)];
//    }
//    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc( sizeof(overlay.coordinate));
//    MAPolyline *polys=[MAPolyline polylineWithCoordinates:coordinates count:2];
//BOOL s=[overlay isKindOfClass:[MAPolyline class]];
    ///NSLog(@"%d..",s);
    if ([overlay isKindOfClass:[MAPolyline class]]
         )
    {
        NSLog(@"ok");
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polygonView.lineWidth = 8.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoinType = kMALineJoinRound;//连接类型
        
        return polygonView;
    }
    return nil;
}
- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)overlayRenderers{
    NSLog(@"xinde ..");
}

//大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    /* 自定义userLocation对应的annotationView. */
//    if ([annotation isKindOfClass:[MAUserLocation class]])
//    {
//        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"Location.png"];
//        
//        annotationView.canShowCallout = YES;
//        
//        
//        return annotationView;
////    }
    
  if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *PointStyleReuseIndetifier = @"PointannotationStyleReuseIndetifier";
        MAPinAnnotationView *annotationView1 =(MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:PointStyleReuseIndetifier];
        NSLog(@"666");
        if (annotationView1 == nil)
        {
            annotationView1 = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:PointStyleReuseIndetifier];
        }
        //annotationView.image = [UIImage imageNamed:@"Location.png"];
       annotationView1.pinColor =MAPinAnnotationColorGreen;
        annotationView1.canShowCallout = YES;
      annotationView1.draggable = YES;
      //annotationView1.centerOffset = CGPointMake(0, -18);
      [mapViews setCenterCoordinate:annotation.coordinate animated:YES];
        return annotationView1;
    

    }
//    if (annotation==destination) {
//        static NSString *PointStyleReuseIndetifier = @"PointannotationStyleReuseIndetifier";
//        MAPinAnnotationView *annotationView1 =(MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:PointStyleReuseIndetifier];
//        NSLog(@"777");
//        if (annotationView1 == nil)
//        {
//            annotationView1 = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
//                                                              reuseIdentifier:PointStyleReuseIndetifier];
//        }
//        //annotationView.image = [UIImage imageNamed:@"Location.png"];
//        annotationView1.pinColor =MAPinAnnotationColorGreen;
//        annotationView1.canShowCallout = YES;
//        annotationView1.draggable = YES;
//        //annotationView1.centerOffset = CGPointMake(0, -18);
//        [mapViews setCenterCoordinate:annotation.coordinate animated:YES];
//        return annotationView1;
//
//    }
    return nil;
}
//点击气泡路径
- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view{
    NSLog(@"123456677");
    if (distance.text!=nil) {
        distance.text=nil;
    }
   
    //self.textview.hidden=NO;
    TableView.hidden=YES;
//    self.stackview.hidden=NO;
//    self.drving.hidden=NO;
//    self.walking.hidden=NO;
//    self.busing.hidden=NO;
    if (self.walking.hidden==YES) {
        [self.walking setHidden:NO];
        [self.busing setHidden:NO];
        [self.drving setHidden:NO];
    }
    else{
        [self.walking setHidden:YES];
        [self.busing setHidden:YES];
        [self.drving setHidden:YES];
    }
    
    //[self.view bringSubviewToFront:self.stackview];
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
//        NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",
//                               @"云华时代", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude];
//        
//        NSDictionary *dic = @{@"name": @"高德地图",
//                              @"url": urlString};
//        //[self.availableMaps addObject:dic];
//    }
    [paths removeAllObjects];
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(view.annotation.coordinate.latitude,view.annotation.coordinate.longitude));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(currectLocation.coordinate.latitude,currectLocation.coordinate.longitude));
    //2.计算距离
    CLLocationDistance distances = MAMetersBetweenMapPoints(point1,point2);
    distance.hidden=NO;
    distance.text=[NSString stringWithFormat:@"%.1f米",distances];
    
    destination=[[MAPointAnnotation alloc]init];
    destination=view.annotation;
    
}

//路径规划回调
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    if (response.count>0) {
        [mapViews removeOverlays:pathPolylines];
        pathPolylines=nil;
        //pathPolylines = [[NSArray alloc]init];
        NSLog(@"wode line..");
        [mapViews addOverlays:pathPolylines];
        if (response.route.transits==nil) {
            pathPolylines=[self polylinesForPath:response.route.paths[0]];
        }
        else{
            pathPolylines=[self polylinesForSegment:response.route.transits[0]];
        }
        
        //NSLog(@"")
        [mapViews showAnnotations:@[destination,mapViews.userLocation] animated:YES];
        //[reloadMap];
        //pathPolylines=[self ]
        
    }
}
-(NSArray*)polylinesForSegment:(AMapTransit*)segment{
    if (segment==nil||segment.segments.count==0) {
        return nil;
    
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [segment.segments enumerateObjectsUsingBlock:^(AMapSegment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger count=0;
        [paths addObject:obj];
        
        CLLocationCoordinate2D *coordi=[self coordinatesForString:obj.buslines[0].polyline coordinateCount:&count parseToken:@";"];
        NSLog(@"coordi=%f",coordi->latitude);
        MAPolyline *poly=[MAPolyline polylineWithCoordinates:coordi count:count];
        //NSLog(@"poly=%@",poly);
        [polylines addObject:poly];
        free(coordi);
        coordi=NULL;

    }];
    [self.tableview3 reloadData];
    return nil;
}
-(NSArray*)polylinesForPath:(AMapPath*)path
{
    if (path==nil||path.steps.count==0) {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    
    [path.steps enumerateObjectsUsingBlock:^(AMapStep * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger count=0;
        [paths addObject:obj];
        
        CLLocationCoordinate2D *coordi=[self coordinatesForString:obj.polyline coordinateCount:&count parseToken:@";"];
        NSLog(@"coordi=%f",coordi->latitude);
        MAPolyline *poly=[MAPolyline polylineWithCoordinates:coordi count:count];
        //NSLog(@"poly=%@",poly);
        [polylines addObject:poly];
        free(coordi);
        coordi=NULL;
    }];
    NSLog(@"path=%lu",(unsigned long)paths.count);
    //path2=paths;
    [self.tableview3 reloadData];
    return pathPolylines;
}
//-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
//{
//    return nil;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    
    return coordinates;
}




@end
