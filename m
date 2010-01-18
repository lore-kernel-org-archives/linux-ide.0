From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 20/64] pata_serverworks: fix error message
Date: Mon, 18 Jan 2010 18:16:46 +0100
Message-ID: <20100118171646.14623.91955.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754752Ab0ARRSH@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_serverworks: fix error message

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_serverworks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_serverworks.c
===================================================================
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -306,7 +306,7 @@ static int serverworks_fixup_osb4(struct
 		pci_dev_put(isa_dev);
 		return 0;
 	}
-	printk(KERN_WARNING "ata_serverworks: Unable to find bridge.\n");
+	printk(KERN_WARNING DRV_NAME ": Unable to find bridge.\n");
 	return -ENODEV;
 }
 
