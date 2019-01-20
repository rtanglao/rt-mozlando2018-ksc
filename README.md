# rt-mozlando2018-ksc
Mozlando 2018 kennedy space center tshirts and other stuff :-)

## 20January2019 creating a Zazzle / Art of Where tights 3325px x 6358px for one leg

* 3325 / 5 px = 665 rows one way i.e. "horizontally"
* 6358 -> 6370 / 5 px = 1274 rows the other way "vertically"
* each original is 4608 x 3456 px
* round down to 4605 x 3455 px
  * which means there are 921 5x columns horizontally
  * and 691 rows vertically
* use the imagemagick ```crop``` commmand with the ```+repage``` option 
see: http://www.imagemagick.org/Usage/crop/#crop_repage
e.g.
```bash
  convert rose: -crop 40x30+40+30  +repage  repage_br.gif
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

