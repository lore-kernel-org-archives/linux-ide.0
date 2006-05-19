From: Onis <onion@virasto.com>
Subject: Re: sata_mv dropping disks
Date: Sat, 20 May 2006 01:25:40 +0300
Message-ID: <20060519222540.GA15276@virasto.com>
References: <20060518213131.GA10777@virasto.com> <446E3352.20405@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from virasto.com ([212.213.212.50]:12934 "EHLO virasto.com")
	by vger.kernel.org with ESMTP id S1751409AbWESWZm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 18:25:42 -0400
Content-Disposition: inline
In-Reply-To: <446E3352.20405@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:

> >BUG: warning at drivers/scsi/sata_mv.c:1884/mv_channel_reset()
> ...
> >What does "PCI IRQ cause=0x28000020" mean?
> 
> "MWrPerr: SErr# asserted upon a PErr# response to write data by the PCI 
> master"
> 
> In other words, a PCI bus parity error was detected.
> Noisy bus, or buggy hardware.

Yes, that was fixed by relaxing bus speed to 133->66MHz, ignore it. My bad.

> >       ata4: translated ATA stat/err 0x50/01 to SCSI SK/ASC/ASCQ 0x3/13/00
> >       ata4: status=0x50 { DriveReady SeekComplete }
> >       ata4: error=0x01 { AddrMarkNotFound }
> 
> That is wrong (bug).  I *think* this may be fixed by the sata_mv
> patch series I just posted today.  The response should be to reset
> the bus (well, at least that's what it does now) and then retry
> the operation, not fail it immediately.

I think this was related to bus speed also. Haven't seen this error before.

> >Also I'm getting a lots of these on all ports on boot. smartctl also 
> >triggers
> >these:
> >----
> >ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> >ata3: status=0xd0 { Busy }
> >ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> >ata1: status=0xd0 { Busy }
> >...
> 
> That's due to a Marvell chip bug.  A workaround for that got posted in
> my patch series today.

Thanks a lot for the patch Mark! I grabbed immediately and patched against
2.6.17-rc4. Is it okay?

Now I'm now running rebuild with 6081 controller. Everything seems great. No
ata busy warnings or anything.

> Cheers

Cheers!
