//
//  YHPageControl.m
//  
//
//  Created by yinhan on 2020/2/3.
//  Copyright © 2020 yinhan. All rights reserved.
//

#import "YHPageControl.h"

@interface YHPageControlCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * text;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation YHPageControlCell

-(void)setIsSelect:(BOOL)isSelect {
    if (isSelect) {
        self.backgroundColor = [UIColor whiteColor];
        self.text.textColor = [UIColor colorWithRed:225/255.0 green:141/255.0 blue:81/255.0 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor clearColor];
        self.text.textColor = [UIColor whiteColor];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 10, frame.size.width, frame.size.height);
        _text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _text.textAlignment = NSTextAlignmentCenter;
        _text.font = [UIFont boldSystemFontOfSize:15];
        _text.textColor = [UIColor colorWithRed:225/255.0 green:141/255.0 blue:81/255.0 alpha:1.0];
        [self addSubview:_text];

    }
    return self;
}
@end

@interface YHPageControl () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray * arrayItem;
@property (nonatomic, strong) UICollectionView * myCollection;

@end

@implementation YHPageControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _arrayItem = [[NSMutableArray alloc] init];
        [self.myCollection registerClass:[YHPageControlCell class] forCellWithReuseIdentifier:@"strCell"];
        self.myCollection.delegate = self;
        self.myCollection.dataSource = self;
        [self addSubview:_myCollection];
        [self.myCollection reloadData];
    }
    return self;
}

-(UICollectionView *)myCollection {
    if (_myCollection == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGRect rect = CGRectMake(5, 0, self.frame.size.width - 10, self.frame.size.height);
        _myCollection = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _myCollection.backgroundColor = [UIColor clearColor];
        _myCollection.showsHorizontalScrollIndicator = NO;
        _myCollection.showsVerticalScrollIndicator = NO;
    }
    return _myCollection;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectIndex:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrayItem.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YHPageControlCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"strCell" forIndexPath:indexPath];
    [self adjuestCell:cell andIndex:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70, collectionView.frame.size.height - 10);
}

-(void)adjuestCell:(YHPageControlCell *)cell andIndex:(NSIndexPath *)indexPath {
    if (_pageIndex == indexPath.row) {
        cell.isSelect = YES;
    } else {
        cell.isSelect = NO;
    }
    cell.text.text = [_arrayItem objectAtIndex:indexPath.row];
    cell.layer.cornerRadius = cell.frame.size.height * 0.5;
    cell.layer.masksToBounds = YES;
}

-(void)setItems:(NSArray *)items {
    if (items && items.count > 0) {
        [_arrayItem removeAllObjects];
        [_arrayItem addObjectsFromArray:items];
        [_myCollection reloadData];
    }
}

-(NSArray *)items {
    return [_arrayItem copy];
}


-(void)setPageIndex:(NSInteger)pageIndex {
    if (_arrayItem.count >= pageIndex) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
            [self.myCollection selectItemAtIndexPath:indexPath animated:NO scrollPosition:(UICollectionViewScrollPositionNone)];
            [self selectIndex:indexPath];
        });
    }
}

-(void)selectIndex:(NSIndexPath *)indexPath {
    YHPageControlCell * selCell = (YHPageControlCell *)[self.myCollection cellForItemAtIndexPath:indexPath];
    for (int i = 0; i < [self.myCollection visibleCells].count; i++) {
        YHPageControlCell * cell = [[self.myCollection visibleCells] objectAtIndex:i];
        if (cell == selCell) {
            selCell.isSelect = YES;
            _pageIndex = indexPath.row;
            if (self.onClickItem) {
                self.onClickItem(selCell.text.text, _pageIndex);
            }
        } else {
            cell.isSelect = NO;
        }
    }
}


@end
