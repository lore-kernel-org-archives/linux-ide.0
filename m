From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.26-rc2 1/3] sata_promise: fix irq clearing buglets
Date: Wed, 21 May 2008 10:23:14 +0200
Message-ID: <18483.56306.270972.790619@harpo.it.uu.se>
References: <200805171647.m4HGlZFW015961@harpo.it.uu.se>
	<4831F488.9070802@garzik.org>
	<18482.36979.487666.133247@harpo.it.uu.se>
	<48333F60.8050508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:47690 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbYEUIXf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 May 2008 04:23:35 -0400
In-Reply-To: <48333F60.8050508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > Jeff Garzik writes:
 > >  > Mikael Pettersson wrote:
 > >  > > This patch fixes two bugs in sata_promise's irq status clearing paths:
 > >  > > 1. When clearing the irq status for a specific port, the driver
 > >  > >    read the global SEQMASK register. This is wrong because that
 > >  > >    clears the irq status for _all_ ports.
 > >  > > 2. pdc_thaw() incorrectly added the PDC_INT_SEQMASK host register
 > >  > >    offset to a per-port ata engine base address. This resulted in
 > >  > >    it reading the unrelated PDC_PKT_SUBMIT register, which did not
 > >  > >    have the desired irq status clearing effect.
 > >  > > 
 > >  > > In both cases the fix is to read from the port's Command/Status
 > >  > > register. This also matches what Promise's own driver does.
 > >  > > 
 > >  > > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
 > >  > > ---
 > >  > >  drivers/ata/sata_promise.c |    7 +++----
 > >  > >  1 file changed, 3 insertions(+), 4 deletions(-)
 > >  > 
 > >  > is sata_sx4 similarly affected?
 > > 
 > > For issue 2, pdc_thaw(), the answer is No since that's
 > > a sata_promise only thing I added as part of new-EH.
 > 
 > probably relevant to libata-dev.git#new-eh which contains the sata_sx4 
 > new-eh conversion.

I forgot about that branch. I'll check it out later today.

 > 
 > > For ->irq_clear() I'll have to check. I'll do that
 > > this evening and let you know tomorrow.
 > 
 > 
 > Thanks,

Based on the pdc20261 programming guide (SX4 has SEQMASK and
ATA Control/Status just like the TX chips), and that sata_sx4
calls ata_wait_idle() to "get drive status, clear intr", it
appears that sata_sx4's ->clear_irq() needs to be fixed to
read the port's ATA Control/Status not the hosts' SEQMASK.
Otherwise ->clear_irq(ap) will affect _all_ ports.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Compile-tested only.

--- linux-2.6.26-rc3/drivers/ata/sata_sx4.c.~1~	2008-05-19 20:36:50.000000000 +0200
+++ linux-2.6.26-rc3/drivers/ata/sata_sx4.c	2008-05-21 10:00:23.000000000 +0200
@@ -786,12 +786,7 @@ static inline unsigned int pdc20621_host
 
 static void pdc20621_irq_clear(struct ata_port *ap)
 {
-	struct ata_host *host = ap->host;
-	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
-
-	mmio += PDC_CHIP0_OFS;
-
-	readl(mmio + PDC_20621_SEQMASK);
+	ioread8(ap->ioaddr.status_addr);
 }
 
 static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
