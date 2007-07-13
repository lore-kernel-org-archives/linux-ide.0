From: Mark Lord <liml@rtr.ca>
Subject: Re: Spinup command fails on WD3200JS
Date: Fri, 13 Jul 2007 08:53:52 -0400
Message-ID: <469775E0.2000609@rtr.ca>
References: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1262 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504AbXGMMxx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 08:53:53 -0400
In-Reply-To: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Power <rpower@sysreset.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

> Hi.
> I've run into a problem with the lastest kernel (2.6.22.1) and a drive set to spinup on set_features.
..
> ATA device, with non-removable media
> powers-up in standby; SET FEATURES subcmd spins-up.
>         Model Number:       WDC WD3200JS-57PDB0
>         Serial Number:      X
>         Firmware Revision:  21.00M21
> ...
>            *    Power-Up In Standby feature set
>            *    SET_FEATURES required to spinup after power up
> ...
> Jul 12 23:47:22 sysreset kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Jul 12 23:47:22 sysreset kernel: ata6.00: ATA-7: WDC WD3200JS-57PDB0, 21.00M21, max UDMA/133
> Jul 12 23:47:22 sysreset kernel: ata6.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 1)
> Jul 12 23:47:22 sysreset kernel: ata6.00: failed to IDENTIFY (SPINUP failed, err_mask=0x1)
> Jul 12 23:47:22 sysreset kernel: ata6.00: revalidation failed (errno=-5)
> Jul 12 23:47:22 sysreset kernel: ata6: failed to recover some devices, retrying in 5 secs
> Jul 12 23:47:22 sysreset kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Jul 12 23:47:22 sysreset kernel: ata6.00: failed to IDENTIFY (SPINUP failed, err_mask=0x1)
> Jul 12 23:47:22 sysreset kernel: ata6.00: revalidation failed (errno=-5)
> Jul 12 23:47:22 sysreset kernel: ata6.00: limiting speed to UDMA/133:PIO3
> Jul 12 23:47:22 sysreset kernel: ata6: failed to recover some devices, retrying in 5 secs
> Jul 12 23:47:22 sysreset kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Jul 12 23:47:22 sysreset kernel: ata6.00: failed to IDENTIFY (SPINUP failed, err_mask=0x1)
> Jul 12 23:47:22 sysreset kernel: ata6.00: revalidation failed (errno=-5)
> Jul 12 23:47:22 sysreset kernel: ata6.00: disabled

It would be handy to see those messages again with real timestamps on them.
Ryan, could you add CONFIG_PRINTK_TIME=y into your .config and rebuild/retry ?

> The interesting thing is that after displaying that, the drive has in fact spun up.
> I'm not sure why it's getting an error returned, but chaning the err_mask line
> to read "if (err_mask && err_mask != 0x01)" corrects the problem and the drive
> spins up and ID's normally:

Yeah, I believe that for WD drives.  Their firmware has *always* been peculiar.
In fact, the WD Raptor drives I used to have here had similar, though not identical,
problems with the "jumper-enabled" power-on-in-standby version.  I never did figure
those ones out.

But yes, perhaps your suggestion of just ignoring the device's response
may be best.  Are you sure it spins up on the very first attempt?
Also, could you add this printk() line to just before your err_mask hack:

   printk("id[2]=0x%04x\n", id[2]);

If we see 0x738c reported from that, then we *know* we should just continue
rather than err'ing out as is presently done.

Thanks
