#V3.30.21.00;_safe;_compile_date:_Feb 10 2023;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#C file created using the SS_writectl function in the R package r4ss
#C file write time: 2023-02-23 16:53:24
#_data_and_control_files: data.ss // control_modified.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
 1 2 #_blocks_per_pattern 
# begin and end years of blocks
 2000 2022
 2000 2010 2011 2022
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
2 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
2 #_First_Mature_Age
2 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.02 0.2 0.0557031 -2.74 0.31 3 1 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 2 15 8.35151 4 50 0 3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 50 70 61.6371 60 50 0 3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.02 0.21 0.123988 0.14 50 0 3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.02 0.21 0.0998744 0.15 50 0 4 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.01 0.21 0.0274197 0.028 50 0 4 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 0.1 1.19e-05 1.19e-05 50 6 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 2 4 3.09 3.09 50 6 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 9 12 10.87 10.87 0.055 6 -50 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -3 3 -0.688 -0.688 50 6 -50 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 1e-10 0.1 7.218e-08 -16.4441 0.135 3 -50 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 2 6 4.043 4.043 0.3 6 -50 0 0 0 0 0 0 0 # Eggs_exp_len_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 0.02 0.2 0.0643 -2.74 0.31 6 -50 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 0 15 0 0 50 6 -50 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 50 70 52.3075 60 50 0 3 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.02 0.21 0.171007 0.14 50 0 3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 0.02 0.21 0.0867433 0.15 50 0 4 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 0.01 0.21 0.0434444 0.028 50 0 4 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 0 0.1 1.08e-05 1.08e-05 50 6 -50 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 2 4 3.118 3.118 50 6 -50 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 -1 1 1 1 50 6 -50 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
1  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
 7 11 9.2 8.5 50 0 -1 0 0 0 0 0 0 0 # SR_LN(R0)
          0.21          0.99          0.72          0.72          0.16             2         -6          0          0          0          0          0          0          0 # SR_BH_steep
             0             2           0.5           0.4            50             6        -50          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0            50             6        -50          0          0          0          0          0          0          0 # SR_regime
             0             2             0             1            50             6        -50          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1960 # first year of main recr_devs; early devs can preceed this era
2022 # last year of main recr_devs; forecast devs start in following year
5 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1892 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 5 #_recdev_early_phase
 6 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1965.76 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1978 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2020 #_last_yr_fullbias_adj_in_MPD
 2022 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.8025 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1892E 1893E 1894E 1895E 1896E 1897E 1898E 1899E 1900E 1901E 1902E 1903E 1904E 1905E 1906E 1907E 1908E 1909E 1910E 1911E 1912E 1913E 1914E 1915E 1916E 1917E 1918E 1919E 1920E 1921E 1922E 1923E 1924E 1925E 1926E 1927E 1928E 1929E 1930E 1931E 1932E 1933E 1934E 1935E 1936E 1937E 1938E 1939E 1940E 1941E 1942E 1943E 1944E 1945E 1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959E 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021R 2022R 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F
#  -0.118134 -0.123332 -0.128738 -0.13436 -0.140203 -0.146273 -0.152577 -0.159121 -0.165911 -0.172949 -0.18024 -0.187785 -0.195586 -0.203647 -0.211972 -0.220562 -0.229422 -0.238562 -0.247997 -0.257752 -0.267849 -0.278297 -0.28908 -0.300182 -0.311601 -0.323345 -0.335432 -0.347885 -0.360729 -0.37398 -0.387631 -0.40166 -0.416034 -0.430736 -0.445729 -0.460939 -0.476259 -0.491584 -0.506837 -0.522 -0.537116 -0.552371 -0.568048 -0.584445 -0.601943 -0.620702 -0.640506 -0.660712 -0.681109 -0.700609 -0.718791 -0.735659 -0.75023 -0.761171 -0.769048 -0.773742 -0.775655 -0.77388 -0.767919 -0.758277 -0.744977 -0.72849 -0.707464 -0.680539 -0.646178 -0.600889 -0.546219 -0.492678 -0.219787 -0.252797 -0.371157 -0.522009 -0.636705 -0.669333 -0.607872 -0.457693 -0.355781 -0.583489 -0.881707 -0.896026 -0.587708 -0.42822 -0.671527 -0.641158 -0.406026 -0.777018 -0.510341 -0.644266 -1.0265 -0.61063 -0.740878 -0.807557 -0.633439 -0.641202 -0.592263 -0.486557 -0.344459 -0.0929658 -0.132997 -0.229155 0.110812 -0.253024 0.0179494 0.351918 0.33925 0.00708283 0.154923 0.00860826 0.247957 0.552288 0.627108 1.11578 0.857801 0.324822 0.690592 1.37444 0.345691 0.856237 1.37863 0.949417 1.15391 1.57125 0.922543 0.902079 1.29238 0.174656 0.0298947 0.125016 0.239292 0.621583 0.368331 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.2 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# 1_CA_TWL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00012656 0.000195284 0.000210078 0.000164134 0.00016586 0.000130068 0.000115838 0.00013762 7.58117e-05 5.25436e-05 0.000173652 0.00022615 0.000281755 0.000522086 0.000457103 0.000641066 0.000443212 0.000610508 0.00053058 0.000549437 0.000333875 0.000515119 0.000532158 0.00071434 0.000590925 0.000475686 0.000117075 0.000590204 0.0025396 0.00603428 0.00573882 0.00237814 0.00277392 0.0025027 0.00231015 0.00476171 0.00347869 0.00339518 0.00248321 0.00270667 0.00270436 0.0031377 0.00425853 0.00323953 0.00252809 0.0020005 0.00201612 0.00286629 0.00181213 0.00242449 0.00176887 0.00242658 0.00230694 0.00564495 0.00608769 0.00922438 0.0115886 0.00921862 0.0119105 0.0132182 0.0146885 0.0145746 0.0218683 0.0112334 0.01688 0.0223412 0.0358554 0.0253988 0.0212419 0.0181538 0.00974449 0.0127175 0.0147975 0.0130469 0.0253505 0.0123591 0.0206623 0.00857759 0.0109989 0.0105471 0.0155381 0.0111761 0.00906292 0.00508122 0.000726614 0.000456429 0.000616995 4.23588e-05 7.42342e-05 8.98841e-05 0.000254633 0.000517244 0.000238192 3.62246e-05 9.67278e-06 6.09957e-06 8.90609e-06 2.23414e-05 2.67699e-05 8.80331e-05 3.29012e-05 0.000813557 0.00140036 0.00163702 0.000634873 0.000634274 0.000694545 0 0 0.0122162 0.0121499 0.0120969 0.0120439 0.0119775 0.0119244 0.0118712 0.0118048 0.0117516 0.0116985
# 2_OR_TWL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.01923e-05 6.31372e-06 2.60695e-07 5.1442e-06 1.89592e-05 3.74466e-05 0 5.47918e-05 0.0012766 0.00199458 0.00380757 0.0136106 0.0246416 0.0398604 0.0258309 0.0166865 0.0122244 0.0108682 0.0116787 0.0110189 0.0116971 0.0125375 0.0162777 0.0167866 0.0255298 0.0273765 0.0192018 0.0215103 0.0262272 0.0243202 0.0290274 0.016962 0.0262995 0.0217857 0.0250691 0.00415151 0.0238647 0.00765538 0.0157381 0.0203813 0.019693 0.0245434 0.015794 0.0113986 0.00744486 0.0175922 0.0556869 0.0446441 0.101822 0.0758651 0.160664 0.16897 0.0703977 0.0619776 0.063011 0.09673 0.114394 0.119046 0.0873023 0.186503 0.169867 0.187627 0.0826844 0.0592046 0.0732565 0.050109 0.0527718 0.0259118 0.00160366 0.000710996 0.000904525 0.000460215 0.000188636 0.000349129 0.000344173 6.61826e-05 8.22787e-05 0.000124207 5.9451e-05 4.13336e-05 8.10751e-05 6.75302e-05 0.000105406 0.000385937 0.000147385 0.00118659 0.00129119 0.0013406 0.00119767 0.00134357 0.00179284 0 0 0.0192551 0.0191508 0.0190675 0.0189843 0.0188801 0.0187968 0.0187135 0.0186092 0.0185258 0.0184423
# 3_WA_TWL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.25097e-07 0 4.03077e-06 3.15494e-05 4.11662e-05 3.72277e-05 5.56502e-05 5.91095e-05 0.000132657 5.03852e-05 0.000995391 0.0032903 0.00141096 0.0155062 0.00822712 0.00445205 0.00742916 0.00927309 0.00913942 0.00783864 0.00765877 0.00339482 0.00497719 0.00480683 0.00471167 0.0040101 0.0052057 0.00594835 0.00549764 0.00665857 0.00945975 0.00772204 0.00574309 0.0128833 0.0180099 0.00891339 0.0153303 0.0147739 0.0133813 0.0151751 0.00422879 0.00959943 0.0150059 0.0210247 0.0162856 0.0139055 0.0425272 0.0229062 0.0264625 0.0201076 0.0188282 0.0321961 0.0331515 0.0588554 0.053212 0.0634773 0.0660728 0.0894954 0.0894993 0.0882159 0.0838937 0.0317453 0.0162185 0.0155457 0.016534 0.0158661 0.0140616 0.00851345 0.000546072 0.000348758 0.000768642 0.000310697 0.000200624 0.000555164 0.000193734 7.81206e-05 5.75154e-05 8.78796e-05 0.0001001 5.35763e-05 6.88793e-05 5.7142e-05 2.46961e-05 4.14875e-05 4.86364e-05 0.000332716 0.00128992 0.000500107 0.000559264 0.000485148 0.000623975 0 0 0.00735858 0.00731873 0.00728693 0.00725517 0.00721542 0.00718366 0.00715188 0.0071121 0.00708028 0.00704843
# 4_CA_NTWL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000523687 0.000853017 0.000889853 0.000521684 0.000568973 0.000514213 0.000483274 0.000589477 0.000721044 0.00089656 0.00106394 0.000866702 0.000759575 0.00052188 0.000750751 0.000740398 0.000621169 0.00025112 0.000353929 0.000544158 0.000497769 0.00032048 0.000332713 0.000322367 0.000241983 0.00031762 0.000240137 0.000203992 0.000785727 0.00199333 0.00214193 0.000504334 0.00100929 0.00039921 0.000331339 0.000547422 0.000421287 0.000249994 0.00062212 0.000148721 0.000235028 0.000262979 0.000346697 0.000242337 0.00031186 0.000254376 0.000364231 0.000336301 0.00031059 0.000337497 0.000265113 0.000276457 0.000171947 0.000671814 0.000424943 0.000761965 0.00149899 0.000733405 0.00192564 0.00142454 0.00204365 0.00250409 0.00645036 0.00597963 0.00467177 0.00881771 0.00247232 0.00414479 0.00391259 0.00752635 0.00389888 0.00368756 0.00417462 0.0176381 0.0178747 0.0144693 0.0117493 0.00982327 0.00791683 0.00832248 0.00819524 0.00619204 0.00443019 0.00152587 0.000626219 0.000451973 4.17517e-06 7.67629e-05 7.9638e-05 4.94784e-05 7.59712e-05 9.0914e-05 2.9505e-05 3.50202e-05 0.00010358 0.00023797 7.13752e-05 9.92783e-05 6.41755e-05 7.04625e-05 3.86201e-05 8.3227e-05 7.9893e-05 0.000106152 0.000177259 0.000235394 0.000205177 0 0 0.0024563 0.00244297 0.00243231 0.00242165 0.0024083 0.00239763 0.00238697 0.00237362 0.00236295 0.00235227
# 5_OR_NTWL 5.56586e-05 5.5661e-05 5.56632e-05 1.43248e-05 3.46112e-06 3.55788e-06 2.02062e-06 3.37293e-06 4.73583e-06 6.2132e-06 7.61757e-06 9.04986e-06 1.06114e-05 1.21049e-05 1.36267e-05 1.51739e-05 1.68462e-05 1.8437e-05 2.0047e-05 2.17816e-05 2.34318e-05 2.51032e-05 2.69049e-05 2.86238e-05 3.0373e-05 3.21582e-05 3.40896e-05 3.59421e-05 3.78263e-05 3.98598e-05 4.18164e-05 4.38126e-05 4.59683e-05 4.8053e-05 5.01887e-05 5.20153e-05 8.77011e-05 0.000151809 0.000139917 0.000113591 3.66016e-05 6.09373e-05 6.64707e-05 6.04318e-05 0.000146228 0.000176438 0.000176411 0.000101851 0.000228633 0.000310525 0.000438427 0.00110969 0.000294418 0.000196681 0.000254089 0.000133216 0.000224952 0.000153893 0.000146682 0.000115725 0.0001128 6.01831e-05 7.18604e-05 9.11208e-05 5.95603e-05 0.000133013 2.72695e-05 5.7132e-05 3.87539e-05 0.000110029 0.000102432 9.29786e-05 2.15673e-05 0.000158495 0.000109584 0.000313067 0.000284003 0.000622594 0.000237759 0.000480088 0.000624348 0.000672884 0.000869664 0.000466545 0.000630378 0.000791183 0.00129916 0.00392085 0.00242459 0.00285775 0.00580459 0.0135343 0.00993323 0.0103417 0.00859094 0.0143213 0.0128569 0.0138102 0.0198755 0.024331 0.0170184 0.0453802 0.0117598 0.0103625 0.0132201 0.0181742 0.0158696 0.0067469 0.000517823 0.000429434 1.69004e-05 1.53992e-05 0.000173399 5.12656e-05 7.09991e-05 4.56927e-05 1.87778e-05 5.97414e-05 1.80722e-05 6.96934e-05 2.79221e-05 3.79169e-05 2.33803e-05 3.78347e-05 7.29355e-05 5.73273e-05 4.08316e-05 5.441e-05 6.21553e-05 5.22242e-05 8.62224e-05 0 0 0.000865252 0.000860564 0.000856818 0.000853071 0.000848384 0.000844638 0.000840893 0.000836206 0.000832458 0.000828707
# 6_WA_NTWL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000348353 0.000306713 0.000434814 0.000428795 0.0003898 0.000159201 0.000205715 0.000140019 0.000206363 5.75053e-05 5.07658e-05 2.31039e-05 1.49263e-05 9.5504e-05 5.53918e-05 7.11391e-05 0.000145059 8.34735e-05 4.10474e-05 6.83716e-05 0.000101146 4.97001e-05 2.92655e-05 1.79121e-05 1.32271e-05 2.0913e-05 9.03184e-06 5.48861e-06 0 0 0.000165125 0.000164231 0.000163517 0.000162805 0.000161913 0.0001612 0.000160487 0.000159594 0.00015888 0.000158165
# 7_CA_REC 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000105544 0.000214027 0.000249185 0.000337392 0.000428257 0.000521836 0.000618272 0.000717034 0.000819633 0.000987696 0.0009866 0.000877115 0.00128197 0.00120548 0.000652263 0.000636619 0.00053576 0.000738136 0.00131091 0.00106887 0.00217822 0.0028743 0.00356866 0.00429868 0.00381566 0.00330392 0.00419892 0.00512703 0.00576253 0.00542115 0.00921658 0.00739705 0.00570469 0.00393786 0.0047038 0.00483889 0.00418794 0.00601092 0.00627633 0.00653289 0.00707669 0.00804459 0.0104942 0.00938603 0.0124701 0.0147412 0.0161942 0.0166395 0.0192337 0.018784 0.0184945 0.0208838 0.0196162 0.0184706 0.0344619 0.0138663 0.0146931 0.0232049 0.0333004 0.034355 0.0289688 0.0184827 0.0280672 0.0262777 0.02373 0.0225848 0.0167479 0.0196829 0.00659328 0.0101101 0.00248002 0.00556379 0.00601033 0.00242672 0.00043371 0.00124214 0.00070943 0.000368288 0.000799353 0.000683877 0.000320632 0.000703019 0.000580434 0.000671446 0.000580176 0.000448003 0.000627469 0.00069869 0.000568792 0.00182668 0.00127456 0.00143341 0.00128038 0.00180778 0.00142127 0 0 0.0201625 0.0200528 0.0199647 0.0198766 0.0197667 0.0196789 0.0195913 0.0194816 0.0193938 0.0193061
# 8_OR_REC 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000299846 0.000619848 0.000972265 0.00134662 0.00171843 0.00213496 0.00259416 0.00281638 0.00370331 0.00418482 0.00255366 0.0033443 0.00185962 0.00383349 0.00259997 0.00212831 0.00258784 0.00165469 0.00229878 0.00313467 0.00401389 0.00289264 0.00326746 0.00185926 0.00220524 0.00310599 0.00169764 0.00126192 0.000617941 0.000474688 0.000449874 0.000103411 0.000142923 7.17389e-05 7.04699e-05 8.12577e-05 0.000101969 0.000125519 7.72736e-05 6.8978e-05 8.80353e-05 6.14887e-05 0.00026922 0.000170837 0.00045124 0.000647365 0.000553377 0.000836447 0.000529791 0.000793433 0 0 0.00920467 0.00915469 0.00911464 0.00907459 0.00902452 0.00898451 0.0089445 0.00889447 0.00885444 0.00881439
# 9_WA_REC 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.91904e-05 2.7177e-05 3.51005e-05 4.33039e-05 5.16829e-05 6.02273e-05 6.94442e-05 7.92746e-05 9.00678e-05 4.11815e-05 0.00010807 0.000164145 0.000123245 8.31954e-05 7.54768e-05 8.75036e-05 0.000165799 0.000309544 0.000155951 0.000264714 0.000285456 0.000291379 0.000476743 0.000475539 0.000547731 0.00111859 0.00108121 0.000596771 0.000472117 0.000421756 0.000371528 0.000585902 0.000317917 0.000225799 0.00017632 7.02028e-05 5.96384e-05 2.47219e-05 3.43772e-05 1.69574e-05 1.34168e-05 1.05308e-05 9.3682e-06 1.6125e-05 1.57331e-05 1.26332e-05 1.17621e-05 1.56943e-05 2.25349e-05 1.80959e-05 4.12193e-05 3.15405e-05 9.18502e-05 5.29827e-05 0.000224324 0.000233192 0 0 0.00204386 0.0020328 0.00202396 0.00201513 0.00200407 0.00199524 0.00198641 0.00197536 0.00196653 0.00195769
# 10_CA_ASHOP 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.08637e-05 8.0613e-07 1.14766e-05 8.64139e-05 2.00543e-06 1.86407e-06 1.60425e-06 0 1.30345e-06 0 7.84515e-06 1.49201e-05 3.47351e-06 1.27195e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7.41491e-08 7.37473e-08 7.34268e-08 7.31064e-08 7.27054e-08 7.23846e-08 7.20638e-08 7.16624e-08 7.13414e-08 7.10203e-08
# 11_OR_ASHOP 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000194183 3.6963e-05 0.000301404 0.000300149 0.000242156 4.55134e-05 7.35323e-06 7.67999e-05 4.69244e-05 0.000191808 3.73657e-05 0.000112764 0.000180929 8.36592e-05 0.000125046 0.000132282 6.29747e-06 1.1962e-05 4.95777e-05 1.06562e-05 1.32228e-06 2.79252e-05 1.38095e-05 3.48134e-06 1.05468e-05 4.03165e-05 8.29492e-05 7.33879e-06 0.000122763 1.31683e-05 1.0339e-05 3.76189e-05 1.06777e-05 5.61399e-07 5.12833e-07 1.5392e-07 1.38968e-06 1.01819e-06 4.33582e-06 8.6199e-07 2.2924e-06 1.66785e-05 2.59729e-05 5.66136e-06 1.54963e-06 2.21876e-05 2.70465e-05 0 0 0.000191529 0.000190492 0.000189665 0.000188838 0.000187803 0.000186976 0.000186148 0.000185112 0.000184284 0.000183456
# 12_WA_ASHOP 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.4148e-05 8.33001e-06 4.90623e-05 1.01483e-05 0.000903445 0.000977894 8.50254e-05 0.000117425 0.000166408 0.000288074 0.000109342 5.59504e-05 0.000105942 0.000111295 0.000151839 5.15863e-05 0.000296715 1.84708e-05 6.47917e-05 0.000162088 0.000261829 0.000335701 9.79969e-05 0.000112809 9.74051e-05 2.1099e-05 1.99593e-05 2.26097e-05 1.47044e-05 5.15916e-06 6.54767e-05 4.71575e-05 1.94876e-05 1.64695e-05 4.30801e-06 7.00003e-06 3.04679e-06 1.40073e-06 2.89041e-06 4.41981e-05 2.17588e-05 3.43669e-05 5.31303e-06 1.8228e-05 9.82348e-06 0 0 0.000229826 0.000228581 0.000227589 0.000226597 0.000225355 0.000224362 0.000223369 0.000222126 0.000221132 0.000220138
# 13_CA_FOR 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00121318 0.00303581 0.0120274 0.000142369 0 0 0.000367956 0.0107776 0.00446542 0.00191357 0.00151581 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7.41368e-08 7.37334e-08 7.34112e-08 7.30887e-08 7.26851e-08 7.23619e-08 7.20386e-08 7.16346e-08 7.13112e-08 7.09879e-08
# 14_OR_FOR 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.038761 0.0179729 0.00781625 0.00135474 0.00193764 0.00309646 0.00831975 0.0138835 0.00218664 0.00387239 0.0031749 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7.4149e-08 7.3747e-08 7.34261e-08 7.31053e-08 7.27038e-08 7.23827e-08 7.20615e-08 7.16595e-08 7.13379e-08 7.1016e-08
# 15_WA_FOR 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00306435 0.00247434 0.00298639 0.000325058 0.00074252 0.00183743 0.00178352 0.001807 0.0078266 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7.41539e-08 7.37522e-08 7.34317e-08 7.31114e-08 7.27106e-08 7.23903e-08 7.20697e-08 7.16685e-08 7.13474e-08 7.10261e-08
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
        28         1         0         0         0         1  #  28_coastwide_NWFSC
        29         1         0         0         0         0  #  29_coastwide_Tri_early
        30         2        29         0         0         0  #  30_coastwide_Tri_late
        31         1         0         1         0         1  #  31_coastwide_prerec
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -25            25      -2.49721             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_28_coastwide_NWFSC(28)
           -25            25      -1.99425             0             1             0          2          0          0          0          0          0          0          0  #  LnQ_base_29_coastwide_Tri_early(29)
           -25            25      -1.99425             0             1             0          2          0          0          0          0          0          0          0  #  LnQ_base_30_coastwide_Tri_late(30)
           -25            25      -5.79896             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_31_coastwide_prerec(31)
             0             3      0.504473           0.1            99             0          2          0          0          0          0          0          0          0  #  Q_extraSD_31_coastwide_prerec(31)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 1_CA_TWL
 24 0 0 0 # 2 2_OR_TWL
 24 0 0 0 # 3 3_WA_TWL
 24 0 0 0 # 4 4_CA_NTWL
 24 0 0 0 # 5 5_OR_NTWL
 15 0 0 3 # 6 6_WA_NTWL
 24 0 0 0 # 7 7_CA_REC
 24 0 0 0 # 8 8_OR_REC
 24 0 0 0 # 9 9_WA_REC
 24 0 0 0 # 10 10_CA_ASHOP
 15 0 0 10 # 11 11_OR_ASHOP
 15 0 0 10 # 12 12_WA_ASHOP
 15 0 0 1 # 13 13_CA_FOR
 15 0 0 2 # 14 14_OR_FOR
 15 0 0 3 # 15 15_WA_FOR
 0 0 0 0 # 16 16_CA_NWFSC
 0 0 0 0 # 17 17_OR_NWFSC
 0 0 0 0 # 18 18_WA_NWFSC
 0 0 0 0 # 19 19_CA_Tri_early
 0 0 0 0 # 20 20_OR_Tri_early
 0 0 0 0 # 21 21_WA_Tri_early
 0 0 0 0 # 22 22_CA_Tri_late
 0 0 0 0 # 23 23_OR_Tri_late
 0 0 0 0 # 24 24_WA_Tri_late
 0 0 0 0 # 25 25_CA_prerec
 0 0 0 0 # 26 26_OR_prerec
 0 0 0 0 # 27 27_WA_prerec
 24 0 0 0 # 28 28_coastwide_NWFSC
 24 0 0 0 # 29 29_coastwide_Tri_early
 15 0 0 29 # 30 30_coastwide_Tri_late
 0 0 0 0 # 31 31_coastwide_prerec
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 10 0 0 0 # 1 1_CA_TWL
 10 0 0 0 # 2 2_OR_TWL
 10 0 0 0 # 3 3_WA_TWL
 10 0 0 0 # 4 4_CA_NTWL
 10 0 0 0 # 5 5_OR_NTWL
 10 0 0 0 # 6 6_WA_NTWL
 10 0 0 0 # 7 7_CA_REC
 10 0 0 0 # 8 8_OR_REC
 10 0 0 0 # 9 9_WA_REC
 10 0 0 0 # 10 10_CA_ASHOP
 10 0 0 0 # 11 11_OR_ASHOP
 10 0 0 0 # 12 12_WA_ASHOP
 10 0 0 0 # 13 13_CA_FOR
 10 0 0 0 # 14 14_OR_FOR
 10 0 0 0 # 15 15_WA_FOR
 10 0 0 0 # 16 16_CA_NWFSC
 10 0 0 0 # 17 17_OR_NWFSC
 10 0 0 0 # 18 18_WA_NWFSC
 10 0 0 0 # 19 19_CA_Tri_early
 10 0 0 0 # 20 20_OR_Tri_early
 10 0 0 0 # 21 21_WA_Tri_early
 10 0 0 0 # 22 22_CA_Tri_late
 10 0 0 0 # 23 23_OR_Tri_late
 10 0 0 0 # 24 24_WA_Tri_late
 10 0 0 0 # 25 25_CA_prerec
 10 0 0 0 # 26 26_OR_prerec
 10 0 0 0 # 27 27_WA_prerec
 10 0 0 0 # 28 28_coastwide_NWFSC
 10 0 0 0 # 29 29_coastwide_Tri_early
 10 0 0 0 # 30 30_coastwide_Tri_late
 10 0 0 0 # 31 31_coastwide_prerec
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   1_CA_TWL LenSelex
        13.001            65       43.8637            99            99             0          4          0          0          0          0          0          2          2  #  Size_DblN_peak_1_CA_TWL(1)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_1_CA_TWL(1)
             0             9       4.05466            99            99             0          5          0          0          0          0          0          2          2  #  Size_DblN_ascend_se_1_CA_TWL(1)
             0             9       4.10098            99            99             0          5          0          0          0          0          0          2          2  #  Size_DblN_descend_se_1_CA_TWL(1)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_1_CA_TWL(1)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_1_CA_TWL(1)
# 2   2_OR_TWL LenSelex
        13.001            65       49.9006            99            99             0          4          0          0          0          0          0          2          2  #  Size_DblN_peak_2_OR_TWL(2)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_2_OR_TWL(2)
             0             9       4.20816            99            99             0          5          0          0          0          0          0          2          2  #  Size_DblN_ascend_se_2_OR_TWL(2)
             0             9       2.88415            99            99             0          5          0          0          0          0          0          2          2  #  Size_DblN_descend_se_2_OR_TWL(2)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_2_OR_TWL(2)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_2_OR_TWL(2)
# 3   3_WA_TWL LenSelex
        13.001            65       49.3322            99            99             0          4          0          0          0          0          0          2          2  #  Size_DblN_peak_3_WA_TWL(3)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_3_WA_TWL(3)
             0             9       4.40152            99            99             0          5          0          0          0          0          0          2          2  #  Size_DblN_ascend_se_3_WA_TWL(3)
             0             9       2.87228            99            99             0          5          0          0          0          0          0          2          2  #  Size_DblN_descend_se_3_WA_TWL(3)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_3_WA_TWL(3)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_3_WA_TWL(3)
# 4   4_CA_NTWL LenSelex
        13.001            65        37.687            99            99             0          4          0          0          0          0          0          1          2  #  Size_DblN_peak_4_CA_NTWL(4)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_4_CA_NTWL(4)
             0             9       4.38455            99            99             0          5          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_4_CA_NTWL(4)
             0             9       4.69087            99            99             0          5          0          0          0          0          0          1          2  #  Size_DblN_descend_se_4_CA_NTWL(4)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_4_CA_NTWL(4)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_4_CA_NTWL(4)
# 5   5_OR_NTWL LenSelex
        13.001            65       49.1522            99            99             0          4          0          0          0          0          0          1          2  #  Size_DblN_peak_5_OR_NTWL(5)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_5_OR_NTWL(5)
             0             9       4.53802            99            99             0          5          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_5_OR_NTWL(5)
             0             9       3.04611            99            99             0          5          0          0          0          0          0          1          2  #  Size_DblN_descend_se_5_OR_NTWL(5)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_5_OR_NTWL(5)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_5_OR_NTWL(5)
# 6   6_WA_NTWL LenSelex
# 7   7_CA_REC LenSelex
        13.001            65       30.4881            99            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_7_CA_REC(7)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_7_CA_REC(7)
             0             9       3.60609            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_7_CA_REC(7)
             0             9       4.51111            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_7_CA_REC(7)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_7_CA_REC(7)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_7_CA_REC(7)
# 8   8_OR_REC LenSelex
        13.001            65       29.4648            99            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_8_OR_REC(8)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_8_OR_REC(8)
             0             9        1.9861            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_8_OR_REC(8)
             0             9       5.25592            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_8_OR_REC(8)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_8_OR_REC(8)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_8_OR_REC(8)
# 9   9_WA_REC LenSelex
        13.001            65       32.6813            99            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_9_WA_REC(9)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_9_WA_REC(9)
             0             9       2.56374            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_9_WA_REC(9)
             0             9       6.02926            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_9_WA_REC(9)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_9_WA_REC(9)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_9_WA_REC(9)
# 10   10_CA_ASHOP LenSelex
        13.001            65       44.5358            99            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_10_CA_ASHOP(10)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_10_CA_ASHOP(10)
             0             9       2.89637            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_10_CA_ASHOP(10)
             0             9       4.77505            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_10_CA_ASHOP(10)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_10_CA_ASHOP(10)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_10_CA_ASHOP(10)
# 11   11_OR_ASHOP LenSelex
# 12   12_WA_ASHOP LenSelex
# 13   13_CA_FOR LenSelex
# 14   14_OR_FOR LenSelex
# 15   15_WA_FOR LenSelex
# 16   16_CA_NWFSC LenSelex
# 17   17_OR_NWFSC LenSelex
# 18   18_WA_NWFSC LenSelex
# 19   19_CA_Tri_early LenSelex
# 20   20_OR_Tri_early LenSelex
# 21   21_WA_Tri_early LenSelex
# 22   22_CA_Tri_late LenSelex
# 23   23_OR_Tri_late LenSelex
# 24   24_WA_Tri_late LenSelex
# 25   25_CA_prerec LenSelex
# 26   26_OR_prerec LenSelex
# 27   27_WA_prerec LenSelex
# 28   28_coastwide_NWFSC LenSelex
        13.001            65       51.8009            99            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_28_coastwide_NWFSC(28)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_28_coastwide_NWFSC(28)
             0             9       6.47651            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_28_coastwide_NWFSC(28)
             0             9       3.24825            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_28_coastwide_NWFSC(28)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_28_coastwide_NWFSC(28)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_28_coastwide_NWFSC(28)
# 29   29_coastwide_Tri_early LenSelex
        13.001            65       54.7143            99            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_29_coastwide_Tri_early(29)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_top_logit_29_coastwide_Tri_early(29)
             0             9       6.09031            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_29_coastwide_Tri_early(29)
             0             9       1.99174            99            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_29_coastwide_Tri_early(29)
           -99            99           -15            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_29_coastwide_Tri_early(29)
           -99            99          -999            99            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_end_logit_29_coastwide_Tri_early(29)
# 30   30_coastwide_Tri_late LenSelex
# 31   31_coastwide_prerec LenSelex
# 1   1_CA_TWL AgeSelex
# 2   2_OR_TWL AgeSelex
# 3   3_WA_TWL AgeSelex
# 4   4_CA_NTWL AgeSelex
# 5   5_OR_NTWL AgeSelex
# 6   6_WA_NTWL AgeSelex
# 7   7_CA_REC AgeSelex
# 8   8_OR_REC AgeSelex
# 9   9_WA_REC AgeSelex
# 10   10_CA_ASHOP AgeSelex
# 11   11_OR_ASHOP AgeSelex
# 12   12_WA_ASHOP AgeSelex
# 13   13_CA_FOR AgeSelex
# 14   14_OR_FOR AgeSelex
# 15   15_WA_FOR AgeSelex
# 16   16_CA_NWFSC AgeSelex
# 17   17_OR_NWFSC AgeSelex
# 18   18_WA_NWFSC AgeSelex
# 19   19_CA_Tri_early AgeSelex
# 20   20_OR_Tri_early AgeSelex
# 21   21_WA_Tri_early AgeSelex
# 22   22_CA_Tri_late AgeSelex
# 23   23_OR_Tri_late AgeSelex
# 24   24_WA_Tri_late AgeSelex
# 25   25_CA_prerec AgeSelex
# 26   26_OR_prerec AgeSelex
# 27   27_WA_prerec AgeSelex
# 28   28_coastwide_NWFSC AgeSelex
# 29   29_coastwide_Tri_early AgeSelex
# 30   30_coastwide_Tri_late AgeSelex
# 31   31_coastwide_prerec AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
        13.001            65       43.6297            99            99             0      4  # Size_DblN_peak_1_CA_TWL(1)_BLK2repl_2000
        13.001            65       43.1202            99            99             0      4  # Size_DblN_peak_1_CA_TWL(1)_BLK2repl_2011
             0             9       3.69741            99            99             0      5  # Size_DblN_ascend_se_1_CA_TWL(1)_BLK2repl_2000
             0             9        3.7944            99            99             0      5  # Size_DblN_ascend_se_1_CA_TWL(1)_BLK2repl_2011
             0             9       3.89151            99            99             0      5  # Size_DblN_descend_se_1_CA_TWL(1)_BLK2repl_2000
             0             9       3.99142            99            99             0      5  # Size_DblN_descend_se_1_CA_TWL(1)_BLK2repl_2011
        13.001            65       46.7027            99            99             0      4  # Size_DblN_peak_2_OR_TWL(2)_BLK2repl_2000
        13.001            65       49.0847            99            99             0      4  # Size_DblN_peak_2_OR_TWL(2)_BLK2repl_2011
             0             9        4.5287            99            99             0      5  # Size_DblN_ascend_se_2_OR_TWL(2)_BLK2repl_2000
             0             9       5.15342            99            99             0      5  # Size_DblN_ascend_se_2_OR_TWL(2)_BLK2repl_2011
             0             9       4.30884            99            99             0      5  # Size_DblN_descend_se_2_OR_TWL(2)_BLK2repl_2000
             0             9       3.69151            99            99             0      5  # Size_DblN_descend_se_2_OR_TWL(2)_BLK2repl_2011
        13.001            65       53.5193            99            99             0      4  # Size_DblN_peak_3_WA_TWL(3)_BLK2repl_2000
        13.001            65       52.0453            99            99             0      4  # Size_DblN_peak_3_WA_TWL(3)_BLK2repl_2011
             0             9       5.37722            99            99             0      5  # Size_DblN_ascend_se_3_WA_TWL(3)_BLK2repl_2000
             0             9        4.8336            99            99             0      5  # Size_DblN_ascend_se_3_WA_TWL(3)_BLK2repl_2011
             0             9       2.69738            99            99             0      5  # Size_DblN_descend_se_3_WA_TWL(3)_BLK2repl_2000
             0             9       3.01461            99            99             0      5  # Size_DblN_descend_se_3_WA_TWL(3)_BLK2repl_2011
        13.001            65        35.305            99            99             0      4  # Size_DblN_peak_4_CA_NTWL(4)_BLK1repl_2000
             0             9       3.48771            99            99             0      5  # Size_DblN_ascend_se_4_CA_NTWL(4)_BLK1repl_2000
             0             9       5.06451            99            99             0      5  # Size_DblN_descend_se_4_CA_NTWL(4)_BLK1repl_2000
        13.001            65       33.3266            99            99             0      4  # Size_DblN_peak_5_OR_NTWL(5)_BLK1repl_2000
             0             9       2.60975            99            99             0      5  # Size_DblN_ascend_se_5_OR_NTWL(5)_BLK1repl_2000
             0             9       5.65428            99            99             0      5  # Size_DblN_descend_se_5_OR_NTWL(5)_BLK1repl_2000
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      5     1     1     2     2     0     0     0     0     0     0     0
#      5     3     3     2     2     0     0     0     0     0     0     0
#      5     4     5     2     2     0     0     0     0     0     0     0
#      5     7     7     2     2     0     0     0     0     0     0     0
#      5     9     9     2     2     0     0     0     0     0     0     0
#      5    10    11     2     2     0     0     0     0     0     0     0
#      5    13    13     2     2     0     0     0     0     0     0     0
#      5    15    15     2     2     0     0     0     0     0     0     0
#      5    16    17     2     2     0     0     0     0     0     0     0
#      5    19    19     1     2     0     0     0     0     0     0     0
#      5    21    20     1     2     0     0     0     0     0     0     0
#      5    22    21     1     2     0     0     0     0     0     0     0
#      5    25    22     1     2     0     0     0     0     0     0     0
#      5    27    23     1     2     0     0     0     0     0     0     0
#      5    28    24     1     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1  0.214883
      5      1    1.8703
      4      2  0.315188
      5      2  0.283685
      4      3  0.175136
      5      3  0.200276
      4      4  0.235787
      4      5   0.09764
      4      6   3.26822
      4      7  0.071671
      5      8   2.23237
      4      9  0.471912
      5      9  0.396667
      4     11   0.18933
      5     11  0.484771
      4     12   0.11356
      5     12  0.132364
      4     16     0.081
      4     17     0.081
      4     18     0.081
      4     19     0.093
      4     20     0.093
      4     21     0.093
      4     22     0.114
      4     23     0.114
      4     24     0.114
      4      8  0.161374
      4     28  0.045575
      4     29  0.091686
      4     30  0.048085
      5      4  0.618285
      5      5   0.68154
      5      6   1.37706
      5     28   0.19169
      5     29  0.094427
      5     30  0.179229
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  0 #_CPUE/survey:_4
#  0 #_CPUE/survey:_5
#  0 #_CPUE/survey:_6
#  0 #_CPUE/survey:_7
#  0 #_CPUE/survey:_8
#  0 #_CPUE/survey:_9
#  0 #_CPUE/survey:_10
#  0 #_CPUE/survey:_11
#  0 #_CPUE/survey:_12
#  0 #_CPUE/survey:_13
#  0 #_CPUE/survey:_14
#  0 #_CPUE/survey:_15
#  0 #_CPUE/survey:_16
#  0 #_CPUE/survey:_17
#  0 #_CPUE/survey:_18
#  0 #_CPUE/survey:_19
#  0 #_CPUE/survey:_20
#  0 #_CPUE/survey:_21
#  0 #_CPUE/survey:_22
#  0 #_CPUE/survey:_23
#  0 #_CPUE/survey:_24
#  0 #_CPUE/survey:_25
#  0 #_CPUE/survey:_26
#  0 #_CPUE/survey:_27
#  1 #_CPUE/survey:_28
#  1 #_CPUE/survey:_29
#  1 #_CPUE/survey:_30
#  1 #_CPUE/survey:_31
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  1 #_lencomp:_4
#  1 #_lencomp:_5
#  1 #_lencomp:_6
#  1 #_lencomp:_7
#  1 #_lencomp:_8
#  1 #_lencomp:_9
#  0 #_lencomp:_10
#  1 #_lencomp:_11
#  1 #_lencomp:_12
#  0 #_lencomp:_13
#  0 #_lencomp:_14
#  0 #_lencomp:_15
#  0 #_lencomp:_16
#  0 #_lencomp:_17
#  0 #_lencomp:_18
#  0 #_lencomp:_19
#  0 #_lencomp:_20
#  0 #_lencomp:_21
#  0 #_lencomp:_22
#  0 #_lencomp:_23
#  0 #_lencomp:_24
#  0 #_lencomp:_25
#  0 #_lencomp:_26
#  0 #_lencomp:_27
#  1 #_lencomp:_28
#  1 #_lencomp:_29
#  1 #_lencomp:_30
#  0 #_lencomp:_31
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  1 #_agecomp:_5
#  1 #_agecomp:_6
#  0 #_agecomp:_7
#  1 #_agecomp:_8
#  1 #_agecomp:_9
#  0 #_agecomp:_10
#  1 #_agecomp:_11
#  1 #_agecomp:_12
#  0 #_agecomp:_13
#  0 #_agecomp:_14
#  0 #_agecomp:_15
#  1 #_agecomp:_16
#  1 #_agecomp:_17
#  1 #_agecomp:_18
#  1 #_agecomp:_19
#  1 #_agecomp:_20
#  1 #_agecomp:_21
#  1 #_agecomp:_22
#  1 #_agecomp:_23
#  1 #_agecomp:_24
#  0 #_agecomp:_25
#  0 #_agecomp:_26
#  0 #_agecomp:_27
#  1 #_agecomp:_28
#  1 #_agecomp:_29
#  1 #_agecomp:_30
#  0 #_agecomp:_31
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
#  1 #_init_equ_catch5
#  1 #_init_equ_catch6
#  1 #_init_equ_catch7
#  1 #_init_equ_catch8
#  1 #_init_equ_catch9
#  1 #_init_equ_catch10
#  1 #_init_equ_catch11
#  1 #_init_equ_catch12
#  1 #_init_equ_catch13
#  1 #_init_equ_catch14
#  1 #_init_equ_catch15
#  1 #_init_equ_catch16
#  1 #_init_equ_catch17
#  1 #_init_equ_catch18
#  1 #_init_equ_catch19
#  1 #_init_equ_catch20
#  1 #_init_equ_catch21
#  1 #_init_equ_catch22
#  1 #_init_equ_catch23
#  1 #_init_equ_catch24
#  1 #_init_equ_catch25
#  1 #_init_equ_catch26
#  1 #_init_equ_catch27
#  1 #_init_equ_catch28
#  1 #_init_equ_catch29
#  1 #_init_equ_catch30
#  1 #_init_equ_catch31
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

