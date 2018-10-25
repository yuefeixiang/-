//
//  ViewController.m
//  动画
//
//  Created by mc on 2018/6/21.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "ViewController.h"

#import <Lottie/Lottie.h>
#import "yyViewController.h"
#import "Model.h"

//#import "NSObject+string.h"
#import "MBProgressHUD.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property(nonatomic,strong)UIButton *bt;
@property(nonatomic,strong)UIImageView *leftmyImageView;
@property(nonatomic,strong)UIImageView *bigImageView;

@property (strong, nonatomic)LOTAnimationView *third_information_AnimationView;//的动画

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [MBProgressHUD showHUDAddedTo:self.view
                         //animated:YES];
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
    //hud.label.text = @"加载中...";
    
    //hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
//    UIView *iv = [[UIView alloc] init];
//    iv.backgroundColor = [UIColor greenColor];
//    iv.frame = CGRectMake(0, 0, 200, 100);
//    hud.customView = iv;
    //hud.animationType = MBProgressHUDAnimationZoomOut;
    
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor blackColor];

//    [self third_information_AnimationView];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
//    UILabel *my_variable_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 200, 40)];
//    [self.view addSubview:my_variable_nameLabel];
//    my_variable_nameLabel.backgroundColor = [UIColor greenColor];
//    my_variable_nameLabel.textAlignment = NSTextAlignmentCenter;
//    my_variable_nameLabel.font =  [UIFont fontWithName:@"Didot" size:30.0f];
//    my_variable_nameLabel.text = @"1234567890";
//    my_variable_nameLabel.textColor = LXblack;
    
}


-(LOTAnimationView *)third_information_AnimationView{
    if (_third_information_AnimationView == nil) {
        //animationNamed:@"gus"];
        
        _third_information_AnimationView =
        //[LOTAnimationView animationNamed:@"pai"];
        
        [[LOTAnimationView alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://binting.oss-cn-shanghai.aliyuncs.com/channel/pai.json"]];
        
        _third_information_AnimationView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 600);
        
//      _third_information_AnimationView.center = self.view.center;
        
        _third_information_AnimationView.backgroundColor = [UIColor clearColor];
        _third_information_AnimationView.loopAnimation = true;
        _third_information_AnimationView.contentMode = UIViewContentModeScaleToFill;
        _third_information_AnimationView.animationSpeed = 1;
        [self.view.layer addSublayer:_third_information_AnimationView.layer];
        
    }
    return _third_information_AnimationView;
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;

    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), nil, YES);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    
    UIImage *finalImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(mask);
    CGImageRelease(masked);
    
    return finalImage;
}

-(UIImageView *)leftmyImageView{
    
    if (_leftmyImageView == nil) {
        
        _leftmyImageView = [UIImageView new];
        [self.bigImageView addSubview:_leftmyImageView];
        _leftmyImageView.frame = CGRectMake(50, 40, 50, 50);
        
        UIImage *bigImage = [UIImage imageNamed:@"22"];
        
        CGFloat width = bigImage.size.width / self.bigImageView.frame.size.width;
        CGFloat height = bigImage.size.height / self.bigImageView.frame.size.height;
        
        CGRect rect = CGRectMake((150 * width) * 2, (40 * height) * 2,( 50 * width) * 2, (50 * height) * 2);//创建矩形框//*2=@2x
        
//        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(150, 40, 50, 50)];
//        view.image = [UIImage imageNamed:@"small11"];
//        [self.bigImageView addSubview:view];
        
        CGImageRef cgImage = CGImageCreateWithImageInRect([[UIImage imageNamed:@"22"] CGImage], rect);
        
        UIImage *smallImage = [UIImage imageWithCGImage:cgImage];
        
        _leftmyImageView.image = [self maskImage:smallImage withMask:[UIImage imageNamed:@"small22"]];
        
        CGImageRelease(cgImage);
    }
    
    return _leftmyImageView;
}

-(UIImageView *)bigImageView{
    
    if (_bigImageView == nil) {
        
        _bigImageView = [UIImageView new];
        [self.view addSubview:_bigImageView];
        
        _bigImageView.frame = CGRectMake(50, 50, 300, 150);
        _bigImageView.image = [UIImage imageNamed:@"22"];
    }
    
    return _bigImageView;
}



-(UIButton *)bt{
    if (_bt == nil) {
        _bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_bt];
        _bt.frame = CGRectMake(100, 100, 100, 100);
        [_bt addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        _bt.backgroundColor = [UIColor greenColor];
    }
    return _bt;
}

- (void)touch:(UIButton *)sender {
    
    yyViewController *vc = [yyViewController new];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting
         sourceController:(UIViewController *)source {
    
    // vcTransition1.json 是一个动画的 json 文件，传参的时候，不用带后缀 .json
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"LottieLogo1" fromLayerNamed:@"outLayer" toLayerNamed:@"inLayer" applyAnimationTransform:YES];
    
    // 返回一个准守 UIViewControllerAnimatedTransitioning 协议对象
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"LottieLogo1" fromLayerNamed:@"outLayer" toLayerNamed:@"inLayer" applyAnimationTransform:YES];
    
    return animationController;
}

@end
