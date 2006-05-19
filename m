From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv dropping disks
Date: Fri, 19 May 2006 17:06:26 -0400
Message-ID: <446E3352.20405@rtr.ca>
References: <20060518213131.GA10777@virasto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3272 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751080AbWESVG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 17:06:28 -0400
In-Reply-To: <20060518213131.GA10777@virasto.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Onis <onion@virasto.com>
Cc: linux-ide@vger.kernel.org

Onis wrote:
> Hello
> 
> Got warnings while rebuilding md raid5 array. Controller is 88SX5081 with
> 8xMaxtor 300GB 7V300F0. I've ran badblock -w on all disks, smartctl doesn't
> report errors.
> 
> ----
> BUG: warning at drivers/scsi/sata_mv.c:1884/mv_channel_reset()
> 
> Call Trace: <IRQ> <ffffffff803a39ce>{mv_channel_reset+238}
>        <ffffffff803a4277>{mv_stop_and_reset+55}
> <ffffffff803a45f7>{mv_interrupt+631}
>        <ffffffff8024e9fc>{handle_IRQ_event+44}
> <ffffffff8024eae0>{__do_IRQ+176}
...

I'm not sure what the complaint is about there.
I see this on line 1884:  mdelay(1);
But maybe the 2.6.17-rc4-mm1 version is different from
the 2.6.17-rc4-git2-libata1 that I have handy right now. (?)

>        BUG: warning at drivers/scsi/sata_mv.c:1904/__msleep()

Similarly, on that line I see:  mdelay(20);
Is there something different about mdelay() in -mm now?

..
> What does "PCI IRQ cause=0x28000020" mean?

"MWrPerr: SErr# asserted upon a PErr# response to write data by the PCI master"

In other words, a PCI bus parity error was detected.
Noisy bus, or buggy hardware.

>        ata4: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
>        ata4: status=0x50 { DriveReady SeekComplete }
>        ata4: error=0x01 { AddrMarkNotFound }

That is wrong (bug).  I *think* this may be fixed by the sata_mv
patch series I just posted today.  The response should be to reset
the bus (well, at least that's what it does now) and then retry
the operation, not fail it immediately.

..
> Also I'm getting a lots of these on all ports on boot. smartctl also triggers
> these:
> ----
> ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata3: status=0xd0 { Busy }
> ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata1: status=0xd0 { Busy }
> ...

That's due to a Marvell chip bug.  A workaround for that got posted in
my patch series today.

Cheers
