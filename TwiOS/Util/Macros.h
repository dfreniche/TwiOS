//
//  Macros.h
//  TwiOS
//
//  Created by Diego Freniche Brito on 12/03/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#ifndef TwiOS_Macros_h
#define TwiOS_Macros_h

#ifndef NS_DESIGNATED_INITIALIZER
#if __has_attribute(objc_designated_initializer)
#define NS_DESIGNATED_INITIALIZER __attribute((objc_designated_initializer))
#else
#define NS_DESIGNATED_INITIALIZER
#endif
#endif

#endif
