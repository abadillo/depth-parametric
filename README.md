# Interactive Depth Parametric Graphs

![Example](https://github.com/abadillo/depth-parametric/blob/main/examples/2021326_185256[4].png)


This is an interactive parametric graph tool/playground where you can play with the variables to get really interesting results.

This sketch was made using Processing 3, and can be run by downloading the file [depthparametric.pde](https://github.com/abadillo/depth-parametric/blob/main/depthparametric.pde "depthparametric.pde").


## Examples

![Montage](https://github.com/abadillo/depth-parametric/blob/main/examples/montage.png)

*None of the examples where digitaly altered, apart from cropping them to make this montage.*


## Usage & Keybinds

Variable Name     | Function                  | Key
-------------     | --------------            | -------------
frq               | frequency multiplier      | mouseX
r                 | initial main radius       | mouseY
amp               | amplitud multiplier       | q-e
xmax              | horizontal width divider  | a-d
N                 | number of lines           | w-s
yoffset           | vertical offset           | up/down arrow
xoffset           | horizontal offset         | right/left arrow
xfade             | horizontal fade flag      | x
yfade             | vertical fade flag        | y 
finfo             | information panel flag    | i 
saveScaleF        | save img scale multiplier |
|                  | save image                | p
ft(1-2-3)         | add/rem function          | 1-2-3


__When saving an image, the program will freeze for 5 seconds or so, depending on your computer and the `saveScaleF`actor currently set to x4. Also, the info panel on the top right will NOT appear on the saved image, so it is not necessary to turn it off.__

Most of the examples where made using the Sine parametric equation, but there's also the option to turn on and off Cosine and Circle equations, as well as other options in the code.


## Explanation

The radius and vertical transparency of each subsequent line is defined by `nr = 5*r/(abs(n)+5.0)` and `yalpha = 100/(abs(n)+0.4)`, both dependent only on the line number.

Horizontal transparency is calculated with the dist function on `xalpha = map( dist(abs(t), 0, width/scale, 0), 0, width/scale, 0, 1)`, and multiplies the yalpha.

Sine parametric equation is defined by `x = t;   y = amp*sin(t/frq)`.

Xmax is the width divider with limits the amount of circles for each frame according to `width/xmax` and to `t+=frq/10`; meaning, high frequency results in less circles and low frequency results in the opposite.



Inspiered by:
https://www.youtube.com/watch?v=2MmXXrfV5l0
