//
//  RequestResponseObject.h
//  Allista
//
//  Created by Mina Malak on 1/12/14.
//  Copyright (c) 2014 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestResponseObject : NSObject

@property (strong,nonatomic) NSError * error;
@property (strong, nonatomic) id value;


@end
