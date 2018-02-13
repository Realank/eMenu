//
//  MenuViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "MenuViewController.h"
#import "DishCollectionViewCell.h"
#import "CollectionHeaderView.h"
#import "DishDetailViewController.h"
#import "CartViewController.h"
#define kLayoutRatio (2.0/1.0)
@interface MenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource,DishOrderChangeDelegate,UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dishTypeListView;
@property (weak, nonatomic) IBOutlet UICollectionView *dishDisplayCollectionView;
@property (nonatomic, assign) BOOL isScrollDown;
@property (nonatomic, weak) UIButton* cartButton;
@property (nonatomic, weak) UIBarButtonItem* cartItem;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNaviBar];
    [self setupTableView];
    [self updateCartButton];
}

- (void)viewDidLayoutSubviews{
    [self setupCollectionView];
}

- (void)dealloc{
    
}

- (void)wantOrder:(BOOL)order dish:(RLKDish *)dish{
    if (order) {
        [_menu orderDish:dish];
    }else{
        [_menu disOrderDish:dish];
    }
    [self reloadData];
}

- (void)updateCartButton{
    NSInteger orderCount = [_menu orderedDishes].count;
    [_cartButton setTitle:[NSString stringWithFormat:@"%ld",orderCount] forState:UIControlStateNormal];
}

- (void)showDetailOfDish:(RLKDish*)dish{
    DishDetailViewController* vc = [[DishDetailViewController alloc] init];
    vc.dish = dish;
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)reloadData{
    [self.dishDisplayCollectionView reloadData];
    [self updateCartButton];
}

#pragma mark - navi bar

- (void)setupNaviBar{
    UIButton* cartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    [cartButton addTarget:self action:@selector(showCart) forControlEvents:UIControlEventTouchUpInside];
    [cartButton setTitle:@"0" forState:UIControlStateNormal];
    [cartButton setRoundCornerRadius];
    cartButton.backgroundColor = kThemeColor;
    [cartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    [self.navigationItem setRightBarButtonItem:barButton];
    _cartButton = cartButton;
    _cartItem = barButton;
}

- (void)showCart{
    CartViewController *vc = [[CartViewController alloc] init];
    vc.menu = _menu;
    vc.preferredContentSize = CGSizeMake(300, 500);
    vc.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController* poC = [vc popoverPresentationController];
    //    poC.barButtonItem = [self.navigationItem leftBarButtonItem];
    poC.barButtonItem = _cartItem;
    poC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    poC.delegate = self;
    [self presentViewController:vc animated:NO completion:nil];
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - table view

- (void)setupTableView{
    self.dishTypeListView.delegate = self;
    self.dishTypeListView.dataSource = self;
    [self.dishTypeListView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menu.categories.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (row < _menu.categories.count) {
        RLKCategory* cat =_menu.categories[row];
        cell.textLabel.text = cat.name;
    }else{
        cell.textLabel.text = @"其它";
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
    
}



#pragma mark - collection view

- (void)setupCollectionView{
    
    for (int i = 0; i < _menu.dishes.count; i++) {
        [DishCollectionViewCell registerCellWithCollectionView:_dishDisplayCollectionView forIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
//    [_dishDisplayCollectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"CollectionHeader"];
    [_dishDisplayCollectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
    self.dishDisplayCollectionView.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth = 225;
    CGFloat cellHeight = 265;
    CGFloat collectionViewWidth = _dishDisplayCollectionView.width;
    NSInteger itemsInOneRow = (NSInteger)(collectionViewWidth / cellWidth);
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
    NSInteger space = (collectionViewWidth - itemsInOneRow*cellWidth)/(itemsInOneRow+1);
//    space = space > 20 ? space : 20;
    layout.minimumInteritemSpacing = space;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(5, space, 10, space);
    layout.headerReferenceSize = CGSizeMake(100, 30);
    self.dishDisplayCollectionView.collectionViewLayout = layout;
    
    self.dishDisplayCollectionView.delegate = self;
    self.dishDisplayCollectionView.dataSource = self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _menu.categories.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < _menu.categories.count) {
        RLKCategory* cat = _menu.categories[section];
        NSArray* dishes = _menu.dishesByCategory[cat.type];
        return dishes.count;
    }else{
        return _menu.dishesNoCategory.count;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DishCollectionViewCell* cell = [DishCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.section < _menu.categories.count) {
        RLKCategory* cat = _menu.categories[indexPath.section];
        NSArray* dishes = _menu.dishesByCategory[cat.type];
        RLKDish* dish = dishes[indexPath.row];
        cell.dish = dish;
    }else{
        RLKDish* dish = _menu.dishesNoCategory[indexPath.row];
        cell.dish = dish;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
        NSString* headerName = nil;
        if (indexPath.section < _menu.categories.count) {
            RLKCategory* cat =_menu.categories[indexPath.section];
            headerName = cat.name;
        }else{
            headerName = @"其它";
        }
        CollectionHeaderView* header = (CollectionHeaderView*)[_dishDisplayCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        header.textLabel.text = headerName;
        return header;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RLKDish* dish = nil;
    if (indexPath.section < _menu.categories.count) {
        RLKCategory* cat = _menu.categories[indexPath.section];
        NSArray* dishes = _menu.dishesByCategory[cat.type];
        dish = dishes[indexPath.row];
    }else{
        dish = _menu.dishesNoCategory[indexPath.row];
    }
    [self showDetailOfDish:dish];
}

#pragma mark - traking

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSIndexPath* collectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:row];
    
    if (_dishDisplayCollectionView.dragging) {
        return;
    }
    if ([_dishDisplayCollectionView numberOfItemsInSection:collectionIndexPath.section] > 0) {
        [_dishDisplayCollectionView scrollToItemAtIndexPath:collectionIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
    
}

// 标记一下 CollectionView 的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    if (self.dishDisplayCollectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

// CollectionView 分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    // 当前 CollectionView 滚动的方向向上， CollectionView 是用户拖拽而产生滚动的（主要是判断 CollectionView 是用户拖拽而滚动的，还是点击 TableView 而滚动的）
    if (!_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView 分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // 当前 CollectionView 滚动的方向向下， CollectionView 是用户拖拽而产生滚动的（主要是判断 CollectionView 是用户拖拽而滚动的，还是点击 TableView 而滚动的）
    if (_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动 CollectionView 的时候，处理 TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.dishTypeListView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
@end
