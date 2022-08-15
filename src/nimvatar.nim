import std/sha1
import random
import pixie
import std/enumerate
import os

# echo $secureHash("enthus1ast")

proc strToNum(str: string): int64 =
  for ch in str:
    result += ch.int
  # result = (result mod int64.high).int64


proc seed(str: string) =
  ## seeds random number generator with a string
  randomize(strToNum(str).int)

let fontPath = getAppDir() / "Roboto-Regular_1.ttf"

var font = readFont(getAppDir() / "Roboto-Regular_1.ttf")
font.size = 16

type
  GridPicPixel = object
    color: ColorRGBA
  GridPic = array[16, array[16, GridPicPixel]]

proc genRandColor(str: string): ColorRGBA =
  seed(str)
  return ColorRGBA(r:rand(255).uint8, g: rand(255).uint8, b: rand(255).uint8, a: rand(255).uint8)

proc genGridPic(str: string): GridPic =
  seed(str)
  var colors: seq[ColorRGBA] = @[genRandColor(str), ColorRGBA(r:0, g: 0, b: 0, a: 255)]
  for yy in 0..15:
    for xx in 0..15:
      result[yy][xx] = GridPicPixel(color: sample(colors))
      # result[yy][xx] = GridPicPixel(color: ColorRGBA(r:rand(255).uint8, g: rand(255).uint8, b: rand(255).uint8, a: 255))


proc renderImg(nick: string, path: string) =
  let gp = genGridPic(nick)
  const width = 256
  const height = 256
  const sw = 256 / 16
  var image = newImage(width, height)
  image.fill(rgba(255, 255, 255, 255))
  let ctx = newContext(image)
  ctx.font = fontPath
  for idy, ya in enumerate(gp):
    for idx, pix in enumerate(ya):
      ctx.fillStyle = pix.color
      ctx.strokeStyle = pix.color
      let
        pos = vec2(idx.float * sw, idy.float * sw)
        wh = vec2(sw, sw)

      case rand(10)
      of 0,1,2:
        ctx.fillRect(rect(pos, wh))
      of 3,4:
        ctx.strokeRect(rect(pos, wh))
      of 5:
        ctx.fillCircle(Circle(pos: pos, radius: sw))
      of 6:
        ctx.strokeCircle(Circle(pos: pos, radius: sw))
      of 7:
        ctx.fontSize = rand(127.0)
        let text = $nick[0]
        ctx.fillText(
          text,
          pos
        )
        # translate(vec2((256 / 2), (256 / 2) - font.defaultLineHeight)))
        # ctx.fillText(
        #   font,
        #   text,
        # translate(vec2((256 / 2), (256 / 2) - font.defaultLineHeight)))
      else:
        ctx.fillRect(rect(pos, wh))

  var maxRot = rand(8)
  for idx in 1 .. maxRot:
    image.draw(image, translate(vec2(256 / 2, 256 / 2 )) * rotate(toRadians( (360 / maxRot).int * idx)), NormalBlend)

  ## Font loading does not work
  # let text = $nick[0]
  # image.fillText(font.typeset(text, bounds = vec2(0, 0)), vec2(10, 10))
  # ctx.fillStyle = ColorRGBA(r: 0, g: 0, b: 0, a: 255)
  # ctx.textStyle = ColorRGBA(r: 127, g: 127, b: 127, a: 127)
  # image.fillText(
  #   font,
  #   text,
  #   translate(vec2((256 / 2), (256 / 2) - font.defaultLineHeight)))

  image.writeFile(path)

renderImg("enthus1ast", getAppDir() / "nimvatar1__enthus1ast.png")
renderImg("sn0re", getAppDir() / "nimvatar2__sn0re.png")
renderImg("dom96", getAppDir() / "nimvatar3__dom96.png")
renderImg("Araq", getAppDir() / "nimvatar4__Araq.png")