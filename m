From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_nv: disable ADMA mode by default
Date: Tue, 08 Jan 2008 00:35:10 +0900
Message-ID: <478246AE.3020500@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36541 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbYAGPfQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 10:35:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so12584922wah.23
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 07:35:15 -0800 (PST)
In-Reply-To: <4782422C.8020202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

There still are remaining issues with ADMA support.  Disable it by
default and warn when enabling.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, please hold off till Robert acks.  Robert, what do you think?

 drivers/ata/sata_nv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index ed5dc7c..27a0e34 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -639,7 +639,7 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static int adma_enabled = 1;
+static int adma_enabled = 0;
 static int swncq_enabled;
 
 static void nv_adma_register_mode(struct ata_port *ap)
@@ -2396,6 +2396,9 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* determine type and allocate host */
 	if (type == CK804 && adma_enabled) {
 		dev_printk(KERN_NOTICE, &pdev->dev, "Using ADMA mode\n");
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "WARNING: There are known problems with ADMA mode "
+			   "which may lead to timeouts and/or system lock ups.\n");
 		type = ADMA;
 	}
 
