From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: fix fatal error int handling
Date: Wed,  9 Mar 2005 15:57:14 -0500 (EST)
Message-ID: <20050309205714.DBED014FA3@lns1032.lss.emc.com>
Received: from mailhub.lss.emc.com ([168.159.2.31]:13016 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262453AbVCIU5T
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Mar 2005 15:57:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I noticed that the AHCI CI (cmd issue) reg wasn't getting cleared
after error ints resulting in no further commands being successfully
issued to the port.  This patch fixes.  All that's really needed is
the 1's complement but I also removed the disabling/enabling of the
FIS_RX b/c this isn't spec'd as necessary when handling error ints.

Signed-off-by: Brett Russ <russb@emc.com>

===== drivers/scsi/ahci.c 1.17 vs edited =====
--- 1.17/drivers/scsi/ahci.c	2005-02-24 14:52:41 -05:00
+++ edited/drivers/scsi/ahci.c	2005-03-09 15:30:06 -05:00
@@ -538,7 +538,7 @@
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
 	/* wait for engine to stop.  TODO: this could be
@@ -570,7 +570,7 @@
 
 	/* re-start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
