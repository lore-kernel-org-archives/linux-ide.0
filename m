From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] TX4000 RAID and sata_promise
Date: Mon, 29 Aug 2005 05:10:49 -0400
Message-ID: <4312D119.40401@pobox.com>
References: <923172921.20050828173310@rccb.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070504030103020104060905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:53439 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750894AbVH2JLC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 05:11:02 -0400
In-Reply-To: <923172921.20050828173310@rccb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070504030103020104060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yuri Kirsanov wrote:
> Good day. I've tried latest kernel 2.6.13-rc7, TX4000 support seems to
> be in sata_promise already. After startup I see following in dmesg:
> 
> libata version 1.12 loaded.
> sata_promise version 1.02
> PCI: Found IRQ 5 for device 0000:01:09.0
> ata1: PATA max UDMA/133 cmd 0xCC81C200 ctl 0xCC81C238 bmdma 0x0 irq 5
> ata2: PATA max UDMA/133 cmd 0xCC81C280 ctl 0xCC81C2B8 bmdma 0x0 irq 5
> ata3: PATA max UDMA/133 cmd 0xCC81C300 ctl 0xCC81C338 bmdma 0x0 irq 5
> ata4: PATA max UDMA/133 cmd 0xCC81C380 ctl 0xCC81C3B8 bmdma 0x0 irq 5
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_promise
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_promise
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_promise
> ata4: no device found (phy stat 00000000)
> scsi3 : sata_promise

Well, sata_promise definitely should not be attempting to call 
sata_phy_reset(), since this is a PATA board.

Maybe the attached patch will help?

	Jeff



--------------070504030103020104060905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -79,7 +79,8 @@ static irqreturn_t pdc_interrupt (int ir
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
-static void pdc_phy_reset(struct ata_port *ap);
+static void pdc_pata_phy_reset(struct ata_port *ap);
+static void pdc_sata_phy_reset(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
@@ -106,19 +107,22 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.ordered_flush		= 1,
 };
 
-static struct ata_port_operations pdc_ata_ops = {
+static struct ata_port_operations pdc_sata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= pdc_phy_reset,
+
+	.phy_reset		= pdc_sata_phy_reset,
+
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
@@ -126,6 +130,27 @@ static struct ata_port_operations pdc_at
 	.host_stop		= ata_host_stop,
 };
 
+static struct ata_port_operations pdc_pata_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= pdc_tf_load_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= pdc_exec_command_mmio,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= pdc_pata_phy_reset,
+
+	.qc_prep		= pdc_qc_prep,
+	.qc_issue		= pdc_qc_issue_prot,
+	.eng_timeout		= pdc_eng_timeout,
+	.irq_handler		= pdc_interrupt,
+	.irq_clear		= pdc_irq_clear,
+
+	.port_start		= pdc_port_start,
+	.port_stop		= pdc_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
@@ -135,7 +160,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_ata_ops,
+		.port_ops	= &pdc_sata_ops,
 	},
 
 	/* board_20319 */
@@ -146,7 +171,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_ata_ops,
+		.port_ops	= &pdc_sata_ops,
 	},
 
 	/* board_20619 */
@@ -157,7 +182,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_ata_ops,
+		.port_ops	= &pdc_pata_ops,
 	},
 };
 
@@ -268,12 +293,23 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
-static void pdc_phy_reset(struct ata_port *ap)
+static void pdc_sata_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
 	sata_phy_reset(ap);
 }
 
+static void pdc_pata_phy_reset(struct ata_port *ap)
+{
+	/* FIXME: add cable detect.  Don't assume 40-pin cable */
+	ap->cbl = ATA_CBL_PATA40;
+	ap->udma_mask &= ATA_UDMA_MASK_40C;
+
+	pdc_reset_port(ap);
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
+
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)

--------------070504030103020104060905--
