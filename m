From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: jmb361 has only one port
Date: Tue, 17 Jun 2008 12:46:30 +0900
Message-ID: <48573396.9050308@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44748 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148AbYFQDqp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 23:46:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: gajo01@gmail.com

JMB361 has only one port but reports it has two causing longish probe
failure on the second one.  Quirk it.

Reported by Gajo Petrovic in bz 10911.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Gajo Petrovic <gajo01@gmail.com>
---
Another hardware-specific workaround for #upstream-fixes.

 drivers/ata/ahci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 966ab40..29f34d0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -653,6 +653,14 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 		cap &= ~HOST_CAP_PMP;
 	}
 
+	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361 &&
+	    port_map != 1) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "JMB361 has only one port, port_map 0x%x -> 0x%x\n",
+			   port_map, 1);
+		port_map = 1;
+	}
+
 	/*
 	 * Temporary Marvell 6145 hack: PATA port presence
 	 * is asserted through the standard AHCI port
