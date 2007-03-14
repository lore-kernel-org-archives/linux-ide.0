From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH libata#upstream] sata_promise: decode and report error reasons
Date: Wed, 14 Mar 2007 09:51:35 +0100 (MET)
Message-ID: <200703140851.l2E8pZ8A006182@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:63386 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933884AbXCNIvq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 04:51:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This patch adds much needed error reason decoding and
reporting to sata_promise. It's simplistic but should
log all relevant error info the controller provides.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |   64 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 55 insertions(+), 9 deletions(-)

Changes since the preliminary version:
* dropped SError decoding, as all bits there are standard
* PDC2_HTO_ERR is mapped to AC_ERR_HOST_BUS not AC_ERR_TIMEOUT
* PDC_UNDERRUN_ERR and PDC_OVERRUN_ERR are mapped to AC_ERR_HSM
  not AC_ERR_ATA_BUS
* added brief explanations to error constant declarations
* some cleanups and simplifications

--- linux-2.6.21-rc3+upstream/drivers/ata/sata_promise.c.~1~	2007-03-13 23:41:43.000000000 +0100
+++ linux-2.6.21-rc3+upstream/drivers/ata/sata_promise.c	2007-03-14 00:48:49.000000000 +0100
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.03"
+#define DRV_VERSION	"2.04"
 
 
 enum {
@@ -70,8 +70,23 @@ enum {
 	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
 	PDC_SLEW_CTL		= 0x470, /* slew rate control reg (not SATAII) */
 
-	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
-				  (1<<8) | (1<<9) | (1<<10),
+	/* PDC_GLOBAL_CTL bit definitions */
+	PDC_PH_ERR		= (1 <<  8), /* PCI error while loading packet */
+	PDC_SH_ERR		= (1 <<  9), /* PCI error while loading S/G table */
+	PDC_DH_ERR		= (1 << 10), /* PCI error while loading data */
+	PDC2_HTO_ERR		= (1 << 12), /* host bus timeout */
+	PDC2_ATA_HBA_ERR	= (1 << 13), /* error during SATA DATA FIS transmission */
+	PDC2_ATA_DMA_CNT_ERR	= (1 << 14), /* DMA DATA FIS size differs from S/G count */
+	PDC_OVERRUN_ERR		= (1 << 19), /* S/G byte count larger than HD requires */
+	PDC_UNDERRUN_ERR	= (1 << 20), /* S/G byte count less than HD requires */
+	PDC_DRIVE_ERR		= (1 << 21), /* drive error */
+	PDC_PCI_SYS_ERR		= (1 << 22), /* PCI system error */
+	PDC1_PCI_PARITY_ERR	= (1 << 23), /* PCI parity error (from SATA150 driver) */
+	PDC1_ERR_MASK		= PDC1_PCI_PARITY_ERR,
+	PDC2_ERR_MASK		= PDC2_HTO_ERR | PDC2_ATA_HBA_ERR | PDC2_ATA_DMA_CNT_ERR,
+	PDC_ERR_MASK		= (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC_OVERRUN_ERR
+				   | PDC_UNDERRUN_ERR | PDC_DRIVE_ERR | PDC_PCI_SYS_ERR
+				   | PDC1_ERR_MASK | PDC2_ERR_MASK),
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
@@ -615,17 +630,48 @@ static void pdc_post_internal_cmd(struct
 		pdc_reset_port(ap);
 }
 
+static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc,
+			   u32 port_status, u32 err_mask)
+{
+	struct ata_eh_info *ehi = &ap->eh_info;
+	unsigned int ac_err_mask = 0;
+
+	ata_ehi_clear_desc(ehi);
+	ata_ehi_push_desc(ehi, "port_status 0x%08x", port_status);
+	port_status &= err_mask;
+
+	if (port_status & PDC_DRIVE_ERR)
+		ac_err_mask |= AC_ERR_DEV;
+	if (port_status & (PDC_OVERRUN_ERR | PDC_UNDERRUN_ERR))
+		ac_err_mask |= AC_ERR_HSM;
+	if (port_status & (PDC2_ATA_HBA_ERR | PDC2_ATA_DMA_CNT_ERR))
+		ac_err_mask |= AC_ERR_ATA_BUS;
+	if (port_status & (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC2_HTO_ERR
+			   | PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
+		ac_err_mask |= AC_ERR_HOST_BUS;
+
+	ehi->action |= ATA_EH_SOFTRESET;
+	qc->err_mask |= ac_err_mask;
+	ata_port_freeze(ap);
+}
+
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc)
 {
 	unsigned int handled = 0;
-	u32 tmp;
-	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
+	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
+	struct pdc_host_priv *hp = ap->host->private_data;
+	u32 port_status, err_mask;
 
-	tmp = readl(mmio);
-	if (tmp & PDC_ERR_MASK) {
-		qc->err_mask |= AC_ERR_DEV;
-		pdc_reset_port(ap);
+	err_mask = PDC_ERR_MASK;
+	if (hp->flags & PDC_FLAG_GEN_II)
+		err_mask &= ~PDC1_ERR_MASK;
+	else
+		err_mask &= ~PDC2_ERR_MASK;
+	port_status = readl(port_mmio + PDC_GLOBAL_CTL);
+	if (unlikely(port_status & err_mask)) {
+		pdc_error_intr(ap, qc, port_status, err_mask);
+		return 1;
 	}
 
 	switch (qc->tf.protocol) {
