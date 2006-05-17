From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH, RFC] ahci: update interrupt path
Date: Tue, 16 May 2006 20:57:52 -0400
Message-ID: <20060517005752.GA14045@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:18614 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751020AbWEQA5x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 20:57:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Patch against current #upstream.  Not yet committed.

Changes:
* Drop PORT_IRQ_SG_DONE from IRQ mask.
* Drop spurious interrupt code.
* Add two events to hotplug event list; in theory, 
  debounce should sort it all out.
* Catch two other unhandled exceptions (overflow, bad PMP)


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..2a52a3d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -140,9 +140,13 @@ enum {
 	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
 				  PORT_IRQ_TF_ERR |
 				  PORT_IRQ_HBUS_DATA_ERR,
-	DEF_PORT_IRQ		= PORT_IRQ_ERROR | PORT_IRQ_SG_DONE |
+	DEF_PORT_IRQ		= PORT_IRQ_ERROR |
 				  PORT_IRQ_SDB_FIS | PORT_IRQ_DMAS_FIS |
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
+	PORT_IRQ_PLUG_EV	= PORT_IRQ_COLD_PRES | PORT_IRQ_PHYRDY |
+				  PORT_IRQ_DEV_ILCK | PORT_IRQ_CONNECT,
+	PORT_IRQ_ALL_EV		= PORT_IRQ_ERROR | PORT_IRQ_PLUG_EV |
+				  PORT_IRQ_OVERFLOW | PORT_IRQ_BAD_PMP,
 
 	/* PORT_CMD bits */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
@@ -837,11 +841,24 @@ static void ahci_error_intr(struct ata_p
 		ata_ehi_push_desc(ehi, ", interface fatal error");
 	}
 
-	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
+	if (irq_stat & PORT_IRQ_OVERFLOW) {
+		err_mask |= AC_ERR_DEV;
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi, ", PRD overflow");
+	}
+
+	if (irq_stat & PORT_IRQ_BAD_PMP) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi, ", unexpected PMP");
+	}
+
+	if (irq_stat & PORT_IRQ_PLUG_EV) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_SOFTRESET;
 		ata_ehi_push_desc(ehi, ", %s", irq_stat & PORT_IRQ_CONNECT ?
-			"connection status changed" : "PHY RDY changed");
+			"connection status changed" : "PHY RDY/etc. changed");
 	}
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
@@ -880,7 +897,7 @@ static void ahci_host_intr(struct ata_po
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	if (unlikely(status & PORT_IRQ_ERROR)) {
+	if (unlikely(status & PORT_IRQ_ALL_EV)) {
 		ahci_error_intr(ap, status);
 		return;
 	}
@@ -899,27 +916,6 @@ static void ahci_host_intr(struct ata_po
 		ata_port_freeze(ap);
 		return;
 	}
-
-	/* hmmm... a spurious interupt */
-
-	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
-		return;
-
-	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag)) {
-		struct ata_queued_cmd *qc =
-			ata_qc_from_tag(ap, ap->active_tag);
-
-		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
-		    (status & PORT_IRQ_PIOS_FIS))
-			return;
-	}
-
-	if (ata_ratelimit())
-		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
-				status, ap->active_tag, ap->sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
