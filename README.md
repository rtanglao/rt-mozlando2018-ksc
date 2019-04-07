# rt-mozlando2018-ksc
Mozlando 2018 kennedy space center tshirts and other stuff :-)

## 06April2019 save to 6400

```r
setwd("~/GIT/rt-mozlando2018-ksc")
source("hatching.R")
img <- readJPEG("/home/roland/GIT/rt-mozlando2018-ksc/TRY2-200x200OILY/2019-01-31-05-36-oily-200x200-out.jpg")
hatching(img, size=0.1, var=0.5, N=10000, pch=0, step=0.01)
```

## 31March2019 try hatching from Jean Fan's code

```bash
convert 2019-01-31-05-36-oily-200x200-out.png 2019-01-31-05-36-oily-200x200-out.jpg
```

```r
setwd("~/GIT/rt-mozlando2018-ksc")
source('hatching.R')
img <- readJPEG("/home/roland/GIT/rt-mozlando2018-ksc/TRY2-200x200OILY/2019-01-31-05-36-oily-200x200-out.jpg")
hatching(img, size=0.1, var=0.5, N=10000, pch=0, step=0.01)
# export as 3600 px wide to
# https://github.com/rtanglao/rt-mozlando2018-ksc/blob/master/hatched-2019-01-31-05-36-oily-200x200-out.png
img2 <- readJPEG("/home/roland/GIT/rt-mozlando2018-ksc/TRY2-200x200OILY/2019-01-31-05-36-oily-200x200-out.jpg")[,,1]
img2 <- t(apply(img2,2,rev))
hatching(img2)
# export as 3600 px wide to
# https://github.com/rtanglao/rt-mozlando2018-ksc/blob/master/hatched2-2019-01-31-05-36-oily-200x200-out.png
```

## 26January2019 first working 100px x 100px version

* run this
```bash
 cat ../originals.txt | ../oily-100x100px-zazzle-leg.rb 2> 26jan2019-oily100x100-stderr.txt &
 ```
 and you get this (the filename is 'interim' but it's actually the final result; the program should have terminated immediately after creating this file but it died because [if i >= num_pixels](https://github.com/rtanglao/rt-mozlando2018-ksc/blob/master/oily-100x100px-zazzle-leg.rb#L42) was erroneously ```if i > num_pixels```:
 
 <a data-flickr-embed="true"  href="https://www.flickr.com/photos/roland/46164708574/in/datetaken-ff/" title="interim-100x100-oily-out-row-6300"><img src="https://farm5.staticflickr.com/4881/46164708574_8dc40d9b39.jpg" width="266" height="500" alt="interim-100x100-oily-out-row-6300"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>

## 20January2019 first working version 

```bash

mkdir 5x5-LEG1
cd !$
cat ../originals.txt | ../create5x5-zazzle-leg.rb
```
## 20January2019 create file with ls with full pathnames

```bash
ls -d1 $PWD/ORIGINALS/*.jpg > originals.txt
```

## 20January2019 creating a Zazzle / Art of Where tights 3325px x 6358px for one leg

* 3325 / 5 px = 665 rows one way i.e. "horizontally"
* 6358 -> 6370 / 5 px = 1274 rows the other way "vertically"
* each original is 4608 x 3456 px
* round down to 4605 x 3455 px
  * which means there are 921 five pixel columns horizontally
  * and 691 five pixel rows vertically
* which means the script needs to pick 847210 (665 * 1274) random 5px x 5x patches
* use the imagemagick ```crop``` commmand with the ```+repage``` option 
see: http://www.imagemagick.org/Usage/crop/#crop_repage
e.g.

```bash
  convert rose: -crop 40x30+40+30  +repage  repage_br.gif
  ```
  
  * in our case something like:
```bash
  convert <ksc_img> -crop 5x5+<random_x>+<random_y>  +repage  5x5-ksc.png
  ```

## 09December2018 creating a rectangular graphic

* 1\. resize

```bash
cd /home/rtanglao/GIT/rt-mozlando2018-ksc/FIFTYPERCENT
convert '../ORIGINALS/*.jpg' -resize 50% -set filename:area '%wx%h' 'ksc-%03d-size-%[filename:area].png' #originals come from flickr set and i deleted the vertical ones !
```

* 2\. get 120 files

```bash
ls -d1 $PWD/* | head -120 >1st-120files.txt
```

* 3\. make montage in 2100x1800 approx 1.2 to 1
```bash
montage -verbose -adjoin -tile 12x10 +frame +shadow +label -adjoin -geometry '2304x1728+0+0<' @FIFTYPERCENT/1st-120files.txt mozlando-ksc-12x10.png
% ls -lh mozlando-ksc-12x10.png
-rw-rw-rw- 1 rtanglao rtanglao 578M Dec  9 22:54 mozlando-ksc-12x10.png
```

* 4\. the above makes a huge 578M image so try 25%

```bash
cd /home/rtanglao/GIT/rt-mozlando2018-ksc/TWENTYFIVEPERCENT
convert '../ORIGINALS/*.jpg' -resize 25% -set filename:area '%wx%h' 'ksc-%03d-size-%[filename:area].png'
ls -d1 $PWD/* | head -120 >1st-120files.txt
cd ..
montage -verbose -adjoin -tile 12x10 +frame +shadow +label -adjoin -geometry '1152x864+0+0<' @TWENTYFIVEPERCENT/1st-120files.txt 25percent-mozlando-ksc-12x10.png
```

* 5\. still over 100MB, let's try 19%

```bash
cd /home/rtanglao/GIT/rt-mozlando2018-ksc/TENPERCENT
convert '../ORIGINALS/*.jpg' -resize 10% -set filename:area '%wx%h' 'ksc-%03d-size-%[filename:area].png'
ls -d1 $PWD/* | head -120 >1st-120files.txt
cd ..
montage -verbose -adjoin -tile 12x10 +frame +shadow +label -adjoin -geometry '461x346+0+0<' @TENPERCENT/1st-120files.txt ten-percent-mozlando-ksc-12x10.png
```

* 6\. 12x10 seems to be wrong, let's try 10x12

```bash
montage -verbose -adjoin -tile 10x12 +frame +shadow +label -adjoin -geometry '461x346+0+0<' @TENPERCENT/1st-120files.txt ten-percent-mozlando-ksc-10x12.png
```

