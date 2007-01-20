From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: don't enter slumber on power down
Date: Sun, 21 Jan 2007 02:10:11 +0900
Message-ID: <20070120171011.GE24749@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:2649 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965317AbXATRKU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jan 2007 12:10:20 -0500
Received: by nf-out-0910.google.com with SMTP id o25so803532nfa
        for <linux-ide@vger.kernel.org>; Sat, 20 Jan 2007 09:10:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Some ATA/ATAPI devices act weirdly after the link is put into slumber
mode.  Some hang completely requiring physical power removal while
others fail to wake up till the link is hardreset a couple of times.

The addition of slumber on power down was never driven by real need.
It just followed what ahci spec said literally.  The spec itself seems
faulty in that it doesn't consider devices (not controllers) which
don't support link powersaving mode.

Theory never matches reality when it comes to dark allys of cheap
ATA/ATAPI world.  It's just unrealistic to expect vendors to test
rarely used link powersaving feature rigorously.  This patch makes
ahci more friendly to the coldness of reality.

This shouldn't have any negative effect - when suspend operation
succeeds, we power off the whole machine; otherwise, we wake up
everything.  I can't see any reason to be so elaborate with powering
down the link in the first place.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -586,35 +586,18 @@ static void ahci_power_down(void __iomem
 {
 	u32 cmd, scontrol;
 
-	cmd = readl(port_mmio + PORT_CMD) & ~PORT_CMD_ICC_MASK;
-
-	if (cap & HOST_CAP_SSC) {
-		/* enable transitions to slumber mode */
-		scontrol = readl(port_mmio + PORT_SCR_CTL);
-		if ((scontrol & 0x0f00) > 0x100) {
-			scontrol &= ~0xf00;
-			writel(scontrol, port_mmio + PORT_SCR_CTL);
-		}
+	if (!(cap & HOST_CAP_SSS))
+		return;
 
-		/* put device into slumber mode */
-		writel(cmd | PORT_CMD_ICC_SLUMBER, port_mmio + PORT_CMD);
+	/* put device into listen mode, first set PxSCTL.DET to 0 */
+	scontrol = readl(port_mmio + PORT_SCR_CTL);
+	scontrol &= ~0xf;
+	writel(scontrol, port_mmio + PORT_SCR_CTL);
 
-		/* wait for the transition to complete */
-		ata_wait_register(port_mmio + PORT_CMD, PORT_CMD_ICC_SLUMBER,
-				  PORT_CMD_ICC_SLUMBER, 1, 50);
-	}
-
-	/* put device into listen mode */
-	if (cap & HOST_CAP_SSS) {
-		/* first set PxSCTL.DET to 0 */
-		scontrol = readl(port_mmio + PORT_SCR_CTL);
-		scontrol &= ~0xf;
-		writel(scontrol, port_mmio + PORT_SCR_CTL);
-
-		/* then set PxCMD.SUD to 0 */
-		cmd &= ~PORT_CMD_SPIN_UP;
-		writel(cmd, port_mmio + PORT_CMD);
-	}
+	/* then set PxCMD.SUD to 0 */
+	cmd = readl(port_mmio + PORT_CMD) & ~PORT_CMD_ICC_MASK;
+	cmd &= ~PORT_CMD_SPIN_UP;
+	writel(cmd, port_mmio + PORT_CMD);
 }
 
 static void ahci_init_port(void __iomem *port_mmio, u32 cap,
