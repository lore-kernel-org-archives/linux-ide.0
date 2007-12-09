From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Sun, 9 Dec 2007 20:09:14 +0100
Message-ID: <20071209190913.GB13382@kernel.dk>
References: <fa.Fg53DJSEh/kZhf/uRCv9FYZsaSQ@ifi.uio.no> <fa.nPzIjJ2SchPb1LOa/dRWb/WyEZU@ifi.uio.no> <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:16452 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbXLITJU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Dec 2007 14:09:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Marco Gatti <marco@pianoinflames.de>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>

On Sun, Dec 09 2007, Linus Torvalds wrote:
> 
> 
> On Sun, 9 Dec 2007, Robert Hancock wrote:
> > 
> > The obvious suspect with a filesystem problem would be the disk 
> > controller driver, AHCI here. However, the controller appears to set the 
> > flag to indicate that it supports 64-bit DMA, so it should be fine, 
> > unless it lies of course (which we know that ATI SB600 chipset does, but 
> > I don't believe Intel is known to).
> > 
> > Could still be a DMA mapping bug that only shows up when IOMMU is used. 
> > However, AHCI is a pretty well tested driver..
> 
> AHCI is a pretty well tested driver, but 99%+ of all testers still tend to 
> have less than 4GB of memory. So I do *not* believe that the highmem bits 
> are all that well tested at all. 
> 
> Can somebody who knows the driver send Marco a test-patch to just limit 
> DMA to the low 32 bits, and then Marco can at least verify that yes, that 
> that it. While it looks like DMA problems, there could obviously be some 
> other subtle issue with big-memory machines (ie the PCI allocations etc 
> tend to change too!)

Was just thinking that, this should do the trick. If this works, then we
can look at whether this is a hardware or iommu or block bouncing
(unlikely, would affect more people) bug.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4688dbf..cad3cbc 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -623,6 +623,9 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
 	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
 
+	hpriv->saved_cap &= ~HOST_CAP_64;
+	cap &= ~HOST_CAP_64;
+
 	/* some chips have errata preventing 64bit use */
 	if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
 		dev_printk(KERN_INFO, &pdev->dev,

-- 
Jens Axboe

