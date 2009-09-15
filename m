From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.31] sata_promise: disable hotplug on 1st gen chips
Date: Tue, 15 Sep 2009 15:07:32 +0200
Message-ID: <19119.37268.448603.191642@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:43041 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbZION17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Sep 2009 09:27:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kurt Roeckx <kurt@roeckx.be>, linux-ide@vger.kernel.org

1st generation Promise SATA chips are prone to generating spurious
hotplug events which can disrupt normal operation. This has been
observed on 20376 and 20378 chips. This patch thus disables hotplug
support on 1st gen chips while leaving it enabled for 2nd gen chips.

The pdc_sata_hotplug_offset() function becomes redundant so it is
removed.

Tested on 1st gen 20376 and 20378 mainboard chips and on a 2nd gen
SATA300 PCI card.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
Tested-by: Kurt Roeckx <kurt@roeckx.be>
---
Kurt: you tested this so I added your Tested-by, I hope that's Ok?
Jeff: this is a safe patch that I think should go to -stable soonish

 drivers/ata/sata_promise.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff -rupN linux-2.6.31/drivers/ata/sata_promise.c linux-2.6.31.sata_promise-disable-gen1-hotplug/drivers/ata/sata_promise.c
--- linux-2.6.31/drivers/ata/sata_promise.c	2009-06-10 12:00:44.000000000 +0200
+++ linux-2.6.31.sata_promise-disable-gen1-hotplug/drivers/ata/sata_promise.c	2009-09-10 14:07:17.000000000 +0200
@@ -195,9 +195,12 @@ static struct ata_port_operations pdc_sa
 	.hardreset		= pdc_sata_hardreset,
 };
 
-/* First-generation chips need a more restrictive ->check_atapi_dma op */
+/* First-generation chips need a more restrictive ->check_atapi_dma op,
+   and ->freeze/thaw that ignore the hotplug controls. */
 static struct ata_port_operations pdc_old_sata_ops = {
 	.inherits		= &pdc_sata_ops,
+	.freeze			= pdc_freeze,
+	.thaw			= pdc_thaw,
 	.check_atapi_dma	= pdc_old_sata_check_atapi_dma,
 };
 
@@ -626,11 +629,6 @@ static unsigned int pdc_sata_ata_port_to
 	return pdc_port_no_to_ata_no(i, pdc_is_sataii_tx4(ap->flags));
 }
 
-static unsigned int pdc_sata_hotplug_offset(const struct ata_port *ap)
-{
-	return (ap->flags & PDC_FLAG_GEN_II) ? PDC2_SATA_PLUG_CSR : PDC_SATA_PLUG_CSR;
-}
-
 static void pdc_freeze(struct ata_port *ap)
 {
 	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
@@ -647,7 +645,7 @@ static void pdc_sata_freeze(struct ata_p
 {
 	struct ata_host *host = ap->host;
 	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
-	unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
+	unsigned int hotplug_offset = PDC2_SATA_PLUG_CSR;
 	unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
 	u32 hotplug_status;
 
@@ -685,7 +683,7 @@ static void pdc_sata_thaw(struct ata_por
 {
 	struct ata_host *host = ap->host;
 	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
-	unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
+	unsigned int hotplug_offset = PDC2_SATA_PLUG_CSR;
 	unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
 	u32 hotplug_status;
 
@@ -832,14 +830,14 @@ static irqreturn_t pdc_interrupt(int irq
 	spin_lock(&host->lock);
 
 	/* read and clear hotplug flags for all ports */
-	if (host->ports[0]->flags & PDC_FLAG_GEN_II)
+	if (host->ports[0]->flags & PDC_FLAG_GEN_II) {
 		hotplug_offset = PDC2_SATA_PLUG_CSR;
-	else
-		hotplug_offset = PDC_SATA_PLUG_CSR;
-	hotplug_status = readl(host_mmio + hotplug_offset);
-	if (hotplug_status & 0xff)
-		writel(hotplug_status | 0xff, host_mmio + hotplug_offset);
-	hotplug_status &= 0xff;	/* clear uninteresting bits */
+		hotplug_status = readl(host_mmio + hotplug_offset);
+		if (hotplug_status & 0xff)
+			writel(hotplug_status | 0xff, host_mmio + hotplug_offset);
+		hotplug_status &= 0xff;	/* clear uninteresting bits */
+	} else
+		hotplug_status = 0;
 
 	/* reading should also clear interrupts */
 	mask = readl(host_mmio + PDC_INT_SEQMASK);
@@ -1034,9 +1032,11 @@ static void pdc_host_init(struct ata_hos
 	tmp = readl(host_mmio + hotplug_offset);
 	writel(tmp | 0xff, host_mmio + hotplug_offset);
 
-	/* unmask plug/unplug ints */
 	tmp = readl(host_mmio + hotplug_offset);
-	writel(tmp & ~0xff0000, host_mmio + hotplug_offset);
+	if (is_gen2)	/* unmask plug/unplug ints */
+		writel(tmp & ~0xff0000, host_mmio + hotplug_offset);
+	else		/* mask plug/unplug ints */
+		writel(tmp | 0xff0000, host_mmio + hotplug_offset);
 
 	/* don't initialise TBG or SLEW on 2nd generation chips */
 	if (is_gen2)
