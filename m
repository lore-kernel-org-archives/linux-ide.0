From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sata_promise: Switch to cable method, clean up some bits as
 a result
Date: Thu, 8 Mar 2007 23:06:47 +0000
Message-ID: <20070308230647.0cda2afc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54301 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030732AbXCHWDC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:03:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <number6@the-village.bc.nu>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_promise.c linux-2.6.21-rc3-mm2/drivers/ata/sata_promise.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_promise.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/sata_promise.c	2007-03-08 16:40:20.000000000 +0000
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.00"
+#define DRV_VERSION	"2.00ac1"
 
 
 enum {
@@ -131,7 +131,7 @@
 static void pdc_thaw(struct ata_port *ap);
 static void pdc_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
-
+static int pdc_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
 	.module			= THIS_MODULE,
@@ -166,6 +166,7 @@
 	.thaw			= pdc_thaw,
 	.error_handler		= pdc_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
+	.cable_detect		= pdc_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
@@ -374,18 +375,18 @@
 	readl(mmio);	/* flush */
 }
 
-static void pdc_pata_cbl_detect(struct ata_port *ap)
+static int pdc_cable_detect(struct ata_port *ap)
 {
 	u8 tmp;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
 
-	tmp = readb(mmio);
-
-	if (tmp & 0x01) {
-		ap->cbl = ATA_CBL_PATA40;
-		ap->udma_mask &= ATA_UDMA_MASK_40C;
-	} else
-		ap->cbl = ATA_CBL_PATA80;
+	if (!sata_scr_valid(ap)) {
+		tmp = readb(mmio);
+		if (tmp & 0x01)
+			return ATA_CBL_PATA40;
+		return ATA_CBL_PATA80;
+	}
+	return ATA_CBL_SATA;
 }
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
@@ -555,13 +556,6 @@
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
-static int pdc_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	if (!sata_scr_valid(ap))
-		pdc_pata_cbl_detect(ap);
-	return ata_std_prereset(ap, deadline);
-}
-
 static void pdc_error_handler(struct ata_port *ap)
 {
 	ata_reset_fn_t hardreset;
@@ -574,7 +568,7 @@
 		hardreset = sata_std_hardreset;
 
 	/* perform recovery */
-	ata_do_eh(ap, pdc_pre_reset, ata_std_softreset, hardreset,
+	ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
 		  ata_std_postreset);
 }
 
