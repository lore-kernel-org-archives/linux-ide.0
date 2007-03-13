From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Command Timeout on ARM XScale
Date: Tue, 13 Mar 2007 14:17:49 -0700
Message-ID: <8202f4270703131417t3daacf1tf361e0449ad1f93b@mail.gmail.com>
References: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>
	 <20070313193957.396d7d1d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:40351 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933334AbXCMVRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 17:17:50 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1623164nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 14:17:49 -0700 (PDT)
In-Reply-To: <20070313193957.396d7d1d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 3/13/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > above 1.5.   Two timers are used to track command timeout in our test
> > software.  The one in the user space is set to 6 seconds using alarm()
> > call while the one in the kernel (scsi timer) is set to 5 seconds.
> > These timeout values are probably too low to be realistic,  but the
> > issue here is not about the timeout itself but to understand why it is
>
> A lot of drive commands seem to be set up on a seven second worst case
>
> > always user space timer expired before kernel timer.   Since kernel
> > timer uses jiffies to track time, does this imply a kernel bug where
> > the time interrupts were lost or delay somehow?  Do you know any know
> > problems related to command timeout in PATA Sil680?
>
> Alarm() is also handled by the same jiffies logic, so I suspect a bug in
> your test environment ?
>
>
I enabled ata_irq_trap and did the same test again. The kernel timer
caught the timeout (10 seconds) this time along with the irq trap
traces below.  What's the cause of these idle irqs?

[42949560.150000] SCSI device sdb: drive cache: write back
[   85.570000] ata1: irq trap
[   85.820000] ata2: irq trap
[   92.120000] abnormal status 0xD0
[   92.120000] ata1: irq trap
[   92.920000] ata2: irq trap
[   98.750000] ata1: irq trap
[  100.260000] abnormal status 0xD0
[  100.260000] ata2: irq trap
[  105.540000] ata1: irq trap
[  108.050000] ata1: irq trap
[  110.620000] ata1: irq trap
[  113.130000] ata1: irq trap
[  115.530000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  115.530000] ata1.00: (BMDMA stat 0x0)
[  115.530000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[  115.530000] ata1: soft resetting port
[  115.570000] ata1.00: configured for UDMA/100
[  115.570000] sg_cmd_done: sg0, pack_id=2706, res=0x8000002, dur=10040 ms
[  115.570000] ata1: EH complete
[  115.580000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  115.580000] sda: Write Protect is off
[  115.580000] sda: Mode Sense: 00 3a 00 00
[  115.580000] SCSI device sda: drive cache: write back
...

Thanks,
Fajun
