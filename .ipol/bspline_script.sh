#!/bin/bash

if [ "$#" -lt "4" ]; then
    echo "usage:\n\t$0 order boundary eps larger hx1 hy1 hx2 hy2 hx3 hy3 hx4 hy4"
    exit 1
fi

order=$1
boundary=$2
eps=$3
larger=$4
hx1=$5
hy1=$6
hx2=$7
hy2=$8
hx3=$9
hy3=${10}
hx4=${11}
hy4=${12}

im=input_0.png
out=output.png
out0=output_0.png
out1=output_1.png

w=`identify -format %w $im`
h=`identify -format %h $im`
w=$(($w-1))
h=$(($h-1))
hx2=$(($w+$hx2))
hy3=$(($h+$hy3))
hx4=$(($w+$hx4))
hy4=$(($h+$hy4))

homo=`hom4p 0 0 $hx1 $hy1 $w 0 $hx2 $hy2 0 $h $hx3 $hy3 $w $h $hx4 $hy4`
echo "The homography parameters are: $homo"
echo ""
bspline "$homo" $im $out $order $boundary $eps $larger > /dev/null
bspline "$homo" $im $out0 0 $boundary $eps $larger > /dev/null
bspline "$homo" $im $out1 1 $boundary $eps $larger > /dev/null
echo "For order $order we have:"
compute_bspline $order $eps
