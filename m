From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Sun, 9 Dec 2007 21:04:40 +0100
Message-ID: <20071209200440.GC13382@kernel.dk>
References: <fa.Fg53DJSEh/kZhf/uRCv9FYZsaSQ@ifi.uio.no> <fa.nPzIjJ2SchPb1LOa/dRWb/WyEZU@ifi.uio.no> <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org> <20071209190913.GB13382@kernel.dk> <475C48EE.8020701@pianoinflames.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:9101 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176AbXLIUEp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Dec 2007 15:04:45 -0500
Content-Disposition: inline
In-Reply-To: <475C48EE.8020701@pianoinflames.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marco Gatti <marco@pianoinflames.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>

On Sun, Dec 09 2007, Marco Gatti wrote:
> Jens Axboe schrieb:
> >
> >Was just thinking that, this should do the trick. If this works, then we
> >can look at whether this is a hardware or iommu or block bouncing
> >(unlikely, would affect more people) bug.
> >
> >diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> >index 4688dbf..cad3cbc 100644
> >--- a/drivers/ata/ahci.c
> >+++ b/drivers/ata/ahci.c
> >@@ -623,6 +623,9 @@ static void ahci_save_initial_config(struct pci_dev 
> >*pdev,
> > 	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
> > 	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
> > 
> >+	hpriv->saved_cap &= ~HOST_CAP_64;
> >+	cap &= ~HOST_CAP_64;
> >+
> > 	/* some chips have errata preventing 64bit use */
> > 	if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
> > 		dev_printk(KERN_INFO, &pdev->dev,
> >
> 
> Hello Jens,
> Thanks for help. I just applied the patch. Unfortunately it doesn't work.

Can you try and additionally boot with iommu=off as a boot parameter?

-- 
Jens Axboe

