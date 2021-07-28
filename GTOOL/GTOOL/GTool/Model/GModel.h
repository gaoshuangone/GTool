//
//  GModel.h
//  GTOOL
//
//  Created by tg on 2020/12/23.
//

#import <Foundation/Foundation.h>
#import "GModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface GModel : NSObject<NSCoding,GArchiveModelProtocol,GModelProtocol,GDBModelProtocol>

@end

NS_ASSUME_NONNULL_END
