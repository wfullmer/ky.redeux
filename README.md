# ky.redeux
code, scripts and text on the Kreiss-Ystrom equations (2002) (slightly modified)  (Nonlinear Example 2). code built for matlab or octave. 

# directories

## tests 
contains baseline program for test runs. primarily run interactively. for no terminal run, e.g., 

    octave main.m > scn.txt &

## sweep
contains scripts and code to run the code many times with a range of `c` values. `C` is set in the bash script CAREFUL.sh and is related to the modified KY parameter as `c = C/100 + 0.15`. 
notes: in our study, we ranged `c` from 0.16 to 2.16 by 0.01, i.e., 201 `C` values. these simulations were performed on Prof. Lopez de Bertodano's curie cluster at Purdue University. 20 runs were submitted per node at a time, repeating this main sweep a total of 10 times, each time increasing the value of `c` and `cstp` in CAREFUL.sh by 20. make sure this script points to bash on your machine. the script was launched by

    nohup sh CAREFUL.sh & 

octave version 3.0.3 was used to execute the main.m code. after all simulations were complete, the c# directories (# = 1 to 201) were moved from sweep# directories up to this level zero directory for 



# ref: 
Eaton, J.W., Bateman, D., Hauberg, S. and Wehbring, R. (2019). GNU Octave version 5.1.0 manual: a high-level interactive language for numerical computations. [https://www.gnu.org/software/octave/doc/v5.1.0/](https://www.gnu.org/software/octave/doc/v5.1.0/)

Kreiss, H.O. and Yström, J., 2002. Parabolic problems which are ill-posed in the zero dissipation limit. Mathematical and Computer Modelling, 35(11-12), pp.1271-1295. [https://doi.org/10.1016/S0895-7177(02)00085-7](https://doi.org/10.1016/S0895-7177(02)00085-7)



