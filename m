From: Stefan Roese <sr@denx.de>
Subject: [PATCH] ahci: Add check for device presence (PCIe hot unplug) in ahci_stop_engine()
Date: Tue, 30 Jan 2018 11:02:55 +0100
Message-ID: <20180130100255.24965-1-sr@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:41496 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeA3KDO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 30 Jan 2018 05:03:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Exit directly with ENODEV, if the AHCI controller is not available
anymore. Otherwise a delay of 500ms for each port is added to the remove
function while trying to issue a command on the non-existent controller.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libahci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index a0de7a38430c..7adcf3caabd0 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -665,6 +665,16 @@ int ahci_stop_engine(struct ata_port *ap)
 	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
 		return 0;
 
+	/*
+	 * Don't try to issue commands but return with ENODEV if the
+	 * AHCI controller not available anymore (e.g. due to PCIe hot
+	 * unplugging). Otherwise a 500ms delay for each port is added.
+	 */
+	if (tmp == 0xffffffff) {
+		dev_err(ap->host->dev, "AHCI controller unavailable!\n");
+		return -ENODEV;
+	}
+
 	/* setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
-- 
2.16.1

