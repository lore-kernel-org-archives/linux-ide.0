From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] kill @force_restart and refine CLO for ahci_kick_engine()
Date: Fri, 7 Aug 2009 15:05:52 +0800
Message-ID: <1249628752.3413.6.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:58322
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756622AbZHGHGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 03:06:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

This patch refines ahci_kick_engine() after discussion with Tejun about
FBS(FIS-based switching) support preparation:
a. Kill @force_restart and always kick the engine. The only case where
   @force_restart is zero is when it's called from ahci_p5wdh_hardreset()
   Actually at that point, BSY is pretty much guaranteed to be set.
b. If PMP is attached, ignore busy and always do CLO. (AHCI-1.3 9.2)

Signed-off-by: Shane Huang <shane.huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
+++ b/drivers/ata/ahci.c	2009-08-06 17:36:59.000000000 +0800
@@ -1578,7 +1578,7 @@
 	pp->cmd_slot[tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
 }
 
-static int ahci_kick_engine(struct ata_port *ap, int force_restart)
+static int ahci_kick_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ahci_host_priv *hpriv = ap->host->private_data;
@@ -1586,18 +1586,16 @@
 	u32 tmp;
 	int busy, rc;
 
-	/* do we need to kick the port? */
-	busy = status & (ATA_BUSY | ATA_DRQ);
-	if (!busy && !force_restart)
-		return 0;
-
 	/* stop engine */
 	rc = ahci_stop_engine(ap);
 	if (rc)
 		goto out_restart;
 
-	/* need to do CLO? */
-	if (!busy) {
+	/* need to do CLO?
+	 * always do CLO if PMP is attached (AHCI-1.3 9.2)
+	 */
+	busy = status & (ATA_BUSY | ATA_DRQ);
+	if (!busy && !sata_pmp_attached(ap)) {
 		rc = 0;
 		goto out_restart;
 	}
@@ -1645,7 +1643,7 @@
 		tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1,
 					1, timeout_msec);
 		if (tmp & 0x1) {
-			ahci_kick_engine(ap, 1);
+			ahci_kick_engine(ap);
 			return -EBUSY;
 		}
 	} else
@@ -1667,7 +1665,7 @@
 	DPRINTK("ENTER\n");
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_kick_engine(ap, 1);
+	rc = ahci_kick_engine(ap);
 	if (rc && rc != -EOPNOTSUPP)
 		ata_link_printk(link, KERN_WARNING,
 				"failed to reset engine (errno=%d)\n", rc);
@@ -1873,7 +1871,7 @@
 		rc = ata_wait_after_reset(link, jiffies + 2 * HZ,
 					  ahci_check_ready);
 		if (rc)
-			ahci_kick_engine(ap, 0);
+			ahci_kick_engine(ap);
 	}
 	return rc;
 }
@@ -2254,7 +2252,7 @@
 
 	/* make DMA engine forget about the failed command */
 	if (qc->flags & ATA_QCFLAG_FAILED)
-		ahci_kick_engine(ap, 1);
+		ahci_kick_engine(ap);
 }
 
 static void ahci_pmp_attach(struct ata_port *ap)


