//
//  IMYAOPCollectionViewUtils+DataSource.m
//  IMYAOPFeedsView
//
//  Created by ljh on 16/5/20.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import "IMYAOPCollectionViewUtils+DataSource.h"
#import "IMYAOPCollectionViewUtils+Private.h"

#define kAOPRealIndexPathCode                                           \
    NSIndexPath *userIndexPath = [self userIndexPathByFeeds:indexPath]; \
    id<IMYAOPCollectionViewDataSource> dataSource = nil;                \
    if (userIndexPath) {                                                \
        dataSource = (id)self.origDataSource;                           \
        indexPath = userIndexPath;                                      \
    } else {                                                            \
        dataSource = self.dataSource;                                   \
    }

#define kAOPRealSectionCode                                    \
    NSInteger userSection = [self userSectionByFeeds:section]; \
    id<IMYAOPCollectionViewDataSource> dataSource = nil;       \
    if (userSection >= 0) {                                    \
        dataSource = (id)self.origDataSource;                  \
        section = userSection;                                 \
    } else {                                                   \
        dataSource = self.dataSource;                          \
    }

#define kAOPUICallingSaved \
    self.isUICalling -= 1;

#define kAOPUICallingResotre \
    self.isUICalling += 1;

@implementation IMYAOPCollectionViewUtils (UICollectionViewDataSource)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    kAOPUICallingSaved;
    NSInteger numberOfSection = 1;
    if ([self.origDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        numberOfSection = [self.origDataSource numberOfSectionsInCollectionView:collectionView];
    }
    ///初始化回调
    [self.dataSource aopCollectionUtils:self numberOfSections:numberOfSection];

    ///总number section
    if (numberOfSection > 0) {
        numberOfSection = [self feedsSectionByUser:numberOfSection];
    }
    kAOPUICallingResotre;
    return numberOfSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    kAOPUICallingSaved;
    NSInteger userSection = [self userSectionByFeeds:section];
    NSInteger rowCount = 0;
    if (userSection >= 0) {
        section = userSection;
        rowCount = [self.origDataSource collectionView:collectionView numberOfItemsInSection:section];

        NSIndexPath *feedsIndexPath = [self feedsIndexPathByUser:[NSIndexPath indexPathForRow:rowCount inSection:section]];
        rowCount = feedsIndexPath.row;
    } else {
        NSMutableArray<NSIndexPath *> *array = self.sectionMap[@(section)];
        for (NSIndexPath *obj in array) {
            if (obj.row <= rowCount) {
                rowCount += 1;
            } else {
                break;
            }
        }
    }
    kAOPUICallingResotre;
    return rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    kAOPUICallingSaved;
    kAOPRealIndexPathCode;
    UICollectionViewCell *cell = nil;
    if ([dataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        cell = [dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    if (![cell isKindOfClass:[UICollectionViewCell class]]) {
        cell = [UICollectionViewCell new];
        if (dataSource) {
            NSAssert(NO, @"Cell is Nil");
        }
    }
    kAOPUICallingResotre;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    kAOPUICallingSaved;
    kAOPRealIndexPathCode;
    UICollectionReusableView *reusableView = nil;
    if ([dataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        reusableView = [dataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    if (![reusableView isKindOfClass:[UICollectionReusableView class]]) {
        reusableView = [UICollectionReusableView new];
        if (dataSource) {
            NSAssert(NO, @"Cell is Nil");
        }
    }
    kAOPUICallingResotre;
    return reusableView;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    kAOPUICallingSaved;
    kAOPRealIndexPathCode;
    BOOL canMove = NO;
    if ([dataSource respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)]) {
        canMove = [dataSource collectionView:collectionView canMoveItemAtIndexPath:indexPath];
    }
    kAOPUICallingResotre;
    return canMove;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    kAOPUICallingSaved;
    NSIndexPath *source = [self userIndexPathByFeeds:sourceIndexPath];
    NSIndexPath *destin = [self userIndexPathByFeeds:destinationIndexPath];
    if ([self.origDataSource respondsToSelector:@selector(collectionView:moveItemAtIndexPath:toIndexPath:)]) {
        [self.origDataSource collectionView:collectionView moveItemAtIndexPath:source toIndexPath:destin];
    }
    kAOPUICallingResotre;
}

- (NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView {
    NSAssert(NO, @"NO Impl");
    return nil;
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSAssert(NO, @"NO Impl");
    return nil;
}

@end
