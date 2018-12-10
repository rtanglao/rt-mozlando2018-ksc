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
```
