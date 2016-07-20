//
//  GEUTravelModeViewController.m
//  GoEuroTest
//
//  Created by Lisa Konysheva on 13/07/16.
//  Copyright © 2016 Lisa Konysheva. All rights reserved.
//

#import "GEUTravelModeViewController.h"
#import "GEUTravelModeVM.h"
#import "GEUTripCell.h"
#import "GEUUtils.h"
#import "GEUBarMenu.h"
#import "GEUNoConnectionView.h"

@interface GEUTravelModeViewController () <GEUTopMenuDelegate>

@property (nonatomic) GEUTravelModeVM *viewModel;
@property (nonatomic) IBOutlet UILabel *label;
@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) IBOutlet GEUBarMenu *sortMenu;
@property (nonatomic) IBOutlet UIView *noDataView;
@property (nonatomic) NSString *cellName;
@property (nonatomic) NSArray *cellsViewModels;
@property (nonatomic) UIActivityIndicatorView *spinner;
@property (nonatomic) BOOL needToUpdateSorting;

@end

@implementation GEUTravelModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sortMenu.titles = @[NSLocalizedString(@"Departure", nil), NSLocalizedString(@"Arrival",nil), NSLocalizedString(@"Duration", nil)];
    self.sortMenu.delegate = self;
    [self.sortMenu selectItemAtIndex:self.sortingMode];
    
    self.cellName = NSStringFromClass([GEUTripCell class]);
    UINib *cellNib = [UINib nibWithNibName:self.cellName bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:self.cellName];
    
    self.viewModel = [[GEUTravelModeVM alloc] initWithMode:self.travelMode sorting:self.sortingMode];
    
    [self configureViewModel];
    [self reloadTrips];
}

- (void)setSortingMode:(GEUSorting)sortingMode {
    if (_sortingMode != sortingMode) {
        _sortingMode = sortingMode;
        if (self.isViewLoaded && self.view.window) {
            if (self.cellsViewModels.count) {
                [self updateSorting];
            }
            [self.sortMenu selectItemAtIndex:self.sortingMode];
        } else {
            self.needToUpdateSorting = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.needToUpdateSorting) {
        self.needToUpdateSorting = NO;
        if (self.cellsViewModels.count) {
            [self updateSorting];
        }
        [self.sortMenu selectItemAtIndex:self.sortingMode];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [[NSNotificationCenter defaultCenter] postNotificationName:GEUViewControllerViewDidLayoutSubviews object:self];
}

- (void)reloadTrips {
    if (!self.viewModel) {
        return;
    }
    if (self.viewModel.isNetworkAvailable) {
        self.cellsViewModels = nil;
        self.noDataView.hidden = YES;
        [self.tableView reloadData];
        [self.viewModel loadTrips];
    } else {
        if (self.cellsViewModels.count == 0) {
            self.noDataView.hidden = NO;
        }
        [GEUNoConnectionView show];
    }
}

- (void)updateSorting {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.viewModel updateSortingWithMode:self.sortingMode];
}

- (void)configureViewModel {
    __weak typeof(self) wself = self;
    self.viewModel.tripsChanged = ^(NSArray *trips) {
        wself.cellsViewModels = trips;
        [wself.tableView reloadData];
    };
    
    self.viewModel.errorChanged = ^(NSError *error) {
        wself.noDataView.hidden = NO;
    };
    
    self.viewModel.loadingChanged = ^(BOOL loading) {
        loading ? [wself.spinner startAnimating] : [wself.spinner stopAnimating];
    };
}

#pragma mark -- Sort view delegate 

- (void)didTappedMenuItemAtIndex:(NSInteger)index {
    if (self.parent.sortingChanged) {
        self.parent.sortingChanged(index);
    }
}

#pragma mark -- TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellsViewModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GEUTripCell *cell = (GEUTripCell *)[tableView dequeueReusableCellWithIdentifier:self.cellName];
    cell.cellViewModel = self.cellsViewModels[indexPath.row];
    return cell;
}


#pragma mark -- Spinner

- (UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview:_spinner];
        _spinner.color = [UIColor GEUBlueColor];
        _spinner.center = (CGPoint){self.view.center.x, self.view.center.y - 100};
    }
    return _spinner;
}

@end
