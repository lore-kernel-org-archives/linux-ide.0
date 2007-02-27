From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: improve spurious SDB FIS handling
Date: Tue, 27 Feb 2007 13:24:19 +0900
Message-ID: <20070227042419.GG20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:52809 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbXB0EYU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 23:24:20 -0500
Received: by py-out-1112.google.com with SMTP id a29so827917pyi
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 20:24:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Spurious SDB FIS during NCQ might not contain spurious completions.
It could be spurious TF update or invalid async notification.  Treat
as HSM violation iff a spurious SDB FIS contains spurious completions;
otherwise, just whine once about it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6d93240..6be660c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -200,6 +200,7 @@ struct ahci_port_priv {
 	/* for NCQ spurious interrupt analysis */
 	unsigned int		ncq_saw_d2h:1;
 	unsigned int		ncq_saw_dmas:1;
+	unsigned int		ncq_saw_sdb:1;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -1160,23 +1161,31 @@ static void ahci_host_intr(struct ata_port *ap)
 	}
 
 	if (status & PORT_IRQ_SDB_FIS) {
-		/* SDB FIS containing spurious completions might be
-		 * dangerous, whine and fail commands with HSM
-		 * violation.  EH will turn off NCQ after several such
-		 * failures.
-  		 */
 		const __le32 *f = pp->rx_fis + RX_FIS_SDB;
 
-		ata_ehi_push_desc(ehi, "spurious completion during NCQ "
-				  "issue=0x%x SAct=0x%x FIS=%08x:%08x",
-				  readl(port_mmio + PORT_CMD_ISSUE),
-				  readl(port_mmio + PORT_SCR_ACT),
-				  le32_to_cpu(f[0]), le32_to_cpu(f[1]));
-
-		ehi->err_mask |= AC_ERR_HSM;
-		ehi->action |= ATA_EH_SOFTRESET;
-		ata_port_freeze(ap);
-
+		if (le32_to_cpu(f[1])) {
+			/* SDB FIS containing spurious completions
+			 * might be dangerous, whine and fail commands
+			 * with HSM violation.  EH will turn off NCQ
+			 * after several such failures.
+			 */
+			ata_ehi_push_desc(ehi,
+				"spurious completions during NCQ "
+				"issue=0x%x SAct=0x%x FIS=%08x:%08x",
+				readl(port_mmio + PORT_CMD_ISSUE),
+				readl(port_mmio + PORT_SCR_ACT),
+				le32_to_cpu(f[0]), le32_to_cpu(f[1]));
+			ehi->err_mask |= AC_ERR_HSM;
+			ehi->action |= ATA_EH_SOFTRESET;
+			ata_port_freeze(ap);
+		} else {
+			if (!pp->ncq_saw_sdb)
+				ata_port_printk(ap, KERN_INFO,
+					"spurious SDB FIS %08x:%08x during NCQ, "
+					"this message won't be printed again\n",
+					le32_to_cpu(f[0]), le32_to_cpu(f[1]));
+			pp->ncq_saw_sdb = 1;
+		}
 		known_irq = 1;
 	}
 
