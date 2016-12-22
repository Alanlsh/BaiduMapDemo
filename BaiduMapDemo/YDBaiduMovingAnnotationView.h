//
//  YDBaiduMovingAnnotationView.h
//  BMKMapDemo
//
//  Created by Alan on 16/12/12.
//  Copyright © 2016年 云滴科技. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <CoreLocation/CoreLocation.h>

/**
 *该类为具备可平滑移动的大头针视图
 *参考demo https://github.com/cysgit/iOS_MovingAnnotation_Demo
 *来自高德地图
 */
 


@interface YDBaiduMovingAnnotationView : BMKAnnotationView

@property (nonatomic, strong) UIImage *bodyImage;
@property (nonatomic, strong) UIImageView *bodyImageView;

/**
 * brief 添加动画
 *@param points 轨迹点串，每个轨迹点为TracingPoint类型
 *@param duration  动画时长，包括从上一个动画的终止点过渡到新增动画起始点的时间
 */
- (void)addTrackingAnimationForPoints:(NSArray *)points duration:(CFTimeInterval)duration;


@end
