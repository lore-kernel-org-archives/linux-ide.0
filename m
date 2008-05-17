From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.26-rc2 1/3] sata_promise: fix irq clearing buglets
Date: Sat, 17 May 2008 18:47:35 +0200 (MEST)
Message-ID: <200805171647.m4HGlZFW015961@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48795 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbYEQQrp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 12:47:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

This patch fixes two bugs in sata_promise's irq status clearing paths:
1. When clearing the irq status for a specific port, the driver
   read the global SEQMASK register. This is wrong because that
   clears the irq status for _all_ ports.
2. pdc_thaw() incorrectly added the PDC_INT_SEQMASK host register
   offset to a per-port ata engine base address. This resulted in
   it reading the unrelated PDC_PKT_SUBMIT register, which did not
   have the desired irq status clearing effect.

In both cases the fix is to read from the port's Command/Status
register. This also matches what Promise's own driver does.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -rupN linux-2.6.26-rc2/drivers/ata/sata_promise.c linux-2.6.26-rc2.sata_promise-irqclear/drivers/ata/sata_promise.c
--- linux-2.6.26-rc2/drivers/ata/sata_promise.c	2008-05-16 12:44:28.000000000 +0200
+++ linux-2.6.26-rc2.sata_promise-irqclear/drivers/ata/sata_promise.c	2008-05-17 15:02:01.000000000 +0200
@@ -663,7 +663,7 @@ static void pdc_thaw(struct ata_port *ap
 	u32 tmp;
 
 	/* clear IRQ */
-	readl(mmio + PDC_INT_SEQMASK);
+	readl(mmio + PDC_COMMAND);
 
 	/* turn IRQ back on */
 	tmp = readl(mmio + PDC_CTLSTAT);
@@ -781,10 +781,9 @@ static inline unsigned int pdc_host_intr
 
 static void pdc_irq_clear(struct ata_port *ap)
 {
-	struct ata_host *host = ap->host;
-	void __iomem *mmio = host->iomap[PDC_MMIO_BAR];
+	void __iomem *mmio = ap->ioaddr.cmd_addr;
 
-	readl(mmio + PDC_INT_SEQMASK);
+	readl(mmio + PDC_COMMAND);
 }
 
 static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
