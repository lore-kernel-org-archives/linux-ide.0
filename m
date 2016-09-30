From: Adam Manzanares <adam.manzanares@hgst.com>
Subject: Re: [PATCH 1/3] block: Add iocontext priority to request
Date: Fri, 30 Sep 2016 09:02:17 -0700
Message-ID: <20160930160216.GA13637@hgst.com>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
 <1475000096-6148-2-git-send-email-adam.manzanares@hgst.com>
 <20160929084059.GB11087@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6632 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbcI3QC3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2016 12:02:29 -0400
Content-Disposition: inline
In-Reply-To: <20160929084059.GB11087@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-ide@vger.kernel.org

Hello Tejun,

The 09/29/2016 10:40, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 27, 2016 at 11:14:54AM -0700, Adam Manzanares wrote:
> > Patch adds association between iocontext and a request.
> > 
> > Signed-off-by: Adam Manzanares <adam.manzanares@hgst.com>
> 
> Can you please describe how this may impact existing usages?
>
I'll start with the changes I made and work my way through a grep of            
ioprio. Please add or correct any of the assumptions I have made.               
                                                                                
In blk-core, the behavior before the patch is to get the ioprio for the request 
from the bio. The only references I found to bio_set_prio are in bcache. Both   
of these references are in low priority operations (gc, bg writeback) so the    
iopriority of the bio is set to IO_PRIOCLASS_IDLE in these cases.               
                                                                                
A kernel thread is used to submit these bios so the ioprio is going to come     
from the current running task if the iocontext exists. This could be a problem  
if we have set a task with high priority and some background work ends up       
getting generated in the bcache layer. I propose that we check if the           
iopriority of the bio is valid and if so, then we keep the priorirty from the   
bio.                                                                            
                                                                                
The second area that I see a potential problem is in the merging code code in   
blk-core when a bio is queued. If there is a request that is mergeable then     
the merge code takes the highest priority of the bio and the request. This      
could wipe out the values set by bio_set_prio. I think it would be              
best to set the request as non mergeable when we see that it is a high          
priority IO request.                                                            
                                                                                
The third area that is of interest is in the CFQ scheduler and the ioprio is    
only used in the case of async IO and I found that the priority is only         
obtained from the task and not from the request. This leads me to believe that  
the changes made in the blk-core to add the priority to the request will not    
impact the CFQ scheduler. 

The fourth area that might be concerning is the drivers. virtio_block copies    
the request priority into a virtual block request. I am assuming that this      
eventually makes it to another device driver so we don't need to worry about    
this. null block device driver also uses the ioprio, but this is also not a     
concern. lightnvm also sets the ioprio to build a request that is passed onto   
another driver. The last driver that uses the request ioprio is the fusion      
mptsas driver and I don't understand how it is using the ioprio. From what I    
can tell it is taking a request of IOPRIO_CLASS_NONE with data of 0x7 and       
calling this high priority IO. This could be impacted by the code I have        
proposed, but I believe the authors intended to treat this particular ioprio    
value as high priority. The driver will pass the request to the device          
with high priority if the appropriate ioprio values is seen on the request.     
                                                                                
The fifth area that I noticed may be impacted is file systems. btrfs uses low   
priority IO for read ahead. Ext4 uses ioprio for journaling. Both of these      
issues are not a problem because the ioprio is set on the task and not on a     
bio.

> Thanks.
> 
> -- 
> tejun

Take care,
Adam
