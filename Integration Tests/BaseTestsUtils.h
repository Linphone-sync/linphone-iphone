//
//  BaseTestsUtils.h
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 13/07/2014.
//
//

#import "SLTest.h"

@interface BaseTestsUtils : SLTest

- (void)addContactPopupHandler;
- (void)addWizardPopupHandler;

- (void)exitWizardIfNecessary;

- (void)goToSettings;

- (void)checkIsRegisteredWithDelay:(CGFloat)delay;

@end
