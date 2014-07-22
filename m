From: tim@buttersideup.com (Tim Small)
Subject: [PATCH] sata_sil24: Identify which card suffered IRQ status error
Date: Tue, 22 Jul 2014 14:28:00 +0100 (BST)
Message-ID: <20140722132800.952BA60250@zebedee.buttersideup.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.234.210]:51314 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753985AbaGVN7m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 09:59:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

In machines with multiple Silicon Image 3124 and/or 3132 cards, there is no
way to tell which card is the culprit when the sata_sil24 interrupt handler
gets a bad status.

Tested-by: tim@seoss.co.uk
Signed-off-by: tim@seoss.co.uk

---

I got the following fault on a machine with five SiI3124 / 3132 cards in total
so I patched the driver to report the PCI slot number too.  The resulting code
seems to identify the card as desired...

old output:

sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?


new output:

sata_sil24 0000:08:04.0: IRQ status == 0xffffffff, PCI fault or device removal?


Regards,

Tim.



diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 0534890..d81b20d 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1154,8 +1154,8 @@ static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
 	status = readl(host_base + HOST_IRQ_STAT);
 
 	if (status == 0xffffffff) {
-		printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
-		       "PCI fault or device removal?\n");
+		dev_err(host->dev, "IRQ status == 0xffffffff, "
+			"PCI fault or device removal?\n");
 		goto out;
 	}
 
