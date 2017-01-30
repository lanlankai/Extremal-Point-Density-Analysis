/*
 * written by Yongxiang Huang 14/12/2016
 * yongxianghuang@gmail.com/yongxianghuang@xmu.edu.cn
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include "mex.h"
#include "math.h"




/************************************************************************/
/*                                                                      */
/* detection of local extrema with Coarse-Grained operation                    */
/*                                                                      */
/************************************************************************/

void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
    double *nmin,*xe, *ys,*dy,tmp,*tau;
    int i, j,ny,  ntmp,k,ntau;
    
    /*check the input*/
    
    
    
    ys=mxGetPr(prhs[0]);
    ny=mxGetN(prhs[0]); /*get the length of the data*/
    ntmp=mxGetM(prhs[0]);
    if(ntmp>ny)ny=ntmp;
    
    tau=mxGetPr(prhs[1]);
    ntau=mxGetN(prhs[1]); /*get the length of the data*/
    ntmp=mxGetM(prhs[1]);
    if(ntmp>ntau)ntau=ntmp;
    
    
    /*output*/
    plhs[0]=mxCreateDoubleMatrix(1,ntau,mxREAL);
    nmin=mxGetPr(plhs[0]);
    plhs[1]=mxCreateDoubleMatrix(ny,ntau,mxREAL);
    xe=mxGetPr(plhs[1]);
    
  
    
    
    for(j=0;j<ntau;j++){
        for(i=1;i<(ny-1-(int)tau[j]);i++) {
            if(((ys[i+(int)tau[j]]>ys[i-1])&&(ys[i+(int)tau[j]+1]<ys[i]))||((ys[i+(int)tau[j]]<ys[i-1])&&(ys[i+(int)tau[j]+1]>ys[i]))){
                nmin[j]=  nmin[j]+1.0;
                xe[j*ny+i]=1.0;
            }
        }
        nmin[j]=nmin[j]/(double)(ny-(int)tau[j]);
    }
}
