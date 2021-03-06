set terminal svg enhanced size 1000 800 fname "Times New Roman" fsize 26 solid
set encoding iso_8859_1

set border 4095 front linetype -1 linewidth 1.000
set ticslevel 0

set ylabel "MAC efficiency"  offset 0
set yrange [0:*]
set format y '%0.2f'


set xlabel "Maximum CW size / slots"
set xrange [0:200]

set grid xtics ytics back lw 1 lc rgb "#AFAFAF"
set key below


set output 'csma_performance_n2.svg'
plot "data.txt" using 3:(($2==2&&$1==0)?$10:1/0) with linespoints ls 1 lw 2 lt rgb "#1E90FF" pt 7 ps 0.3 title "CSMA/CA, n=2, calculation",\
"data.txt" using 3:(($2==2&&$1==4)?$10:1/0) with linespoints ls 1 lw 2 lt rgb "#DB7093" pt 7 ps 0.3 title "CSMA/CD, n=2, calculation",\
"data.txt" using 3:(($2==2&&$1==0)?$8:1/0) with linespoints ls 1 lw 1 linecolor 2 pt 7 ps 0.6 title "CSMA/CA, n=2, simulation",\
"data.txt" using 3:(($2==2&&$1==4)?$8:1/0) with linespoints ls 1 lw 1 linecolor 7 pt 5 ps 0.6 title "CSMA/CD, n=2, simulation"

set output 'csma_performance_n4.svg'
plot "data.txt" using 3:(($2==4&&$1==0)?$10:1/0) with linespoints ls 1 lw 2 lt rgb "#1E90FF" pt 7 ps 0.3 title "CSMA/CA, n=4, calculation",\
"data.txt" using 3:(($2==4&&$1==4)?$10:1/0) with linespoints ls 1 lw 2 lt rgb "#DB7093" pt 7 ps 0.3 title "CSMA/CD, n=4, calculation",\
"data.txt" using 3:(($2==4&&$1==0)?$8:1/0) with linespoints ls 1 lw 1 linecolor 2 pt 7 ps 0.6 title "CSMA/CA, n=4, simulation",\
"data.txt" using 3:(($2==4&&$1==4)?$8:1/0) with linespoints ls 1 lw 1 linecolor 7 pt 5 ps 0.6 title "CSMA/CD, n=4, simulation"

set output 'csma_performance_n6.svg'
plot "data.txt" using 3:(($2==6&&$1==0)?$10:1/0) with linespoints ls 1 lw 2 lt rgb "#1E90FF" pt 7 ps 0.3 title "CSMA/CA, n=6, calculation",\
"data.txt" using 3:(($2==6&&$1==4)?$10:1/0) with linespoints ls 1 lw 2 lt rgb "#DB7093" pt 7 ps 0.3 title "CSMA/CD, n=6, calculation",\
"data.txt" using 3:(($2==6&&$1==0)?$8:1/0) with linespoints ls 1 lw 1 linecolor 2 pt 7 ps 0.6 title "CSMA/CA, n=6, simulation",\
"data.txt" using 3:(($2==6&&$1==4)?$8:1/0) with linespoints ls 1 lw 1 linecolor 7 pt 5 ps 0.6 title "CSMA/CD, n=6, simulation"

