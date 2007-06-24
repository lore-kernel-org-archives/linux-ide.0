From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: SATA RAID5 speed drop of 100 MB/s
Date: Sun, 24 Jun 2007 11:01:11 +0200 (MEST)
Message-ID: <200706240901.l5O91BK2025032@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:53098 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316AbXFXJJD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Jun 2007 05:09:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: eyal@eyal.emu.id.au, jeff@garzik.org
Cc: linux-ide@vger.kernel.org

On Sun, 24 Jun 2007 10:54:56 +1000, Eyal Lebedinsky wrote:
> Jeff Garzik wrote:
> [trim]
> > Given that some drives might be better tuned for benchmarks in
> > non-queued mode, and that a major behavior difference is that your
> > drives are now NCQ-enabled, the first thing I would suggest you try is
> > disabling NCQ:
> >     http://linux-ata.org/faq.html#ncq
> 
> I see in my bootup messages:
> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
> ata6.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/1)
> ata6.00: configured for UDMA/133
> 
> and I wonder how to interpret "NCQ (depth 0/1)". Does this drive
> support NCQ or not?
> 
> Controller:	Promise SATA-II-150-TX4.
> Kernel:		2.6.21.5, x86

Your drive does, but the driver for your controller does not (yet).

/Mikael
