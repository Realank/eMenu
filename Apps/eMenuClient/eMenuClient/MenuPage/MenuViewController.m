//
//  MenuViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "MenuViewController.h"
#import "DishCollectionViewCell.h"
#define kLayoutRatio (2.0/1.0)
@interface MenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dishTypeListView;
@property (weak, nonatomic) IBOutlet UICollectionView *dishDisplayCollectionView;
@property (nonatomic, assign) BOOL isScrollDown;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
    [self setupCollectionView];
}

- (void)dealloc{
    
}
#pragma mark - table view

- (void)setupTableView{
    self.dishTypeListView.delegate = self;
    self.dishTypeListView.dataSource = self;
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
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}



#pragma mark - collection view

- (void)setupCollectionView{
    
    for (int i = 0; i < _menu.dishes.count; i++) {
        [DishCollectionViewCell registerCellWithCollectionView:_dishDisplayCollectionView forIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    self.dishDisplayCollectionView.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth = 225;
    CGFloat cellHeight = 265;
    CGFloat collectionViewWidth = _dishDisplayCollectionView.width;
    NSInteger itemsInOneRow = 1;
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
    NSInteger space = (collectionViewWidth - itemsInOneRow*cellWidth)/(itemsInOneRow+1);
    space = space > 20 ? space : 20;
    layout.minimumInteritemSpacing = space;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 10, 0);
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
}

#pragma mark - traking

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSIndexPath* collectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:row];
    if (_dishDisplayCollectionView.tracking) {
        return;
    }
    if ([_dishDisplayCollectionView numberOfItemsInSection:collectionIndexPath.section] > 0) {
        [_dishDisplayCollectionView scrollToItemAtIndexPath:collectionIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
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
