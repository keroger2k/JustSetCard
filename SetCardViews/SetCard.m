//
//  SetCard.m
//  Matchismo
//
//  Created by Kyle Rogers on 9/8/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;  //because we provide setter and getter
@synthesize color = _color;  //because we provide setter and getter
@synthesize shade = _shade;  //because we provide setter and getter



- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] >= 1) {
        
        int shapeMatches = 0;
        int colorMatches = 0;
        int rankMatches = 0;
        int shadeMatches = 0;
        
        for(int i = 0; i < [otherCards count]; i++) {
            SetCard *otherCard = otherCards[i];
            
            if([self.shade isEqualToString:otherCard.shade]) {
                shadeMatches += 1;
            } else if ([self.shape isEqualToString:otherCard.shape]) {
                shapeMatches += 1;
            } else if ([self.color isEqualToString:otherCard.color]) {
                colorMatches += 1;
            } else if (self.rank == otherCard.rank) {
                rankMatches += 1;
            }
        }
        
        if(shadeMatches == 0 && colorMatches == 0 && rankMatches == 0 && shapeMatches == 0){
            score += 10;
        }
        
    }
    return score;
}



- (NSString *)contents {
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.shape, self.color, self.shade, self.rank];
}



+ (NSArray *)validShapes
{
    return @[@"oval",@"squiggle", @"diamond"];
}

- (void)setShape:(NSString *)shape
{
    if([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
    
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

- (void)setColor:(NSString *)color
{
    if([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
    
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

+ (NSArray *)validShades
{
    return @[@"solid", @"striped", @"open"];
}

- (void)setShade:(NSString *)shade
{
    if([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
    
}

- (NSString *)shade
{
    return _shade ? _shade : @"?";
}


+ (NSUInteger)maxRank { return 3; }

- (void)setRank:(NSUInteger)rank
{
    if(rank <= 3){
        _rank = rank;
    }
}

@end
