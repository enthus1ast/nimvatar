import jester, nimja, os, nimvatar, strformat, strutils, base64, random

proc clean(str: string): string =
  # return str.replace("..", "").replace("/", "").replace("\\","")
  return encode(str)
  # return e

proc getRandomImagesV1(max = 100): seq[string] =
  result = @[]
  var imgs: seq[string] = @[]
  var paths =  "public" / "v1"
  for path in walkFiles(paths / "*.png"):
    imgs.add(path)
  shuffle(imgs)
  return imgs[0 ..< min(imgs.len, max)]

proc cleaned(str: string): string =
  return str.replace("public", "").replace("\\", "/")

routes:
  get "/":
    resp tmplf(getScriptDir() / "index.nimja")

  get "/v1":
    if request.params.hasKey("in"):
      let cont = request.params["in"]
      let path = getAppDir() / "public" / "v1" /  cont.clean() & ".png"
      if not fileExists(path):
        echo "render: ", path
        renderImg(cont, path)
      redirect(tmpls "/v1/{{cont.clean()}}.png")
    else:
      resp "ok"