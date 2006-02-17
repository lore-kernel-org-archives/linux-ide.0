From: Tejun Heo <htejun@gmail.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 18:19:23 +0900
Message-ID: <43F5951B.3020605@gmail.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com> <43F58B7E.4000401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:9207 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161167AbWBQJTb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 04:19:31 -0500
Received: by pproxy.gmail.com with SMTP id x66so429041pye
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2006 01:19:30 -0800 (PST)
In-Reply-To: <43F58B7E.4000401@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Just a side note.  Taskfile has finer granuality regarding which 
>> registers are written and read back than current libata does and IDE 
>> taskfile implementation is somewhat broken/weird in a few delicate fun 
>> ways, so... be careful.  Whoever tries it.

Hello, Jeff.

> Yes -- it opens the question about whether we care enough to fully 
> support flagged taskfiles, and if not, how to best emulate that support 
> under libata.

Yeah, and another difficult question is - Are we going to exactly 
replicate the behavior of IDE TASKFILE or try to fix / clean up?  I have 
no idea what should be done.  The thing with TASKFILE is that it doesn't 
have too many users but has enough annoying inconsistencies/bugs.  So, 
neither of rigorous replication or behavior cleanup feels right.

> I'm told that flagging individual ATA shadow registers for modification 
> (or not) is required for issuing certain specialized PATA 
> vendor-specific commands.  SATA, OTOH, transmits all ATA shadow 
> registers in a FIS, so flagged taskfiles are useless.
> 
> So, I'm now thinking the best route is to leave the code as it is ;-) 
> Rather than imperfectly implementing the flagged taskfile ioctl, punt 
> the remaining userland users to SG_IO.
> 
> I don't see lack of full flagged taskfile support as a big stumbling 
> block to libata use.

I agree.  HDIO_DRIVE_CMD and HDIO_DRIVE_TASK are orders simpler compared 
to HDIO_DRIVE_TASKFILE and we don't even know what's TASKFILE's correct 
behavior is.  So, I think we should just leave TASKFILE out there in the 
wilderness and watch it with sorrow as it dies slowly.

Also, as you pointed out, it's hardware-wise impossible to do 
register-level granuality with SATA and I'll be surprised if any more 
need for register-level granuality arises than there currently is.  So, 
I say we can forget about it without too much trouble.  And if such need 
EVER arises, let's hope SAT guys come up with something reasonable.

Thanks.

-- 
tejun
