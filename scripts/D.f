C Calculates the correlation dimension of an attractor composed by
C several time series
C Clausse, Purdue 2013

        DIMENSION X(16,800000)       ! Time series I=state-variable index, J=time

        OPEN(1,FILE='CDv.dat',STATUS='OLD')
        OPEN(2,FILE='DEv.DAT',STATUS='UNKNOWN')

        N0=1                    ! End of initial transient  
        NT=10001                ! Total number of time steps
c       READ(1,*)NS             ! Read the number of series (embedded dimension)
        NS=8 
       
        DO J=1,NT 
        READ(1,*)(X(I,J),I=1,NS)
        END DO

    1 continue

        DO RLOG=-2.,1.,0.01               ! Range of LOG10(R)
        R=10.**RLOG
        
        NP=0                        ! Set the #point counter = 0
        DO J0=N0,NT,(NT-N0)/30          ! Centers of the balls  (div by #balls)
        DO J=N0,NT,1                ! all the times considered           
c       DO J=N0,NT,(NT-N0)/#          ! Not all the times are considered (div by # of points considered)          
        D=0                         ! Set distance = 0
        DO I=1,NS       
        D=D+(X(I,J)-X(I,J0))**2     ! Distance from the center
        END DO                      ! End center point loop
        IF(D.LT.R**2)NP=NP+1          ! The point is inside, count it
        END DO                      ! End distance loop

        END DO                                             ! End time loop
        WRITE(2,*)LOG10(R),LOG10(FLOAT(NP))    ! Output
        END DO                             ! End R loop         

        STOP
        END



