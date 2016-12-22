//
//  BaiduMapManager.m
//  BMKMapDemo
//
//  Created by Alan on 16/12/12.
//  Copyright © 2016年 云滴科技. All rights reserved.
//

#import "BaiduMapManager.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h> //引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "YDBaiduMovingAnnotationView.h"

//,BMKPoiSearchDelegate,BMKRouteSearchDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate
@interface BaiduMapManager ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService *_locationService;
    BOOL _isFirstLocation;
    BMKPointAnnotation *_pointAnnotation;
    UIImageView *_imageView;
    
    
}

@end

@implementation BaiduMapManager

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
    
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
   
    
    mapView.delegate = self;
   
    _mapView = mapView;
    [self.view addSubview:_mapView];
    
    _locationService =  [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    [_locationService startUserLocationService];
    
     _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;

    
    


    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor =[UIColor redColor];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
   
    CLLocationCoordinate2D userLocationCoordinate =_locationService.userLocation.location.coordinate;
    [_mapView setCenterCoordinate:userLocationCoordinate];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recover) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    
}

- (void)recover
{

    if (_imageView) {
        
        [_imageView.layer removeAllAnimations];
        
        CAKeyframeAnimation *annimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
        annimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        annimation.values   = @[@0, @(M_PI_2), @(M_PI), @(M_PI+M_PI_2), @(2*M_PI)];
        annimation.duration =  2;
        annimation.repeatCount = CGFLOAT_MAX;
        annimation.fillMode = kCAFillModeForwards;

        [_imageView.layer addAnimation:annimation forKey:@"transform.rotation"];
        
       }

}


- (void)buttonClicked:(id)sender
{
    
//    [UIView animateWithDuration:5 animations:^{
//        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude + 0.01);
//        _pointAnnotation.coordinate = coordinate;
//    }];
    [self reloadAnonotationCoordinates:nil];
   
    
}




- (void)reloadAnonotationCoordinates:(NSArray *)coordinates
{
    
    
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude + 0.01);
    
    CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude - 0.01, _pointAnnotation.coordinate.longitude + 0.02);
    
    
    CLLocationCoordinate2D coordinate3 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude + 0.01);
    
    CLLocationCoordinate2D coordinate4 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude - 0.04);

    
    CLLocationCoordinate2D *acoordinates = (CLLocationCoordinate2D *)malloc(4*sizeof(CLLocationCoordinate2D));
    
  
    acoordinates[0] = coordinate1;
    acoordinates[1] = coordinate2;
    acoordinates[2] = coordinate3;
    acoordinates[3] = coordinate4;
    
    
    
    
    for (int i = 0; i < 4; i ++)
    {
        
            [UIView animateWithDuration:1.25 delay:1.25 * i options:UIViewAnimationOptionLayoutSubviews animations:^{
                switch (i) {
                    case 0:
                        _pointAnnotation.coordinate = acoordinates[0];
                        break;
                    case 1:
                        _pointAnnotation.coordinate = acoordinates[1];
                        break;
                        
                    case 2:
                        _pointAnnotation.coordinate = acoordinates[2];
                        break;
                    case 3:
                        _pointAnnotation.coordinate = acoordinates[3];
                        break;
                        
                        
                    default:
                        break;
                }
            } completion:^(BOOL finished) {
                
            }];
    }
            
}






#pragma mark - BMKMapViewDelegate

/**
 *根据annotation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    /**
     显示车辆图标需使用 BMKAnnotationView 对象
     BMKPinAnnotationView 对象会发生偏移
     
     */
    NSLog(@"___________________________________");
    
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKAnnotationView *newAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        // 须设置
        newAnnotationView.bounds = CGRectMake(0, 0, 60, 60);
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
//        newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
//
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.backgroundColor = [UIColor blackColor];
        label.text = @"1342411234344431";
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        
        
        CAKeyframeAnimation *annimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
        annimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        annimation.values   = @[@0, @(M_PI_2), @(M_PI), @(M_PI+M_PI_2), @(2*M_PI)];
        annimation.duration =  2;
        annimation.repeatCount = CGFLOAT_MAX;
        annimation.fillMode = kCAFillModeForwards;
        [label.layer addAnimation:annimation forKey:@"transform.rotation"];
        
        
        newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:view];
        
        // 选中状态才会显示气泡
        newAnnotationView.selected = YES;
       
        // 须设置
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _imageView.layer.cornerRadius = 30;
        _imageView.clipsToBounds = YES;
        _imageView.image = [UIImage imageNamed:@"121"];
        [newAnnotationView addSubview:_imageView];
        
        [_imageView.layer addAnimation:annimation forKey:@"transform.rotation"];
        
        
        
        
        return newAnnotationView;
    }
    
    return nil;
}


#pragma mark - BMKLocationServiceDelegate
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"_____________定位失败__%@____________________",error);

}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
     [_mapView updateLocationData:userLocation];
//    NSLog(@"________________用户方向更新后___________________");
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
    if (!_isFirstLocation) {
        _isFirstLocation = YES;
        
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
        _pointAnnotation.coordinate = _locationService.userLocation.location.coordinate;
        _pointAnnotation.title = @"大哥的所在地";
        _pointAnnotation.subtitle = @"你瞅啥呢  瞅你咋地";
        
        
        [_mapView selectAnnotation:_pointAnnotation animated:YES];
        [_mapView addAnnotation:_pointAnnotation];
        
        _mapView.centerCoordinate = _locationService.userLocation.location.coordinate;

    }
    
      NSLog(@"______________用户位置更新后，会调用此函数______%@_______________",userLocation.title);

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
 
}

@end
