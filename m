From: TAKADA Yoshihito <takada@mbf.nifty.com>
Subject: Re: IDE driver assined IRQ for disabled IDE channel
Date: Thu, 31 Jul 2008 02:57:45 +0900 (JST)
Message-ID: <20080731.025745.74750491.takada@mbf.nifty.com>
References: <200807261358.59667.bzolnier@gmail.com>
	<20080727.105140.141855485.takada@mbf.nifty.com>
	<200807271556.52270.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pxy2nd.nifty.com ([202.248.175.14]:20122 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750969AbYG3SCP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jul 2008 14:02:15 -0400
In-Reply-To: <200807271556.52270.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE driver assined IRQ for disabled IDE channel
Date: Sun, 27 Jul 2008 15:56:52 +0200

> ide_generic has no enablebits checking but 'ide_generic.probe_mask=1'
> kernel parameter can be used to limit probing to the first port only.

Ok, I understood.

> However shouldn't a designated IDE PCI host driver be used instead?

I feel drivers/ide/cs5520 is unstable with TuxOnIce. So I use ide_generic
instead of cs5520 and looked at the state

> [ if this is Cx5520 PCI IDE, the cs5520 host driver misses enablebits
>   checking, untested fix attached ]

Yes, My little box has cs5520. I applied the patch, it works fine.
dmesg says:

Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Cyrix 5520: IDE controller (0x1078:0x0002 rev 0x00) at  PCI slot 0000:00:12.0
PCI: Setting latency timer of device 0000:00:12.0 to 64
Cyrix 5520: IDE port disabled
    ide0: BM-DMA at 0x5000-0x5007
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive

> ide_generic has no enablebits checking but 'ide_generic.probe_mask=1'
> kernel parameter can be used to limit probing to the first port only.

Ok, I understood.

> However shouldn't a designated IDE PCI host driver be used instead?

I feel drivers/ide/cs5520 is unstable with TuxOnIce. So I use ide_generic
instead of cs5520 and looked at the state.

> > ide_probe_port() returns -ENODEV, so hwif->present clear to 0.
> > I think hwif->present mean IDE channel is exist/enabled. Doesn't mean
> > connected devices(disks, CD-ROM drives and others).
> 
> It used to mean both because the port was registered only if there
> were devices connected to it but it is no longer a case (seems like
> ->present documentation in ide.h is out of date now and needs fixing).

I see too.

