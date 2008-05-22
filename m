From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.26-rc2 1/3] sata_promise: fix irq clearing buglets
Date: Thu, 22 May 2008 10:29:24 +0200
Message-ID: <18485.12004.632683.959582@harpo.it.uu.se>
References: <200805171647.m4HGlZFW015961@harpo.it.uu.se>
	<4831F488.9070802@garzik.org>
	<18482.36979.487666.133247@harpo.it.uu.se>
	<48333F60.8050508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:36437 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935245AbYEVIb0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 May 2008 04:31:26 -0400
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

pdc_thaw() in the libata#new-eh version of sata_sx4.c wants to
clear a single port's IRQ status, but reads the host's SEQMASK
register which affects all ports.

Fix by reading the port's Command/Status register instead.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Compile-tested only.

--- linux-2.6.26-rc3.libata#new-eh/drivers/ata/sata_sx4.c.~1~	2008-05-21 10:38:01.000000000 +0200
+++ linux-2.6.26-rc3.libata#new-eh/drivers/ata/sata_sx4.c	2008-05-22 09:54:07.000000000 +0200
@@ -872,14 +872,12 @@ static void pdc_freeze(struct ata_port *
 static void pdc_thaw(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.cmd_addr;
-	void __iomem *mmio_base;
 	u32 tmp;
 
 	/* FIXME: this should handle HDMA copy engine thawing */
 
-	/* reading SEQ mask register clears IRQ */
-	mmio_base = ap->host->iomap[PDC_MMIO_BAR] + PDC_CHIP0_OFS;
-	readl(mmio_base + PDC_20621_SEQMASK);
+	/* clear IRQ */
+	ioread8(ap->ioaddr.status_addr);
 
 	/* turn IRQ back on */
 	tmp = readl(mmio + PDC_CTLSTAT);
