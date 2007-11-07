From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 4/4] libata sata_qstor conversion to new error handling (EH).
Date: Wed, 07 Nov 2007 10:54:15 -0500
Message-ID: <4731DFA7.8010202@rtr.ca>
References: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1586 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbXKGPyQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 10:54:16 -0500
In-Reply-To: <4731DF06.3050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_qstor conversion to new error handling (EH).

Convert sata_qstor to use the newer libata EH mechanisms.
Based on earlier work by Jeff Garzik.

This belongs in 2.6.24.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_qstor.c	2007-11-07 09:17:41.000000000 -0500
+++ linux/drivers/ata/sata_qstor.c	2007-11-07 10:28:08.000000000 -0500
@@ -116,14 +116,15 @@
 static int qs_ata_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int qs_port_start(struct ata_port *ap);
 static void qs_host_stop(struct ata_host *host);
-static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
 static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_irq_clear(struct ata_port *ap);
-static void qs_eng_timeout(struct ata_port *ap);
+static void qs_freeze(struct ata_port *ap);
+static void qs_thaw(struct ata_port *ap);
+static void qs_error_handler(struct ata_port *ap);
 
 static struct scsi_host_template qs_ata_sht = {
 	.module			= THIS_MODULE,
@@ -150,11 +151,12 @@
 	.check_atapi_dma	= qs_check_atapi_dma,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= qs_phy_reset,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
 	.data_xfer		= ata_data_xfer,
-	.eng_timeout		= qs_eng_timeout,
+	.freeze			= qs_freeze,
+	.thaw			= qs_thaw,
+	.error_handler		= qs_error_handler,
 	.irq_clear		= qs_irq_clear,
 	.irq_on			= ata_irq_on,
 	.scr_read		= qs_scr_read,
@@ -169,8 +171,6 @@
 	/* board_2068_idx */
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET |
-				  //FIXME ATA_FLAG_SRST |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= ATA_UDMA6,
@@ -235,16 +235,28 @@
 	qs_enter_reg_mode(ap);
 }
 
-static void qs_phy_reset(struct ata_port *ap)
+static void qs_freeze(struct ata_port *ap)
 {
-	qs_reset_channel_logic(ap);
-	sata_phy_reset(ap);
+	u8 __iomem *mmio_base = qs_mmio_base(ap->host);
+
+	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
+	qs_enter_reg_mode(ap);
 }
 
-static void qs_eng_timeout(struct ata_port *ap)
+static void qs_thaw(struct ata_port *ap)
 {
+	u8 __iomem *mmio_base = qs_mmio_base(ap->host);
+
+	qs_enter_reg_mode(ap);
+	writeb(1, mmio_base + QS_HCT_CTRL); /* enable host interrupts */
+}
+
+static int qs_prereset(struct ata_link *link, unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+
 	qs_reset_channel_logic(ap);
-	ata_eng_timeout(ap);
+	return ata_std_prereset(link, deadline);
 }
 
 static int qs_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
@@ -255,6 +267,13 @@
 	return 0;
 }
 
+static void qs_error_handler(struct ata_port *ap)
+{
+	qs_enter_reg_mode(ap);
+	ata_do_eh(ap, qs_prereset, ata_std_softreset, NULL,
+		  ata_std_postreset);
+}
+
 static int qs_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -353,7 +372,6 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-
 		pp->state = qs_state_pkt;
 		qs_packet_start(qc);
 		return 0;
@@ -370,6 +388,26 @@
 	return ata_qc_issue_prot(qc);
 }
 
+static void qs_do_or_die(struct ata_queued_cmd *qc, u8 status)
+{
+	qc->err_mask |= ac_err_mask(status);
+
+	if (!qc->err_mask) {
+		ata_qc_complete(qc);
+	} else {
+		struct ata_port    *ap  = qc->ap;
+		struct ata_eh_info *ehi = &ap->link.eh_info;
+
+		ata_ehi_clear_desc(ehi);
+		ata_ehi_push_desc(ehi, "status 0x%02X", status);
+
+		if (qc->err_mask == AC_ERR_DEV)
+			ata_port_abort(ap);
+		else
+			ata_port_freeze(ap);
+	}
+}
+
 static inline unsigned int qs_intr_pkt(struct ata_host *host)
 {
 	unsigned int handled = 0;
@@ -402,8 +440,7 @@
 					case 0: /* successful CPB */
 					case 3: /* device error */
 						qs_enter_reg_mode(qc->ap);
-						qc->err_mask |= ac_err_mask(sDST);
-						ata_qc_complete(qc);
+						qs_do_or_die(qc, sDST);
 						break;
 					default:
 						break;
