/*
 * iSGL3D: http://isgl3d.com
 *
 * Copyright (c) 2010-2011 Stuart Caunt
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "BillboardTestView.h"
#import "Isgl3dDemoCameraController.h"

@implementation BillboardTestView

- (void) dealloc {
	[[Isgl3dTouchScreen sharedInstance] removeResponder:_cameraController];
	[_cameraController release];

	[super dealloc];
}

- (void) initView {
	[super initView];

	// Create and configure touch-screen camera controller
	_cameraController = [[Isgl3dDemoCameraController alloc] initWithCamera:_camera andView:self];
	_cameraController.orbit = 17;
	_cameraController.theta = 30;
	_cameraController.phi = 10;
	_cameraController.doubleTapEnabled = NO;
	
	// Add camera controller to touch-screen manager
	[[Isgl3dTouchScreen sharedInstance] addResponder:_cameraController];
	
	self.isLandscape = YES;	
}

- (void) initScene {
	[super initScene];
	
	Isgl3dTextureMaterial * textureMaterial = [[Isgl3dTextureMaterial alloc] initWithTextureFile:@"billboard.png" shininess:0 precision:TEXTURE_MATERIAL_MEDIUM_PRECISION repeatX:NO repeatY:NO];
	Isgl3dBillboard * billboard = [[Isgl3dBillboard alloc] init];
	billboard.size = 64;
	[billboard setAttenuation:0 linear:0 quadratic:0.01];
	
	for (int k = 0; k < 3; k++) {
		for (int j = 0; j < 3; j++) {
			for (int i = 0; i < 3; i++) {
				Isgl3dBillboardNode * node = [_scene createNodeWithBillboard:billboard andMaterial:textureMaterial];
                [node setTranslation:((i - 1.0) * 4) y:((j - 1.0) * 4) z:((k - 1.0) * 4)];
			}
		}		
	}		
	
	[billboard release];	
	[textureMaterial release];	
}

- (void) updateScene {
	[super updateScene];
	
	// update camera
	[_cameraController update];
}


@end



#pragma mark AppController

/*
 * Implement principal class: simply override the viewWithFrame method to return the desired demo view.
 */
@implementation AppController

- (Isgl3dView3D *) viewWithFrame:(CGRect)frame {
	return [[[BillboardTestView alloc] initWithFrame:frame] autorelease];
}

@end