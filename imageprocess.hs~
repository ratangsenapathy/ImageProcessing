import System.Environment
import Codec.Picture

type OutputImage = Image PixelRGB8
type InputImage = Image PixelRGB8
type Constant = Float
type LogBase = Float

negatePixel :: PixelRGB8 -> PixelRGB8
negatePixel (PixelRGB8 r g b) = PixelRGB8 (255-r) (255-g) (255-b)

negateImage :: InputImage -> OutputImage
negateImage x = pixelMap negatePixel x

logTransformImage :: (Floating a, RealFrac a) => Image PixelRGB8 -> Constant -> LogBase -> Image PixelRGB8
logTransformImage x c b = pixelMap (\(PixelRGB8 r g b) -> PixelRGB8 (lg (fromIntegral r)) (lg (fromIntegral g)) (lg (fromIntegral b))) x
                          where lg y =  floor (c * (logBase b (1+y))) :: Pixel8

gammaTransformImage x c g =  pixelMap (\(PixelRGB8 r g b) -> PixelRGB8 (gamma (fromIntegral r)) (gamma (fromIntegral g)) (gamma (fromIntegral b))) x
                             where gamma p =  floor (c * (p**g)) :: Pixel8
                                
extractImage :: Either String DynamicImage -> Image PixelRGB8
extractImage (Left errorMessage) = error errorMessage
extractImage (Right dynamicImage) = convertRGB8 dynamicImage

main :: IO()
main = do
  args <-getArgs
  dynamicInput <- readImage (args!!0)
  let inputImage = extractImage(dynamicInput)
  let resultImage = gammaTransformImage inputImage 1 2
  savePngImage (args!!1) (ImageRGB8 resultImage)
              
