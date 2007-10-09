From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: fix notification handling
Date: Tue, 9 Oct 2007 15:02:23 +0900
Message-ID: <20071009060223.GK12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:19236 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbXJIGCc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:02:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1918545wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 23:02:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Asynchronous notification on ICH9 didn't work because it didn't write
AN FIS into the RX area - it only updates SNotification.  Also,
snooping SDB_FIS RX area is racy against further SDB FIS receptions.
Let sata_async_notification() determine using SNTF if it's available
and snoop RX area iff SNTF isn't available

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/ata/ahci.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6633c74..abfb72a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1420,6 +1420,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u32 status, qc_active;
 	int rc, known_irq = 0;
 
@@ -1432,17 +1433,28 @@ static void ahci_port_intr(struct ata_port *ap)
 	}
 
 	if (status & PORT_IRQ_SDB_FIS) {
-		/* If the 'N' bit in word 0 of the FIS is set, we just
-		 * received asynchronous notification.  Tell libata
-		 * about it.  Note that as the SDB FIS itself is
-		 * accessible, SNotification can be emulated by the
-		 * driver but don't bother for the time being.
+		/* If SNotification is available, leave notification
+		 * handling to sata_async_notification().  If not,
+		 * emulate it by snooping SDB FIS RX area.
+		 *
+		 * Snooping FIS RX area is probably cheaper than
+		 * poking SNotification but some constrollers which
+		 * implement SNotification, ICH9 for example, don't
+		 * store AN SDB FIS into receive area.
 		 */
-		const __le32 *f = pp->rx_fis + RX_FIS_SDB;
-		u32 f0 = le32_to_cpu(f[0]);
-
-		if (f0 & (1 << 15))
+		if (hpriv->cap & HOST_CAP_SNTF)
 			sata_async_notification(ap);
+		else {
+			/* If the 'N' bit in word 0 of the FIS is set,
+			 * we just received asynchronous notification.
+			 * Tell libata about it.
+			 */
+			const __le32 *f = pp->rx_fis + RX_FIS_SDB;
+			u32 f0 = le32_to_cpu(f[0]);
+
+			if (f0 & (1 << 15))
+				sata_async_notification(ap);
+		}
 	}
 
 	/* pp->active_link is valid iff any command is in flight */
-- 
1.5.0.3

