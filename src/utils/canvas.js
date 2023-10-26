import { saveAs } from "file-saver";
import html2canvas from "html2canvas";

const isWhite = (rgb) => {
  // many images contain noise, as the white is not a pure #fff white
  return rgb.red > 200 && rgb.green > 200 && rgb.blue > 200;
};

function Point(x, y) {
  this.x = x;
  this.y = y;
}

// https://stackoverflow.com/questions/69440668/crop-images-according-to-the-white-spaces-in-javascript
function removeBlankArea(canvas, options) {
  options = {
    offsetX: 20,
    offsetY: 20,
    ...options,
  };
  const context = canvas.getContext("2d"),
    imageData = context.getImageData(0, 0, canvas.width, canvas.height),
    data = imageData.data,
    getRBG = (x, y) => {
      var offset = canvas.width * y + x;
      return {
        red: data[offset * 4],
        green: data[offset * 4 + 1],
        blue: data[offset * 4 + 2],
        opacity: data[offset * 4 + 3],
      };
    },
    scanY = function (fromTop) {
      var offset = fromTop ? 1 : -1;
      // loop through each row
      for (
        var y = fromTop ? 0 : canvas.height - 1;
        fromTop ? y < canvas.height : y > -1;
        y += offset
      ) {
        // loop through each column
        for (var x = 0; x < canvas.width; x++) {
          var rgb = getRBG(x, y);
          if (!isWhite(rgb)) {
            if (fromTop) {
              return y;
            } else {
              return Math.min(y + 1, canvas.height);
            }
          }
        }
      }
      return null; // all image is white
    },
    scanX = function (fromLeft) {
      var offset = fromLeft ? 1 : -1;
      // loop through each column
      for (
        var x = fromLeft ? 0 : canvas.width - 1;
        fromLeft ? x < canvas.width : x > -1;
        x += offset
      ) {
        // loop through each row
        for (var y = 0; y < canvas.height; y++) {
          var rgb = getRBG(x, y);
          if (!isWhite(rgb)) {
            if (fromLeft) {
              return x;
            } else {
              return Math.min(x + 1, canvas.width);
            }
          }
        }
      }
      return null; // all image is white
    };

  const cropTop = scanY(true),
    cropBottom = scanY(false) + options.offsetY,
    cropLeft = scanX(true),
    cropRight = scanX(false) + options.offsetX,
    cropWidth = cropRight - cropLeft,
    cropHeight = cropBottom - cropTop;

  context.globalCompositeOperation = "destination-over";
  context.fillStyle = "#FFFFFF";
  context.fillRect(0, 0, cropWidth, cropHeight);
  var tempCanvas = document.createElement("canvas"),
    tCtx = tempCanvas.getContext("2d");
  tempCanvas.width = cropWidth;
  tempCanvas.height = cropHeight;
  tCtx.drawImage(canvas, cropTop, cropLeft);
  return tempCanvas;
}

export const shot = async (targetDom, defaultSaveName) => {
  const saveName = prompt("请输入截图文件名称", defaultSaveName);
  if (!saveName?.trim()) return;
  let canvas = await html2canvas(targetDom);
  canvas = removeBlankArea(canvas);
  canvas.toBlob((blob) => saveAs(blob, saveName));
};
