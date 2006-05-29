From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/13] ahci: convert to new probing mechanism and add hotplug support
Date: Mon, 29 May 2006 15:38:56 +0900
Message-ID: <11488847362303-git-send-email-htejun@gmail.com>
References: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:36544 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751311AbWE2GjW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:22 -0400
Received: by wr-out-0506.google.com with SMTP id i7so819183wra
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:21 -0700 (PDT)
In-Reply-To: <11488847352050-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new probing mechanism and add hotplug support by enabling
PORT_IRQ_PHYRDY, marking ehi for hotplug and scheduling EH on
CONNECT/PHYRDY interrupts.

Unfortunately, ahci cannot reliably wait for the first FIS34 after
hotplug.  It sometimes succeeds but times out more often than not, so
ATA_FLAG_CANT_WAIT_FIS34 is used.

This patch also fixes ahci_hardreset() such that D2H Register FIS RX
area is cleared before issuing COMRESET.  Without this,
ata_busy_sleep() after COMRESET might prematually finish if the
previous TF contains DRDY && !BSY.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   47 +++++++++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 20 deletions(-)

8cf0cb52955e53d055c16c85b648c5b9b9ef2679
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 60f455b..1fd1aa0 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -136,6 +136,7 @@ enum {
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
 				  PORT_IRQ_CONNECT |
+				  PORT_IRQ_PHYRDY |
 				  PORT_IRQ_UNK_FIS,
 	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
 				  PORT_IRQ_TF_ERR |
@@ -200,7 +201,6 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
@@ -241,8 +241,6 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
-	.probe_reset		= ahci_probe_reset,
-
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -267,7 +265,8 @@ static const struct ata_port_info ahci_p
 	{
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_SKIP_D2H_BSY,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -277,6 +276,7 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_SKIP_D2H_BSY |
 				  AHCI_FLAG_RESET_NEEDS_CLO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -569,6 +569,17 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
+static int ahci_prereset(struct ata_port *ap)
+{
+	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
+	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
+		/* ATA_BUSY hasn't cleared, so send a CLO */
+		ahci_clo(ap);
+	}
+
+	return ata_std_prereset(ap);
+}
+
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -678,12 +689,22 @@ static int ahci_softreset(struct ata_por
 
 static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 {
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+	struct ata_taskfile tf;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
 	ahci_stop_engine(ap);
+
+	/* clear D2H reception area to properly wait for FIS34 */
+	ata_tf_init(ap->device, &tf);
+	tf.command = 0xff;
+	ata_tf_to_fis(&tf, d2h_fis, 0);
+
 	rc = sata_std_hardreset(ap, class);
+
 	ahci_start_engine(ap);
 
 	if (rc == 0 && ata_port_online(ap))
@@ -714,19 +735,6 @@ static void ahci_postreset(struct ata_po
 	}
 }
 
-static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
-{
-	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
-	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
-		/* ATA_BUSY hasn't cleared, so send a CLO */
-		ahci_clo(ap);
-	}
-
-	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     ahci_softreset, ahci_hardreset,
-				     ahci_postreset, classes);
-}
-
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -839,8 +847,7 @@ static void ahci_error_intr(struct ata_p
 	}
 
 	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
-		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_SOFTRESET;
+		ata_ehi_hotplugged(ehi);
 		ata_ehi_push_desc(ehi, ", %s", irq_stat & PORT_IRQ_CONNECT ?
 			"connection status changed" : "PHY RDY changed");
 	}
@@ -1027,7 +1034,7 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
+	ata_do_eh(ap, ahci_prereset, ahci_softreset, ahci_hardreset,
 		  ahci_postreset);
 }
 
-- 
1.3.2


