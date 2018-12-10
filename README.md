# rt-mozlando2018-ksc
Mozlando 2018 kennedy space center tshirts and other stuff :-)
## 09December2018 creating a rectangular graphic

* 1\. resize

```bash
cd /home/rtanglao/GIT/rt-mozlando2018-ksc/FIFTYPERCENT
convert '../ORIGINALS/*.jpg' -resize 50% -set filename:area '%wx%h' 'ksc-%03d-size-%[filename:area].png'
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

