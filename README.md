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
ls -d1 $PWD/* | head -120 >1st-120files.tct
```
