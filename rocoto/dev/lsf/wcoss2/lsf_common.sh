#!/bin/sh

export cyc=00
export PDY=20210731

echo PATH=$PATH:/apps/ops/prod/nco/core/prod_util.v2.0.8/exec
fhrp=6
export pdycycp=$(ndate -$fhrp $PDY$cyc)
export pdyp=$(echo $pdycycp|cut -c1-8)
export cycp=$(echo $pdycycp|cut -c9-10)

export envir=${envir:-dev}
export RUN_ENVIR=${RUN_ENVIR:-dev}
export NET=${NET:-gefs}
export RUN=${RUN:-gefs}

export ver_gefs=v12.2
export ver_gfs=v16.2
export ver_cfs=v2.3

export HOMEgefs=${HOMEgefs:-/lfs/h2/emc/ens/noscrub/Xianwu.Xue/gefs/gefs_port2wcoss2}
export WORKDIR=/lfs/h2/emc/ptmp/Xianwu.Xue/o/gefs_port2wcoss2

export GEFS_ROCOTO=${HOMEgefs}/rocoto

#. $GEFS_ROCOTO/bin/wcoss2/common.sh
#====
UseData="old" #old, canned, new
if [[ UseData == "old" ]]; then
	HOMEdata=/lfs/h2/emc/ens/noscrub/Xianwu.Xue/gefs/HOMEdata/com
	export COMINgfs_base=${HOMEdata}/gfs/prod/gfs.
	export COMINenkf_base=${HOMEdata}/gfs/prod/enkfgdas.
	export COMINcfs_base=${HOMEdata}/cfs/prod/cfs/cfs.
	export COMINgfs=${COMINgfs:-${COMINgfs_base}${PDY}/$cyc/atmos}
	export COMINenkf=${COMINenkf:-${COMINenkf_base}${pdyp}/$cycp/atmos}

	export COMIN_WAV_ICE=$COMINgfs
	#export COMINenkf=${COMINenkf:-${COMINenkf_base}}
	export COMINcfs=${COMINcfs:-${COMINcfs_base}}

	export DCOMROOT=/lfs/h2/emc/ens/noscrub/Xianwu.Xue/gefs/HOMEdata/dcom/prod
elif [[ UseData == "new" ]]; then
	HOMEdata=/lfs/h2/emc/ens/noscrub/Xianwu.Xue/gefs/HOMEdata
	export COMPATH=$HOMEdata/canned/com/gfs:$HOMEdata/canned/com/cfs
#	compath.py canned/com/gfs/${ver_gfs}
#	compath.py canned/com/gfs/${ver_cfs}

	export COMINgfs=$(compath.py canned/com/gfs/${ver_gfs})/gfs.${PDY}/${cyc}/atmos
	export COMIN_WAV_ICE=$COMINgfs
	export COMINenkf=$(compath.py compath.py canned/com/gfs/${ver_gfs})/enkfgdas.${pdyp}/${cycp}/atmos

	export DCOMROOT=${HOMEdata}/canned/dcom
	# /lfs/h1/ops/canned/com/
	# export DCOMROOT=/lfs/h1/ops/canned/dcom
	# export COMPATH=/lfs/h1/ops/canned/com/blend:/lfs/h1/ops/canned/com/gfs:/lfs/h1/ops/canned/com/gefs
#	HOMEdata=/lfs/h1/emc/ens/noscrub/Xianwu.Xue/gefs/HOMEdata/com
#    export COMINgfs_base=${HOMEdata}/gfs/prod/gfs. #/gpfs/dell3/ptmp/emc.glopara/ROTDIRS/v16rt2/gfs/para/gfs.
#    #export COMINgfs_base=$(compath.py gfs/prod)/gfs.
#    export COMINenkf_base=${HOMEdata}/gfs/prod/enkfgdas.
#    #export COMINenkf_base=$(compath.py gfs/prod)/enkfgdas.
#    export COMINcfs_base=${HOMEdata}/cfs/prod/cfs/cfs.
#    #export COMINcfs_base=$(compath.py cfs/prod)/cfs/cfs.
#    export COMIN_WAV_ICE=${HOMEdata}/gfs/prod/gfs.${PDY}/${cyc}/atmos
#    #export COMIN_WAV_ICE=$(compath.py gfs/prod)/gfs.${PDY}/${cyc}/atmos
#    export COMINgfs=${COMINgfs:-${COMINgfs_base}${PDY}/$cyc/atmos}
#    export COMINenkf=${COMINenkf:-${COMINenkf_base}${pdyp}/$cycp/atmos}
fi


#===
export job=${job:-$PBS_JOBNAME}

export COMROOT=${WORKDIR}/com
export GESROOT=${WORKDIR}/nwges
export DATAROOT=${WORKDIR}/tmp

export SENDCOM=YES
export KEEPDATA=YES     # ecflow NO
export SENDECF=NO       # ecflow YES
export SENDDBN=NO       # ecflow YES
export SENDDBN_NTC=NO   # ecflow YES