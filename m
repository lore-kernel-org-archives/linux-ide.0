From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: DMA breakage in 2.6.29-rc*
Date: Sun, 1 Feb 2009 17:44:07 +0100
Message-ID: <200902011744.07794.bzolnier@gmail.com>
References: <1233294371.18767.23.camel@pasglop> <1233313678.18767.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:52167 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbZBARYV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:24:21 -0500
Received: by fxm13 with SMTP id 13so1064357fxm.13
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 09:24:18 -0800 (PST)
In-Reply-To: <1233313678.18767.25.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>


Hi,

On Friday 30 January 2009, Benjamin Herrenschmidt wrote:
> On Fri, 2009-01-30 at 16:46 +1100, Benjamin Herrenschmidt wrote:
> > Hi Bart !
> > 
> > On a bunch of pmac's, I'm getting lost interrupts when trying to do DMA
> > with ide hard disks (first time at boot when reading the partition
> > table). It then times out, reverts to PIO and boots fine.
> > 
> > Haven't had time to fully bisect yet, but it seem to be somewhere in the
> > pile of IDE patches (surprise :-) that went in around that time.
> > 
> > I'll dig more next week, but in the meantime, I though you may have a
> > possible candidate in mind.
> 
> Smells like the patch that popped up not long ago already (can't find
> the thread now) where you cleaned up the port registration and broke our
> trick of passing a different parent device than the one used for DMA or
> something like that ... that mixed with something not testing the dma

Yeah my bad, though thanks to Andreas Schwab it is fixed in -rc3.

> map results (probably my fault) and I think we are passing crap DMA
> addresses to the device.
> 
> I'll sort it out. I should be able to just add working dma ops to the
> macio_device, it's a lot easier now that ppc32 has the same dma ops
> structure in struct device as ppc64.

Would be great as I have completely no idea about this stuff.

While you are at DMA support and will be fixing/testing it anyway
you may try to remove long standing duplication/obfuscation:

	/* Those fields are duplicating what is in hwif. We currently
	 * can't use the hwif ones because of some assumptions that are
	 * beeing done by the generic code about the kind of dma controller
	 * and format of the dma table. This will have to be fixed though.
	 */
	volatile struct dbdma_regs __iomem *	dma_regs;
	struct dbdma_cmd*		dma_table_cpu;

What needs to be done is more-or-less:

- teaching pmac_ide_init_dma() about hwif->prd_max_{nents,size}
  and then converting it to use ide_allocate_dma_engine()

- pmif->dma_regs -> hwif->dma_base

- pmif->dma_table_cpu -> hwif->dmatable_cpu

- sticking ide_release_dma_engine() somewhere (it seems that
  pmac driver never frees DMA memory allocated currently)

Of course while the above would be a nice cleanup+fixup, making
the driver work comes first..

Thanks,
Bart
