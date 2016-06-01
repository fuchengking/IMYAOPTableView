//
//  IMYAOPTableViewUtils.h
//  IMYAdvertisementDemo
//
//  Created by ljh on 16/4/15.
//  Copyright © 2016年 IMY. All rights reserved.
//

#import "IMYAOPTableViewInsertBody.h"
#import "IMYAOPTableViewUtilsDefine.h"
#import <UIKit/UIKit.h>

/**
 *  请通过TableView 的 aop_utils 方法，获取该实例, 禁止独立初始化
 */
@interface IMYAOPTableViewUtils : NSObject <IMY_UNAVAILABLE_ATTRIBUTE_ALLOC>

@property (nonatomic, readonly, weak) UITableView* tableView;

///AOP TableView 的回调
@property (nonatomic, weak) id<IMYAOPTableViewDelegate> delegate;
@property (nonatomic, weak) id<IMYAOPTableViewDataSource> dataSource;

///插入sections 跟 indexPaths
- (void)insertWithSections:(NSArray<IMYAOPTableViewInsertBody*>*)sections;
- (void)insertWithIndexPaths:(NSArray<IMYAOPTableViewInsertBody*>*)indexPaths;

///是否合并刷新, 如果开启会有个0.2的间隔来进行合并刷新  Default:NO
@property (nonatomic, assign) BOOL combineReloadData;

@end

///Translate IndexPath
@interface IMYAOPTableViewUtils (IndexPath)

///table的 indexPath 转 逻辑调用的indexPath
- (NSIndexPath*)realIndexPathByTable:(NSIndexPath*)tableIndexPath;
///逻辑indexPath 转 table 使用的indexPath
- (NSIndexPath*)tableIndexPathByReal:(NSIndexPath*)realIndexPath;

///table的section 转 逻辑调用的section
- (NSInteger)realSectionByTable:(NSInteger)tableSection;
///逻辑section 转 table 使用的section
- (NSInteger)tableSectionByReal:(NSInteger)realSection;

/// 数组转换, 效果跟上面一样
- (NSArray<NSIndexPath*>*)realIndexPathsByTableIndexPaths:(NSArray<NSIndexPath*>*)tableIndexPaths;
- (NSArray<NSIndexPath*>*)tableIndexPathsByRealIndexPaths:(NSArray<NSIndexPath*>*)realIndexPaths;

- (NSIndexSet*)realSectionsByTableSet:(NSIndexSet*)tableSet;
- (NSIndexSet*)tableSectionsByRealSet:(NSIndexSet*)realSet;

@end
