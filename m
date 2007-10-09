From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: kill leftover from enabling NCQ over PMP
Date: Tue, 9 Oct 2007 14:59:50 +0900
Message-ID: <20071009055950.GI12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:12167 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbXJIF76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 01:59:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1917875wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 22:59:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ahci had problems with NCQ over PMP and NCQ used to be disabled while
PMP was attached.  After fixing the problem, the temporary NCQ
disabling code wasn't removed completely.  Kill the remaining piece.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 24fb90f..694eabc 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1677,19 +1677,11 @@ static void ahci_pmp_attach(struct ata_port *ap)
 static void ahci_pmp_detach(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
-	struct ahci_host_priv *hpriv = ap->host->private_data;
-	unsigned long flags;
 	u32 cmd;
 
 	cmd = readl(port_mmio + PORT_CMD);
 	cmd &= ~PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
-
-	if (hpriv->cap & HOST_CAP_NCQ) {
-		spin_lock_irqsave(ap->lock, flags);
-		ap->flags |= ATA_FLAG_NCQ;
-		spin_unlock_irqrestore(ap->lock, flags);
-	}
 }
 
 static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
-- 
1.5.0.3

