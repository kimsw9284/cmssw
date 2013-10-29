# Produce summary plots from the tables generated with writeSummaryTable.r.
#
# Requires gnuplot 4.6. The font path can be set with the environment variable GDFONTPATH.
# 

reset
set macro

#Set the input file here
myfile =  '"<sort -gs -k 2 True_RelValZMM5312_BP7X_noDRR_summary.txt"'


#Set this to 1 to print plots to png files
print=0

# Output to png viewer
set terminal png enhanced font "Arial,14" size 800,600
set output '| display png:-'


######################################################################
set pointsize 1
set grid

set key reverse Left font ",14" opaque

theta=0
phi=1

set arrow 2 from 180-18,graph 0 to 180-18,graph 1 nohead  back lt 1 lc -1 lw 1
set arrow 3 from 360-18,graph 0 to 360-18,graph 1 nohead  back lt 1 lc -1 lw 1
set arrow 4 from 540-18,graph 0 to 540-18,graph 1 nohead  back lt 1 lc -1 lw 1

#set arrow 2 from 180,graph 0 to 180,graph 1 nohead  back lt 22 lw 1
#set arrow 3 from 360,graph 0 to 360,graph 1 nohead  back lt 22 lw 1
#set arrow 4 from 540,graph 0 to 540,graph 0.85 nohead  back lt 22 lw 1

set xtics ("W-2 MB1" 0, "W-1" 36, "W0" 72, "W1" 108, "W2" 144, \
           "W-2 MB2" 180, "W-1" 216, "W0" 252, "W1" 288, "W2" 324, \
           "W-2 MB3" 360, "W-1" 396, "W0" 432, "W1" 468, "W2" 504, \
           "W-2 MB4" 540, "W-1" 568, "W0" 596, "W1" 624, "W2" 652) ;\
#set xrange[0:]
set xrange[-18:668]
set xtics rotate by -45


set label 1 "MB1" at  72,graph 0.05 center
set label 2 "MB2" at 252,graph 0.05 center
set label 3 "MB3" at 432,graph 0.05 center
set label 4 "MB4" at 596,graph 0.05 center


######################################################################

sl=phi
#sl=theta

if (sl==theta) unset arrow 4



# Fields:
# 1:W 2:St 3:sec 4:SL 5:effS1RPhi 6:effS3RPhi 7:effSeg 8:resHit 9:pullHit 10:meanAngle  11:sigmaAngle 12:meanAngle_pull 13:sigmaAngle_pull 14:meanPos_pull 15:sigmaPos_pull



#### Hit Resolution
if (print) {set output "TrueHitReso.png"}
set yrange [100:900]
set ylabel "True Hit Resolution [{/Symbol m}m]" offset 0,graph 0.30
plot \
@myfile using (($3)==1&&int($4)==1?$8*10000:1/0) title '{/Symbol f} SLs' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$8*10000:1/0) title '{/Symbol q} SLs' w p pt 13 ps 1.5 lc 13


#horizontal line for pull and eff plots
set arrow 1 from -18,1 to 668,1 nohead back lt 0 lw 2 lc 0

#### Hit Pull
if (print) {set output "TrueHitPull.png"}
set yrange [0:2]
set ylabel "True Hit Pull" offset 0,graph 0.30
plot \
@myfile using (($3)==1&&int($4)==1?$9:1/0) title '{/Symbol f} SLs' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$9:1/0) title '{/Symbol q} SLs' w p pt 13 ps 1.5 lc 13


#### Hit Eff
if (print) {set output "TrueHitEff.png"}
set yrange [0.8:1.05]
set ylabel "True Hit Efficiency" offset 0,graph 0.30
plot \
@myfile using (($3)==1&&int($4)==1?$5:1/0) title '{/Symbol f} SLs, S1' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==1?$6:1/0) title '{/Symbol f} SLs, S3' w p pt  4 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$5:1/0) title '{/Symbol q} SLs, S1' w p pt 13 ps 1.5 lc 13, \
@myfile using (($3)==1&&int($4)==2?$6:1/0) title '{/Symbol q} SLs, S3' w p pt 12 ps 1.5 lc 13


### Segment eff
if (print) {set output "TrueSegmentEff.png"}
set yrange [0.8:1.05]
set ylabel "True Segment Efficiency" offset 0,graph 0.30
plot \
@myfile using (($3)==1&&int($4)==1?$7:1/0) title '4D segment' w p pt  5 ps 1.4 lc 4


### Segment angular resolution
unset arrow 1
if (print) {set output "TrueSegmentAngleReso.png"}
set yrange [0:20]
set ylabel "Segment Angle Resolution [mrad]" offset 0,graph 0.20
plot \
@myfile using (($3)==1&&int($4)==1?$11*1000.:1/0) title '{/Symbol f} SLs' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$11*1000.:1/0) title '{/Symbol q} SLs' w p pt 13 ps 1.5 lc 13


### Segment average angle bias
if (print) {set output "TrueSegmentAngleBias.png"}
set yrange [-3:3]
set ylabel "Segment Average Angle bias [mrad]" offset 0,graph 0.20
plot \
@myfile using (($3)==1&&int($4)==1?$10*1000.:1/0) title '{/Symbol f} SLs' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$10*1000.:1/0) title '{/Symbol q} SLs' w p pt 13 ps 1.5 lc 13

### Segment angular pull width
set arrow 1 from -18,1 to 668,1 nohead back lt 0 lw 2 lc 0
if (print) {set output "TrueSegmentAnglePull.png"}
set yrange [0:2]
set ylabel "Segment Angle Pull Width" offset 0,graph 0.20
plot \
@myfile using (($3)==1&&int($4)==1?$13:1/0) title '{/Symbol f} SLs' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$13:1/0) title '{/Symbol q} SLs' w p pt 13 ps 1.5 lc 13

### Segment position pull width
if (print) {set output "TrueSegmentPosPull.png"}
set yrange [0:2]
set ylabel "Segment Pull Width" offset 0,graph 0.20
plot \
@myfile using (($3)==1&&int($4)==1?$15:1/0) title '{/Symbol f} SLs' w p pt  5 ps 1.4 lc 4, \
@myfile using (($3)==1&&int($4)==2?$15:1/0) title '{/Symbol q} SLs' w p pt 13 ps 1.5 lc 13
