From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: redo stopping DMA engines on empty
 ports
Date: Mon, 07 Jun 2010 15:15:08 +0200
Message-ID: <4C0CF0DC.7060901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42373 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239Ab0FGNPa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2010 09:15:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, Marc Dionne <marc.c.dionne@gmail.com>, Robert Hancock <hancockrwd@gmail.com>

Commit 96d60303fd (ahci: Turn off DMA engines when there's no device)
implemented stopping DMA engines on empty ports but it used single
sampling of status registers to determine device presence which led to
disabling of DMA engines on occupied ports.  Do it after all EH
actions are complete using device presence state determined by EH.
This avoids spurious disabling of DMA engines and simplifies the code.

Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: Marc Dionne <marc.c.dionne@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Robert Hancock <hancockrwd@gmail.com>
---
 drivers/ata/libahci.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1984a6e..261f86d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -541,29 +541,11 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
 	return -EINVAL;
 }

-static int ahci_is_device_present(void __iomem *port_mmio)
-{
-	u8 status = readl(port_mmio + PORT_TFDATA) & 0xff;
-
-	/* Make sure PxTFD.STS.BSY and PxTFD.STS.DRQ are 0 */
-	if (status & (ATA_BUSY | ATA_DRQ))
-		return 0;
-
-	/* Make sure PxSSTS.DET is 3h */
-	status = readl(port_mmio + PORT_SCR_STAT) & 0xf;
-	if (status != 3)
-		return 0;
-	return 1;
-}
-
 void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;

-	if (!ahci_is_device_present(port_mmio))
-		return;
-
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
@@ -1892,6 +1874,9 @@ static void ahci_error_handler(struct ata_port *ap)
 	}

 	sata_pmp_error_handler(ap);
+
+	if (!ata_dev_enabled(ap->link.device))
+		ahci_stop_engine(ap);
 }

 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
