From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [RFT] sata_promise: decode and report error reasons
Date: Thu, 1 Mar 2007 02:58:33 +0100 (MET)
Message-ID: <200703010158.l211wXPS012467@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:45039 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280AbXCAB6h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Feb 2007 20:58:37 -0500
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l211wXeh024019
	for <linux-ide@vger.kernel.org>; Thu, 1 Mar 2007 02:58:33 +0100 (MET)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l211wXPS012467
	for linux-ide@vger.kernel.org; Thu, 1 Mar 2007 02:58:33 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a preliminary patch to add error reason decoding
and reporting to sata_promise. It's fairly simplistic but
should log all error info the controller is able to provide.

Works for me, but my test rig hardly ever throws any errors.
Testing by those that experience frequent errors would be
most welcome.

libata experts may want to check if my mapping to libata
error codes and eh actions is OK.

/Mikael

--- linux-2.6.21-rc2/drivers/ata/sata_promise.c.~1~	2007-02-28 13:32:46.000000000 +0100
+++ linux-2.6.21-rc2/drivers/ata/sata_promise.c	2007-03-01 01:52:35.000000000 +0100
@@ -70,8 +70,37 @@ enum {
 	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
 	PDC_SLEW_CTL		= 0x470, /* slew rate control reg (not SATAII) */
 
-	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
-				  (1<<8) | (1<<9) | (1<<10),
+	/* PDC_GLOBAL_CTL bit definitions */
+	PDC_PH_ERR		= (1 << 8),
+	PDC_SH_ERR		= (1 << 9),
+	PDC_DH_ERR		= (1 << 10),
+	PDC2_HTO_ERR		= (1 << 12),
+	PDC2_ATA_HBA_ERR	= (1 << 13),
+	PDC2_ATA_DMA_CNT_ERR	= (1 << 14),
+	PDC_OVERRUN_ERR		= (1 << 19),
+	PDC_UNDERRUN_ERR	= (1 << 20),
+	PDC_DRIVE_ERR		= (1 << 21),
+	PDC_PCI_SYS_ERR		= (1 << 22),
+	PDC1_PCI_PARITY_ERR	= (1 << 23),	/* 1st gen only */
+	PDC1_ERR_MASK		= PDC1_PCI_PARITY_ERR,
+	PDC2_ERR_MASK		= PDC2_HTO_ERR | PDC2_ATA_HBA_ERR | PDC2_ATA_DMA_CNT_ERR,
+	PDC_ERR_MASK		= (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC_OVERRUN_ERR
+				   | PDC_UNDERRUN_ERR | PDC_DRIVE_ERR | PDC_PCI_SYS_ERR
+				   | PDC2_ERR_MASK | PDC1_ERR_MASK),
+
+	/* Promise-specific SError bit definitions */
+	PDC_SERR_COMWAKE	= (1 << 18),
+	PDC_SERR_10BTO8B	= (1 << 19),
+	PDC_SERR_DISPARITY	= (1 << 20),
+	PDC_SERR_CRC		= (1 << 21),
+	PDC_SERR_HANDSHAKE	= (1 << 22),
+	PDC_SERR_LINK_SEQ	= (1 << 23),
+	PDC2_SERR_STATE_TRANS	= (1 << 24),
+	PDC_SERR_FIS_TYPE	= (1 << 25),
+	PDC2_SERR_MASK		= PDC2_SERR_STATE_TRANS,
+	PDC_SERR_MASK		= (PDC_SERR_COMWAKE | PDC_SERR_10BTO8B | PDC_SERR_DISPARITY
+				   | PDC_SERR_CRC | PDC_SERR_HANDSHAKE | PDC_SERR_LINK_SEQ
+				   | PDC_SERR_FIS_TYPE | PDC2_SERR_MASK),
 
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
@@ -590,17 +619,67 @@ static void pdc_post_internal_cmd(struct
 		pdc_reset_port(ap);
 }
 
+static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc, u32 port_status)
+{
+	struct pdc_host_priv *hp = ap->host->private_data;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	unsigned int err_mask = 0, action = 0;
+	u32 serror;
+
+	ata_ehi_clear_desc(ehi);
+
+	serror = 0;
+	if (sata_scr_valid(ap)) {
+		serror = pdc_sata_scr_read(ap, SCR_ERROR);
+		if (!(hp->flags & PDC_FLAG_GEN_II))
+			serror &= ~PDC2_SERR_MASK;
+	}
+
+	printk("%s: port_status 0x%08x serror 0x%08x\n", __FUNCTION__, port_status, serror);
+
+	ata_ehi_push_desc(ehi, "port_status 0x%08x", port_status);
+
+	if (serror & PDC_SERR_MASK) {
+		err_mask |= AC_ERR_ATA_BUS;
+		ata_ehi_push_desc(ehi, ", serror 0x%08x", serror);
+	}
+	if (port_status & PDC_DRIVE_ERR)
+		err_mask |= AC_ERR_DEV;
+	if (port_status & PDC2_HTO_ERR)
+		err_mask |= AC_ERR_TIMEOUT;
+	if (port_status & (PDC_UNDERRUN_ERR | PDC_OVERRUN_ERR | PDC2_ATA_DMA_CNT_ERR
+			   | PDC2_ATA_HBA_ERR))
+		err_mask |= AC_ERR_ATA_BUS;
+	if (port_status & (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC_PCI_SYS_ERR
+			   | PDC1_PCI_PARITY_ERR))
+		err_mask |= AC_ERR_HOST_BUS;
+
+	action |= ATA_EH_SOFTRESET;
+
+	ehi->serror |= serror;
+	ehi->action |= action;
+
+	qc->err_mask |= err_mask;
+
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
+	u32 port_status;
 
-	tmp = readl(mmio);
-	if (tmp & PDC_ERR_MASK) {
-		qc->err_mask |= AC_ERR_DEV;
-		pdc_reset_port(ap);
+	port_status = readl(port_mmio + PDC_GLOBAL_CTL);
+	if (hp->flags & PDC_FLAG_GEN_II)
+		port_status &= ~PDC1_ERR_MASK;
+	else
+		port_status &= ~PDC2_ERR_MASK;
+	if (unlikely(port_status & PDC_ERR_MASK)) {
+		pdc_error_intr(ap, qc, port_status);
+		return 1;
 	}
 
 	switch (qc->tf.protocol) {
