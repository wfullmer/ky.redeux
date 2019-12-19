#gnuplot script for making time plots from voutput
set term post enh color eps size 3,3
set output "stats_v.eps"
set size ratio 1
set notitle
##set title  "{/Italic Re}_0 = 3,  {/Symbol-Oblique f} = 0.15"
set xlabel "{/Italic c - c_c}"
set ylabel "averaged statistics: {/Italic v}"
set style line 1  lc rgb "black" lt 1 lw 3 pt 7 ps 3
set style line 21 lc rgb "black" lt 1 lw 1 pt 7 ps 0
set style line 2  lc rgb "red"   lt 1 lw 3 pt 7 ps 1
set style line 22 lc rgb "red"   lt 1 lw 1 pt 7 ps 0
set style line 3  lc rgb "blue"  lt 1 lw 3 pt 7 ps 1
set style line 23 lc rgb "blue"  lt 1 lw 1 pt 7 ps 0
set style line 4  lc rgb "blue"  lt 2 lw 3 pt 7 ps 1
set style fill transparent solid 0.25 noborder
set key bottom left
set xrange [0.:2.]
set xtics  0.2    #offset 0,-1 #auto
set yrange [-1.4:0.6]
set ytics  0.2
set autoscale y
##set yrange [0.000001:10]
##set ytics  0.10 #offset 0,-1 #auto
plot \
     "stats_v.dat" using 1:2:3 title "{/Italic V}"   with yerrorbars ls 21, \
     "stats_v.dat" using 1:4:5 title "{/Italic v'}"  with yerrorbars ls 22
#     "stats_v.dat" using 1:6:7 title "{/Italic E_v}" with yerrorbars ls 23
##     "exp.dat" using ($1/154):2:3 notitle with yerrorbars ls 21, \
##     "mfix.19.2.dat" using ($1/154):2 title "(DPVM) MFiX R19.2" with linespoints ls 3, \
##     "mfix.19.2_garg.dat" using ($1/154):2 title "(GARG) MFiX R19.2"  with linespoints ls 4, \
##     "exa.19.08.dat" using ($1/154):2  title "MFiX-Exa 19.08" with linespoints ls 2, \
##     "exa.19.08.dat" using ($1/154):2:3 notitle with yerrorbars ls 22


