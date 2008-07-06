From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/50] it821x: convert to use ->host_priv
Date: Sun, 06 Jul 2008 19:20:20 +0200
Message-ID: <48710239.1ade660a.3458.627e@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:49197 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139AbYGFRev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:34:51 -0400
Received: by gv-out-0910.google.com with SMTP id e6so309131gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:34:50 -0700 (PDT)
Content-Disposition: inline; filename=it821x-convert-to-use-host_priv.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

While at it:

* Allocate both struct it821x_dev instances at once.

* Don't leak itdevs on ide_pci_init_one() failure.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it821x.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -528,8 +528,9 @@ static struct ide_dma_ops it821x_pass_th
 static void __devinit init_hwif_it821x(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	struct it821x_dev **itdevs = (struct it821x_dev **)pci_get_drvdata(dev);
-	struct it821x_dev *idev = itdevs[hwif->channel];
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct it821x_dev *itdevs = host->host_priv;
+	struct it821x_dev *idev = itdevs + hwif->channel;
 	u8 conf;
 
 	ide_set_hwifdata(hwif, idev);
@@ -642,23 +643,20 @@ static const struct ide_port_info it821x
 
 static int __devinit it821x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	struct it821x_dev *itdevs[2] = { NULL, NULL} , *itdev;
-	unsigned int i;
+	struct it821x_dev *itdevs;
+	int rc;
 
-	for (i = 0; i < 2; i++) {
-		itdev = kzalloc(sizeof(*itdev), GFP_KERNEL);
-		if (itdev == NULL) {
-			kfree(itdevs[0]);
-			printk(KERN_ERR "it821x: out of memory\n");
-			return -ENOMEM;
-		}
-
-		itdevs[i] = itdev;
+	itdevs = kzalloc(2 * sizeof(*itdevs), GFP_KERNEL);
+	if (itdevs == NULL) {
+		printk(KERN_ERR "it821x: out of memory\n");
+		return -ENOMEM;
 	}
 
-	pci_set_drvdata(dev, itdevs);
+	rc = ide_pci_init_one(dev, &it821x_chipsets[id->driver_data], itdevs);
+	if (rc)
+		kfree(itdevs);
 
-	return ide_pci_init_one(dev, &it821x_chipsets[id->driver_data], NULL);
+	return rc;
 }
 
 static const struct pci_device_id it821x_pci_tbl[] = {

-- 

