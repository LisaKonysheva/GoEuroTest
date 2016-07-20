//
//  GEUContainerController.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 7/13/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUContainerController.h"
#import "GEUTravelModeViewController.h"
#import "GEUBarMenu.h"

static NSInteger const GEUNumberOfPages = 3;

@interface GEUContainerController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, GEUTopMenuDelegate>

@property (nonatomic) UIPageViewController *pageController;
@property (nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) IBOutlet GEUBarMenu *topMenu;
@property (nonatomic) GEUTravelModeViewController *currentController;
@property (nonatomic) NSArray *controllers;

@end

@implementation GEUContainerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureTopMenu];
    [self configurePageController];
    
    __weak typeof(self) wself = self;
    self.sortingChanged = ^(GEUSorting sorting) {
        for (GEUTravelModeViewController *vc in wself.controllers) {
            vc.sortingMode = sorting;
        }
    };
}

#pragma mark Configuration

- (void)configureTopMenu {
    self.topMenu.titles = @[NSLocalizedString(@"Flights", nil), NSLocalizedString(@"Trains", nil), NSLocalizedString(@"Buses", nil)];
    self.topMenu.delegate = self;
}

- (void)configurePageController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.pageController setViewControllers:@[self.controllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    
    [self addChildViewController:self.pageController];
    [self.containerView addSubview:self.pageController.view];
    self.pageController.view.frame = self.containerView.bounds;
    [self.pageController willMoveToParentViewController:self];
}

- (GEUTravelModeViewController *)pageWithMode:(GEUTravelMode)mode {
    GEUTravelModeViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([GEUTravelModeViewController class])];
    vc.parent = self;
    vc.travelMode = mode;
    vc.sortingMode = GEUSortingDeparture;
    return vc;
}

- (NSArray *)controllers {
    if (!_controllers) {
        NSMutableArray *controllersMutable = [NSMutableArray array];
        for (int i = 0; i < GEUNumberOfPages; i++) {
            [controllersMutable addObject:[self pageWithMode:i + 1]];
        }
        _controllers = [controllersMutable copy];
    }
    return _controllers;
}

#pragma mark GEUTopMenuDelegate

- (void)didTappedMenuItemAtIndex:(NSInteger)index {
    GEUTravelModeViewController *page = self.controllers[index - 1];
    [page reloadTrips];
    [self.pageController setViewControllers:@[page] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark PageViewController delegate + datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == GEUNumberOfPages - 1) {
        return nil;
    }
    return self.controllers[index + 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return self.controllers[index - 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        NSInteger index = [self.controllers indexOfObject:pageViewController.viewControllers[0]];
        [self.topMenu selectItemAtIndex:index + 1];
    }
}

@end
