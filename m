From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.31] sata_promise: update reset code
Date: Tue, 15 Sep 2009 15:08:47 +0200
Message-ID: <19119.37343.976763.528719@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:43051 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbZION17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Sep 2009 09:27:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

sata_promise's reset code has deviated quite a bit from
the Promise reference driver's, and it has been observed
to fail to recover from errors in some cases.

This patch thus updates the reset code to more closely
match the reference driver:

- soft reset (pdc_reset_port):
  * wait for ATA engine to not be in packet command mode
    (2nd gen only)
  * write reset bit in PDC_CTLSTAT before the first read
    in the loop
  * for 2nd gen SATA follow up with FPDMA reset and clearing
    error status registers
- hard reset (pdc_sata_hardreset):
  * wait for ATA engine to not be in packet command mode
    (2nd gen only)
  * reset ATA engine via the PCI control register
  * Tejun's change to use non-waiting hardreset + follow-up SRST

I'm not changing the hotplug mask bits since they are taken care
of by sata_promise's ->freeze() and ->thaw() operations. And I'm
not writing the PMP port # because that's always zero (for now).

Tested here on various controllers. In particular, one disk
which used to timeout and fail to recover from certain hdparm
and smartmonctl commands now works nicely.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
I should have submitted this long ago, sorry.
This update involves a lot of details, so it should probably sit
in a testing tree for a while before going upstream.

 drivers/ata/sata_promise.c |  121 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff -rupN linux-2.6.31/drivers/ata/sata_promise.c linux-2.6.31.sata_promise-reset-updates-v1/drivers/ata/sata_promise.c
--- linux-2.6.31/drivers/ata/sata_promise.c	2009-06-10 12:00:44.000000000 +0200
+++ linux-2.6.31.sata_promise-reset-updates-v1/drivers/ata/sata_promise.c	2009-09-10 14:07:59.000000000 +0200
@@ -56,6 +56,7 @@ enum {
 	/* host register offsets (from host->iomap[PDC_MMIO_BAR]) */
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
 	PDC_FLASH_CTL		= 0x44, /* Flash control register */
+	PDC_PCI_CTL		= 0x48, /* PCI control/status reg */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
 	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
 	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
@@ -75,7 +76,17 @@ enum {
 	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
 
 	/* per-port SATA register offsets (from ap->ioaddr.scr_addr) */
+	PDC_SATA_ERROR		= 0x04,
 	PDC_PHYMODE4		= 0x14,
+	PDC_LINK_LAYER_ERRORS	= 0x6C,
+	PDC_FPDMA_CTLSTAT	= 0xD8,
+	PDC_INTERNAL_DEBUG_1	= 0xF8,	/* also used for PATA */
+	PDC_INTERNAL_DEBUG_2	= 0xFC,	/* also used for PATA */
+
+	/* PDC_FPDMA_CTLSTAT bit definitions */
+	PDC_FPDMA_CTLSTAT_RESET			= 1 << 3,
+	PDC_FPDMA_CTLSTAT_DMASETUP_INT_FLAG	= 1 << 10,
+	PDC_FPDMA_CTLSTAT_SETDB_INT_FLAG	= 1 << 11,
 
 	/* PDC_GLOBAL_CTL bit definitions */
 	PDC_PH_ERR		= (1 <<  8), /* PCI error while loading packet */
@@ -356,12 +367,76 @@ static int pdc_sata_port_start(struct at
 	return 0;
 }
 
+static void pdc_fpdma_clear_interrupt_flag(struct ata_port *ap)
+{
+	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
+	u32 tmp;
+
+	tmp = readl(sata_mmio + PDC_FPDMA_CTLSTAT);
+	tmp |= PDC_FPDMA_CTLSTAT_DMASETUP_INT_FLAG;
+	tmp |= PDC_FPDMA_CTLSTAT_SETDB_INT_FLAG;
+
+	/* It's not allowed to write to the entire FPDMA_CTLSTAT register
+	   when NCQ is running. So do a byte-sized write to bits 10 and 11. */
+	writeb(tmp >> 8, sata_mmio + PDC_FPDMA_CTLSTAT + 1);
+	readb(sata_mmio + PDC_FPDMA_CTLSTAT + 1); /* flush */
+}
+
+static void pdc_fpdma_reset(struct ata_port *ap)
+{
+	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
+	u8 tmp;
+
+	tmp = (u8)readl(sata_mmio + PDC_FPDMA_CTLSTAT);
+	tmp &= 0x7F;
+	tmp |= PDC_FPDMA_CTLSTAT_RESET;
+	writeb(tmp, sata_mmio + PDC_FPDMA_CTLSTAT);
+	readl(sata_mmio + PDC_FPDMA_CTLSTAT); /* flush */
+	udelay(100);
+	tmp &= ~PDC_FPDMA_CTLSTAT_RESET;
+	writeb(tmp, sata_mmio + PDC_FPDMA_CTLSTAT);
+	readl(sata_mmio + PDC_FPDMA_CTLSTAT); /* flush */
+
+	pdc_fpdma_clear_interrupt_flag(ap);
+}
+
+static void pdc_not_at_command_packet_phase(struct ata_port *ap)
+{
+	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
+	unsigned int i;
+	u32 tmp;
+
+	/* check not at ASIC packet command phase */
+	for (i = 0; i < 100; ++i) {
+		writel(0, sata_mmio + PDC_INTERNAL_DEBUG_1);
+		tmp = readl(sata_mmio + PDC_INTERNAL_DEBUG_2);
+		if ((tmp & 0xF) != 1)
+			break;
+		udelay(100);
+	}
+}
+
+static void pdc_clear_internal_debug_record_error_register(struct ata_port *ap)
+{
+	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
+
+	writel(0xffffffff, sata_mmio + PDC_SATA_ERROR);
+	writel(0xffff0000, sata_mmio + PDC_LINK_LAYER_ERRORS);
+}
+
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *ata_ctlstat_mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
 	unsigned int i;
 	u32 tmp;
 
+	if (ap->flags & PDC_FLAG_GEN_II)
+		pdc_not_at_command_packet_phase(ap);
+
+	tmp = readl(ata_ctlstat_mmio);
+	tmp |= PDC_RESET;
+	writel(tmp, ata_ctlstat_mmio);
+
 	for (i = 11; i > 0; i--) {
 		tmp = readl(ata_ctlstat_mmio);
 		if (tmp & PDC_RESET)
@@ -376,6 +451,11 @@ static void pdc_reset_port(struct ata_po
 	tmp &= ~PDC_RESET;
 	writel(tmp, ata_ctlstat_mmio);
 	readl(ata_ctlstat_mmio);	/* flush */
+
+	if (sata_scr_valid(&ap->link) && (ap->flags & PDC_FLAG_GEN_II)) {
+		pdc_fpdma_reset(ap);
+		pdc_clear_internal_debug_record_error_register(ap);
+	}
 }
 
 static int pdc_pata_cable_detect(struct ata_port *ap)
@@ -708,11 +788,50 @@ static int pdc_pata_softreset(struct ata
 	return ata_sff_softreset(link, class, deadline);
 }
 
+static unsigned int pdc_ata_port_to_ata_no(const struct ata_port *ap)
+{
+	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
+	void __iomem *host_mmio = ap->host->iomap[PDC_MMIO_BAR];
+
+	/* ata_mmio == host_mmio + 0x200 + ata_no * 0x80 */
+	return (ata_mmio - host_mmio - 0x200) / 0x80;
+}
+
+static void pdc_hard_reset_port(struct ata_port *ap)
+{
+	void __iomem *host_mmio = ap->host->iomap[PDC_MMIO_BAR];
+	void __iomem *pcictl_b1_mmio = host_mmio + PDC_PCI_CTL + 1;
+	unsigned int ata_no = pdc_ata_port_to_ata_no(ap);
+	u8 tmp;
+
+	spin_lock(&ap->host->lock);
+
+	tmp = readb(pcictl_b1_mmio);
+	tmp &= ~(0x10 << ata_no);
+	writeb(tmp, pcictl_b1_mmio);
+	readb(pcictl_b1_mmio); /* flush */
+	udelay(100);
+	tmp |= (0x10 << ata_no);
+	writeb(tmp, pcictl_b1_mmio);
+	readb(pcictl_b1_mmio); /* flush */
+
+	spin_unlock(&ap->host->lock);
+}
+
 static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline)
 {
+	if (link->ap->flags & PDC_FLAG_GEN_II)
+		pdc_not_at_command_packet_phase(link->ap);
+	/* hotplug IRQs should have been masked by pdc_sata_freeze() */
+	pdc_hard_reset_port(link->ap);
 	pdc_reset_port(link->ap);
-	return sata_sff_hardreset(link, class, deadline);
+
+	/* sata_promise can't reliably acquire the first D2H Reg FIS
+	 * after hardreset.  Do non-waiting hardreset and request
+	 * follow-up SRST.
+	 */
+	return sata_std_hardreset(link, class, deadline);
 }
 
 static void pdc_error_handler(struct ata_port *ap)
