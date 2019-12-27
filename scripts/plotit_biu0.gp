#gnuplot script for making time plots from voutput
set term post enh color eps size 3,3
set output "bi.eps"
set size ratio 1
set notitle
##set title  "{/Italic Re}_0 = 3,  {/Symbol-Oblique f} = 0.15"
set xlabel "{/Italic c - c_c}"
set ylabel "{/Italic v}|{_{/Italic u} = 0"
set style line 1  lc rgb "black" lt 1 lw 3 pt 7 ps 3
set style line 21 lc rgb "black" lt 1 lw 1 pt 7 ps 0
set style line 31 lc rgb "black" lt 0 lw 0 pt 7 ps 0 
set style line 2  lc rgb "red"   lt 1 lw 3 pt 7 ps 1
set style line 22 lc rgb "red"   lt 1 lw 1 pt 7 ps 0
set style line 3  lc rgb "blue"  lt 1 lw 3 pt 7 ps 1
set style line 23 lc rgb "blue"  lt 1 lw 1 pt 7 ps 0
set style line 4  lc rgb "blue"  lt 2 lw 3 pt 7 ps 1
set style fill transparent solid 0.25 noborder
set key top right 
set xrange [0.:2.]
set xtics  0.2    #offset 0,-1 #auto
#set yrange [-0.4:1.4]
#set ytics  0.2
set autoscale y
##set yrange [0.000001:10]
##set ytics  0.10 #offset 0,-1 #auto
plot "biu0.dat" using 1:2 notitle with points ls 31


