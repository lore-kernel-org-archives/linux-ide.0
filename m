From: Mikael Pettersson <mikpe@it.uu.se>
Subject: sata_promise: preliminary hotplug support
Date: Mon, 18 Jun 2007 00:44:22 +0200 (MEST)
Message-ID: <200706172244.l5HMiM61028370@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:58163 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbXFQWob (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Jun 2007 18:44:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This crude but simple patch enables hotplugging of SATA
disks in the sata_promise driver. Tested successfully on
SATAII150 TX2plus, SATA300 TX2plus, and SATA300 TX4.
The TX4 is significant because of the port_nr-to-ata_nr
remapping that occurs for those chips, which affects
the hotplug status change check for a given port.

While this patch works for me, I consider it preliminary
because it duplicates code and open-codes stuff, so some
cleanups are certainly needed. Also I haven't been able
to test it on first-generation chips yet.

The hotplug checks are high up in the interrupt handling
path, not deep down in error_intr as in ahci/sata_sil24.
That's because the chip doesn't signal hotplug status changes
in the per-port status register: instead a global register
contains hotplug control and status flags for all ports.
I considered following the ahci/sata_sil24 structure, but
that would have required non-trivial changes to the interrupt
handling path, so I chose to keep the hotplug changes simple
and unobtrusive.

/Mikael

(not a formal patch submission, hence no signed-off line)

--- linux-2.6.22-rc5/drivers/ata/sata_promise.c.~1~	2007-06-17 22:03:46.000000000 +0200
+++ linux-2.6.22-rc5/drivers/ata/sata_promise.c	2007-06-17 23:43:51.000000000 +0200
@@ -709,6 +709,9 @@
 	unsigned int i, tmp;
 	unsigned int handled = 0;
 	void __iomem *mmio_base;
+	unsigned int hotplug_offset;
+	u32 hotplug_status;
+	int is_sataii_tx4;
 
 	VPRINTK("ENTER\n");
 
@@ -719,10 +722,22 @@
 
 	mmio_base = host->iomap[PDC_MMIO_BAR];
 
+	/* read and clear hotplug flags for all ports */
+	if (host->ports[0]->flags & PDC_FLAG_GEN_II)
+		hotplug_offset = PDC2_SATA_PLUG_CSR;
+	else
+		hotplug_offset = PDC_SATA_PLUG_CSR;
+	hotplug_status = readl(mmio_base + hotplug_offset);
+	if (hotplug_status & 0xff) {
+		writel(hotplug_status | 0xff, mmio_base + hotplug_offset);
+		printk("%s: hotplug_status %#x\n", __FUNCTION__, hotplug_status);
+	}
+	hotplug_status &= 0xff;	/* clear uninteresting bits */
+
 	/* reading should also clear interrupts */
 	mask = readl(mmio_base + PDC_INT_SEQMASK);
 
-	if (mask == 0xffffffff) {
+	if (mask == 0xffffffff && hotplug_status == 0) {
 		VPRINTK("QUICK EXIT 2\n");
 		return IRQ_NONE;
 	}
@@ -730,16 +745,39 @@
 	spin_lock(&host->lock);
 
 	mask &= 0xffff;		/* only 16 tags possible */
-	if (!mask) {
+	if (!mask && hotplug_status == 0) {
 		VPRINTK("QUICK EXIT 3\n");
 		goto done_irq;
 	}
 
 	writel(mask, mmio_base + PDC_INT_SEQMASK);
 
+	/* XXX: ugly ugly ugly */
+	is_sataii_tx4 = 0;
+	if ((host->ports[0]->flags & (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS)) ==
+	    (PDC_FLAG_GEN_II|PDC_FLAG_4_PORTS))
+		is_sataii_tx4 = 1;
+
 	for (i = 0; i < host->n_ports; i++) {
 		VPRINTK("port %u\n", i);
 		ap = host->ports[i];
+		{
+			static const unsigned char sataii_tx4_port_remap[4] = { 3, 1, 0, 2};
+			int ata_nr = i;
+
+			if (is_sataii_tx4)
+				ata_nr = sataii_tx4_port_remap[i];
+
+			if ((hotplug_status & (0x11 << ata_nr)) && ap &&
+			    !(ap->flags & ATA_FLAG_DISABLED)) {
+				struct ata_eh_info *ehi = &ap->eh_info;
+				ata_ehi_clear_desc(ehi);
+				ata_ehi_hotplugged(ehi);
+				ata_ehi_push_desc(ehi, "hotplug_status %#x", hotplug_status);
+				ata_port_freeze(ap);
+				continue;
+			}
+		}
 		tmp = mask & (1 << (i + 1));
 		if (tmp && ap &&
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
@@ -897,9 +935,9 @@
 	tmp = readl(mmio + hotplug_offset);
 	writel(tmp | 0xff, mmio + hotplug_offset);
 
-	/* mask plug/unplug ints */
+	/* unmask plug/unplug ints */
 	tmp = readl(mmio + hotplug_offset);
-	writel(tmp | 0xff0000, mmio + hotplug_offset);
+	writel(tmp & ~0xff0000, mmio + hotplug_offset);
 
 	/* don't initialise TBG or SLEW on 2nd generation chips */
 	if (is_gen2)
