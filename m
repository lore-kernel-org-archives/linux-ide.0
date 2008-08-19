From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/5] ide debugging macros
Date: Tue, 19 Aug 2008 08:15:38 +0200
Message-ID: <20080819061538.GA30315@gollum.tnic>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com> <200808182308.38345.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:28738 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbYHSGPh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 02:15:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2400561fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 18 Aug 2008 23:15:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200808182308.38345.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Aug 18, 2008 at 11:08:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Sunday 17 August 2008, Borislav Petkov wrote:
> > Hi Bart,
> > 
> > here's something i've been wanting to do for a long time: debugging macros. The
> > reason for it is that i got tired of adding debug printk's everytime i'm testing
> > something so here we go.
> > 
> > The debugging macro is similar to the old ones but is one for all drivers
> > (currently only ide-floppy), is nice on branch prediction and is controlled by a
> > drive->debug_mask switch which is a module parameter and as such can be set at
> > module load time, of course. I've been thinking of adding also a sysfs attribute
> > too but can't seem to find quite the justification for it so no sysfs for now :)
> 
> if you look closely you should already find it :)
> 
> [ module parameters are exported through sysfs and it uses 0644 mask ]

Those I saw. (You mean /sys/bus/ide/drivers/ide-cdrom/, for example, right?)
But if so, those come from the gen_driver's ide_bus_type and those are device
attributes and I was thinking of adding ide_bus_type.drv_attrs which are driver-
and not device-specific but since i haven't read into the sysfs code too much
yet this is my hunch what we should do.

> > In addition, one can still optimize away all the debug calls in the old manner
> > and i'm sure those will be removed completely too when ide generic conversion is
> > done.
> > 
> > Please tell me what you think, what can be changed/improved and after we've
> > figured out the details I'll do the other drivers too.
> 
> Looks pretty good to me (after quick look) and I applied to pata tree.
> 
> PS I wonder whether we may also want to have global debug_mask for core code
> messages ('drive' is not always available) in the longer-term.  Or maybe even
> only global debug_mask for both core code and driver messages?

Let me answer you with a question :) : is a u64 bitmask going to be enough for
all the debugging levels, both core and drivers ? The way I see it, hmm, probably ...

-- 
Regards/Gruss,
    Boris.
