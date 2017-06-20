//
//  YCLJ_Header.h
//  Pods
//
//  Created by Adam on 2017/6/15.
//
//

#ifndef YCLJ_Header_h
#define YCLJ_Header_h

// debug
#ifdef DEBUG
#    define DLog(...)     NSLog(__VA_ARGS__)
#else
#    define DLog(...)
#endif

#define YCLJ_HOST_URL           @"http://leju.yun.com/leju/signin/"

// system info
#define CURRENT_OS_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]

// 动态获取设备参数SCREEN_WIDTH
#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define SCREEN_HEIGHT_OFFSET    64
#define SCREEN_SCALE      [UIScreen mainScreen].scale

// 颜色
#define HEX_COLOR(__STR)    [UIColor colorWithHexString:__STR]
#define TRANSPARENT_COLOR   [UIColor clearColor]

#define NAVI_BAR_BG_COLOR            @"0x5ed8cd"
#define VIEW_BG_COLOR                @"0xeeeded"
#define CELL_BG_COLOR                @"0xffffff"

#endif /* YCLJ_Header_h */
