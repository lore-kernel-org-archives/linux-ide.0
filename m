From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] ahci: consider SDB FIS containing spurious NCQ completions HSM violation (regenerated)
Date: Wed, 21 Feb 2007 16:34:25 +0900
Message-ID: <20070221073425.GV1625@htj.dyndns.org>
References: <11704009511903-git-send-email-htejun@gmail.com> <45DB17F2.5000707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:64575 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161023AbXBUHei (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 02:34:38 -0500
Received: by py-out-1112.google.com with SMTP id a29so1129258pyi
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 23:34:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45DB17F2.5000707@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org

SDB FIS containing spurious NCQ completions is a clear protocol
violation.  Currently, only some Maxtors with early firmware revisions
are showing this problem.  Those firmwares have other NCQ related
problems including buggy NCQ error reporting and occasional lock up
after NCQ errors.

Consider spurious NCQ completions HSM violation and freeze the port
after it.  EH will turn off NCQ after this happens several times.
Eventually drives which show this behavior should be blacklisted for
NCQ.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Regenerated against the current #upstream
(b216f3f887bb3e73808250841035a6fc4f6fc9e0).

Thanks.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6a3543e..334f54c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -198,7 +198,6 @@ struct ahci_port_priv {
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
 	/* for NCQ spurious interrupt analysis */
-	int			ncq_saw_spurious_sdb_cnt;
 	unsigned int		ncq_saw_d2h:1;
 	unsigned int		ncq_saw_dmas:1;
 };
@@ -1160,23 +1159,24 @@ static void ahci_host_intr(struct ata_port *ap)
 		known_irq = 1;
 	}
 
-	if (status & PORT_IRQ_SDB_FIS &&
-		   pp->ncq_saw_spurious_sdb_cnt < 10) {
+	if (status & PORT_IRQ_SDB_FIS) {
 		/* SDB FIS containing spurious completions might be
-		 * dangerous, we need to know more about them.  Print
-		 * more of it.
-		 */
+		 * dangerous, whine and fail commands with HSM
+		 * violation.  EH will turn off NCQ after several such
+		 * failures.
+  		 */
 		const __le32 *f = pp->rx_fis + RX_FIS_SDB;
 
-		ata_port_printk(ap, KERN_INFO, "Spurious SDB FIS during NCQ "
-				"issue=0x%x SAct=0x%x FIS=%08x:%08x%s\n",
-				readl(port_mmio + PORT_CMD_ISSUE),
-				readl(port_mmio + PORT_SCR_ACT),
-				le32_to_cpu(f[0]), le32_to_cpu(f[1]),
-				pp->ncq_saw_spurious_sdb_cnt < 10 ?
-				"" : ", shutting up");
+		ata_ehi_push_desc(ehi, "spurious completion during NCQ "
+				  "issue=0x%x SAct=0x%x FIS=%08x:%08x",
+				  readl(port_mmio + PORT_CMD_ISSUE),
+				  readl(port_mmio + PORT_SCR_ACT),
+				  le32_to_cpu(f[0]), le32_to_cpu(f[1]));
+
+		ehi->err_mask |= AC_ERR_HSM;
+		ehi->action |= ATA_EH_SOFTRESET;
+		ata_port_freeze(ap);
 
-		pp->ncq_saw_spurious_sdb_cnt++;
 		known_irq = 1;
 	}
 
