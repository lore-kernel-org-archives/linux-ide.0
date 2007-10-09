From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: clean up PORT_IRQ_BAD_PMP enabling
Date: Tue, 9 Oct 2007 15:01:37 +0900
Message-ID: <20071009060137.GJ12186@htj.dyndns.org>
References: <20071009055950.GI12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:17559 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbXJIGBo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:01:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1918341wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 23:01:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071009055950.GI12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Now that we have pp->intr_mask, move PORT_IRQ_BAD_PMP enabling to
ahci_pmp_attach/detach() where it belongs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 694eabc..6633c74 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1620,11 +1620,8 @@ static void ahci_thaw(struct ata_port *ap)
 	writel(tmp, port_mmio + PORT_IRQ_STAT);
 	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);
 
-	/* turn IRQ back on, ignore BAD_PMP if PMP isn't attached */
-	tmp = pp->intr_mask;
-	if (!ap->nr_pmp_links)
-		tmp &= ~PORT_IRQ_BAD_PMP;
-	writel(tmp, port_mmio + PORT_IRQ_MASK);
+	/* turn IRQ back on */
+	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 static void ahci_error_handler(struct ata_port *ap)
@@ -1667,21 +1664,29 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 static void ahci_pmp_attach(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 cmd;
 
 	cmd = readl(port_mmio + PORT_CMD);
 	cmd |= PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
+
+	pp->intr_mask |= PORT_IRQ_BAD_PMP;
+	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 static void ahci_pmp_detach(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 cmd;
 
 	cmd = readl(port_mmio + PORT_CMD);
 	cmd &= ~PORT_CMD_PMP;
 	writel(cmd, port_mmio + PORT_CMD);
+
+	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
+	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
-- 
1.5.0.3

