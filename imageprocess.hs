import System.Environment
import Codec.Picture


type OutputImage = Image PixelRGB8
type InputImage = Image PixelRGB8
type Constant = Float
type GammaValue = Float


negatePixel :: PixelRGB8 -> PixelRGB8
negatePixel (PixelRGB8 r g b) = PixelRGB8 (255-r) (255-g) (255-b)


--function takes a pixel and a constant to use in the formula c*log(1+pixelvalue) where log base is 256
logTransformPixel :: (Floating constant, RealFrac constant) => constant -> PixelRGB8 -> PixelRGB8
logTransformPixel const (PixelRGB8 r g b) = PixelRGB8 (log256 r) (log256 g) (log256 b)
                                            where log256 x = floor (const * logBase 256 (1 + fromIntegral x)) :: Pixel8


gammaTransformPixel :: (Floating a, RealFrac a) => a -> a -> PixelRGB8 -> PixelRGB8
gammaTransformPixel const gammaValue (PixelRGB8 r g b) = PixelRGB8 (gammaTransform r) (gammaTransform g) (gammaTransform b)
                                                         where gammaTransform x = floor (const * ((fromIntegral x/256) ** gammaValue) * 256) ::Pixel8


applyTransform = pixelMap


negateImage :: InputImage -> OutputImage
negateImage = applyTransform negatePixel


logTransformImage :: Constant -> InputImage -> OutputImage
logTransformImage const = applyTransform (logTransformPixel const) 
                         

gammaTransformImage :: Constant -> GammaValue -> InputImage -> OutputImage
gammaTransformImage const gammaValue = applyTransform (gammaTransformPixel const gammaValue)

                                          
extractImage :: Either String DynamicImage -> Image PixelRGB8
extractImage (Left errorMessage) = error errorMessage
extractImage (Right dynamicImage) = convertRGB8 dynamicImage


main :: IO()
main = do
  args <-getArgs
  dynamicInput <- readImage (args!!0)
  let inputImage = extractImage(dynamicInput)
  let resultImage = gammaTransformImage inputImage 1 0.5
  savePngImage (args!!1) (ImageRGB8 resultImage)
              
