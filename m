From: Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: [PATCH v3 1/2] block: Add iocontext priority to request
Date: Wed, 12 Oct 2016 10:58:30 -0700
Message-ID: <20161012175830.GA4072@hgst.com>
References: <1476218427-4021-1-git-send-email-adam.manzanares@hgst.com>
 <1476218427-4021-2-git-send-email-adam.manzanares@hgst.com>
 <4b60fe5d-113f-9361-bbae-7473002500ba@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21923 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbcJLSBL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2016 14:01:11 -0400
Content-Disposition: inline
In-Reply-To: <4b60fe5d-113f-9361-bbae-7473002500ba@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Adam Manzanares <adam.manzanares@hgst.com>, tj@kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org

The 10/12/2016 08:49, Jens Axboe wrote:
> On 10/11/2016 02:40 PM, Adam Manzanares wrote:
> >Patch adds an association between iocontext ioprio and the ioprio of
> >a request. This feature is only enabled if a queue flag is set to
> >indicate that requests should have ioprio associated with them. The
> >queue flag is exposed as the req_prio queue sysfs entry.
> 
> Honestly, I don't get this patchset. For the normal file system path, we
> inherit the iocontext priority into the bio. That in turns gets
> inherited by the request. Why is this any different?
>
I was hoping this was true before I started looking into this, but the 
iocontext priority is not set on the bio. I did look into setting the
iocontext priority on the bio, and this would have do be done close 
in the call stack to init_request_from_bio so I chose to set it here.

If I missed where this occurs I would appreciate it if you pointed me to the 
code where the bio gets the iopriority from the iocontext. 

> It'd be much cleaner to just have 'rq' inherit the IO priority from the
> io context when the 'rq' is allocated, and ensuring that we inherit and
> override this if the bio has one set instead. It should already work
> like that.

I looked into the request allocation code and the only place I see where 
the iocontext is associated with the request is through a icq. Looking at 
the documentation of the icq it states that the icq_size of the elevator 
has to be set in order for block core to manage this. The only scheduler 
using this currently is the cfq scheduler and I think prioritized requests 
should be independent of the scheduler used. 

I agree that this should make it into the code where the rq is allocated.

Again if I have missed something please point me to the relevant code and 
I will modify the patch as necessary.

> 
> And in no way should we add some sysfs file to control this, that is
> nuts.

My concern is that we will now be exposing priority information to lower 
layers and if there happens to be code that uses the priority now it will 
actually make an impact. My example being the fusion mptsas driver. 

The second issue I foresee is that lower level drivers will need a sysfs 
file to control whether or not we send prioritized commands to the device.
We are wary of sending prioritized commands by default when we are unsure
of how the device will respond to these prioritized commands.

The reason I propose a sysfs file in the queue is that it solves these two 
issues at the same time. 

I would appreciate it if you could suggest an alternative fix for these issues
or an explanation of why these concerns are not valid.

> 
> -- 
> Jens Axboe
> 

Take care,
Adam
