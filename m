From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] ahci: consider SDB FIS containing spurious NCQ completions HSM violation
Date: Fri, 2 Feb 2007 16:22:31 +0900
Message-ID: <11704009511903-git-send-email-htejun@gmail.com>
References: <11704009502014-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:10731 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423186AbXBBHWm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:22:42 -0500
Received: by an-out-0708.google.com with SMTP id b33so554968ana
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:22:42 -0800 (PST)
In-Reply-To: <11704009502014-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

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
 drivers/ata/ahci.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8f1d753..1d8d377 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -199,7 +199,6 @@ struct ahci_port_priv {
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
 	/* for NCQ spurious interrupt analysis */
-	int			ncq_saw_spurious_sdb_cnt;
 	unsigned int		ncq_saw_d2h:1;
 	unsigned int		ncq_saw_dmas:1;
 };
@@ -1157,23 +1156,24 @@ static void ahci_host_intr(struct ata_port *ap)
 		known_irq = 1;
 	}
 
-	if (status & PORT_IRQ_SDB_FIS &&
-		   pp->ncq_saw_spurious_sdb_cnt < 10) {
+	if (status & PORT_IRQ_SDB_FIS) {
 		/* SDB FIS containing spurious completions might be
-		 * dangerous, we need to know more about them.  Print
-		 * more of it.
+		 * dangerous, whine and fail commands with HSM
+		 * violation.  EH will turn off NCQ after several such
+		 * failures.
 		 */
 		const u32 *f = pp->rx_fis + RX_FIS_SDB;
 
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
 
-- 
1.4.4.4


