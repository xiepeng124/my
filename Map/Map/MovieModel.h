//
//  MovieModel.h
//  Map
//
//  Created by 汪杰 on 16/8/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject
@property(nonatomic,strong)NSMutableArray *ratings;
@property(nonatomic,strong)NSMutableArray *runtimes;
@property(nonatomic,strong)NSMutableArray *languages;
@property(nonatomic,strong)NSMutableArray *posters;
@property(nonatomic,strong)NSMutableArray *film_locationss;
@property(nonatomic,strong)NSMutableArray *directorss;
@property(nonatomic,strong)NSMutableArray *rating_count;
@property(nonatomic,strong)NSMutableArray *actorss;
@property(nonatomic,strong)NSMutableArray *plot_simples;
@property(nonatomic,strong)NSMutableArray *years;
@property(nonatomic,strong)NSMutableArray *countrys;
@property(nonatomic,strong)NSMutableArray *release_dates;
@property(nonatomic,strong)NSMutableArray *titles;
@end
//"rating": "7.3",
//"genres": "动作/惊悚/科幻",
//"runtime": "139 min",
//"language": "英语/法语/日语",
//"title": "哥斯拉",
//"poster": "http://v.juhe.cn/movie/img?5146",
//"writers": "迪安·德夫林,罗兰·艾默里奇,...",
//"film_locations": "美国",
//"directors": "罗兰·艾默里奇",
//"rating_count": "3191",
//"actors": "马修·布罗德里克 Matthew Broderick,让·雷诺 Jean Reno,玛丽亚·皮提罗 Maria Pitillo,汉克·阿扎利亚 Hank Azaria",
//"plot_simple": "一道亮光划过天际，太平洋上波涛汹涌，海浪以不可思议的速度将一架货机卷入海里；巴哈马丛林中，出现了巨大的脚印；一股神秘的力量一直朝纽约而来，这座人口稠密的都市即将受到这个怪兽“哥斯拉”的袭击。“哥斯拉”是因为核试验造成气..",
//"year": "1998",
//"country": "美国",
//"type": "null",
//"release_date": "19980518",
//"also_known_as": "酷斯拉,怪兽哥斯拉"