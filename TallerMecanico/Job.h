//
//  Job.h
//  TallerMecanico
//
//  Created by FUTAPP on 28/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Job : RLMObject

@property NSString* brand;
@property int year;
@property NSString* descriptionJob;
@property NSString* user;
@property double cost;
@property NSDate* createdDate;
@property NSInteger daySearch;
@property NSInteger monthSearch;
@property NSInteger yearSearch;

@end
RLM_ARRAY_TYPE(Job);