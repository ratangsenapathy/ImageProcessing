# ImageProcessing
A haskell image processing toolkit
<b>Note: The functions work on true color images(24 bit RGB value)</b>
###Types
	InputImage <=> OutputImage <=> Image PixelRGB8
	Constant <=> LogBase <=> GammaConstant <=> Float
###Functions
####1). negateImage
	Prototype: negateImage :: InputImage -> OutputImage
	Description: This function takes an input image and negates every pixel that is (255 - rgb component) for each pixel and returns the resultant image
####2). logTransformImage
	Prototype: logTransformImage :: (Floating a, RealFrac a) => InputImage -> Constant -> LogBase -> OutputImage
	Description: This functions takes an input image and applies the formula c*log(I+1) to the base b where I is each rgb component intensity,c is a constant and b is the log base to each pixel in the image

####3). gammaTransformImage
	Prototype: gammaTransformImage :: (Floating a, RealFrac a) => InputImage -> Constant -> GammaConstant -> OutputImage
	Description: This functions takes an input image and applies the formula c*((I)^g) to the base b where I is each rgb component intensity, c is a constant and b is the log base to each pixel in the image