//
//  GModel.h
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import <Foundation/Foundation.h>
#import "DBMangerProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface GArchiveModel : NSObject<NSCoding,DBMangerProtocol>
@property (strong, nonatomic)NSMutableArray* archiveArray;
@property (strong, nonatomic)NSMutableDictionary* archiveDict;


@end

NS_ASSUME_NONNULL_END
