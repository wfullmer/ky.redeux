#gnuplot script for making time plots from voutput
set term post enh color eps size 3,3
set output "lle.eps"
set size ratio 1
set notitle
##set title  "{/Italic Re}_0 = 3,  {/Symbol-Oblique f} = 0.15"
set xlabel "{/Italic c - c_c}"
set ylabel "{/Symbol-Oblique l}_1 "
set style line 1  lc rgb "black" lt 1 lw 3 pt 7 ps 3
set style line 21 lc rgb "black" lt 1 lw 1 pt 7 ps 0
set style line 2  lc rgb "red"   lt 1 lw 3 pt 7 ps 1
set style line 22 lc rgb "red"   lt 1 lw 1 pt 7 ps 0
set style line 3  lc rgb "blue"  lt 1 lw 3 pt 7 ps 1
set style line 23 lc rgb "blue"  lt 1 lw 1 pt 7 ps 0
set style line 4  lc rgb "blue"  lt 2 lw 3 pt 7 ps 1
set style fill transparent solid 0.25 noborder
set key top right 
set xrange [0.:2.]
set xtics  0.2    #offset 0,-1 #auto
set yrange [-0.1:0.9]
set ytics  0.1
#set autoscale y
##set yrange [0.000001:10]
##set ytics  0.10 #offset 0,-1 #auto
plot \
     "lle.dat" using 1:2:3 notitle with yerrorbars ls 21, \
     "lle_fit.dat" using 1:2 title "fit" with lines ls 22, \
     "lle_2014.dat" using 1:2 notitle with lines ls 23
##     "stats_u.dat" using 1:6:7 title "{/Italic E_u}" with yerrorbars ls 23



