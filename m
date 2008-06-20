From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: move ide_pci_setup_ports() call out from do_ide_setup_pci_device()
Date: Fri, 20 Jun 2008 20:27:14 +0200
Message-ID: <200806202027.14924.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:18445 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYFTS1s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 14:27:48 -0400
Received: by yx-out-2324.google.com with SMTP id 31so330282yxl.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 11:27:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Move ide_pci_setup_ports() call out from do_ide_setup_pci_device()
  to ide_setup_pci_device[s]().

* Drop no longer needed idx argument from do_ide_setup_pci_device().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against IDE tree + the recent ide-pmac patches

 drivers/ide/setup-pci.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -479,7 +479,7 @@ EXPORT_SYMBOL_GPL(ide_pci_setup_ports);
  */
 static int do_ide_setup_pci_device(struct pci_dev *dev,
 				   const struct ide_port_info *d,
-				   u8 *idx, u8 noisy)
+				   u8 noisy)
 {
 	int tried_config = 0;
 	int pciirq, ret;
@@ -528,9 +528,7 @@ static int do_ide_setup_pci_device(struc
 				d->name, pciirq);
 	}
 
-	/* FIXME: silent failure can happen */
-
-	ide_pci_setup_ports(dev, d, pciirq, idx);
+	ret = pciirq;
 out:
 	return ret;
 }
@@ -540,10 +538,14 @@ int ide_setup_pci_device(struct pci_dev 
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int ret;
 
-	ret = do_ide_setup_pci_device(dev, d, &idx[0], 1);
+	ret = do_ide_setup_pci_device(dev, d, 1);
+
+	if (ret >= 0) {
+		/* FIXME: silent failure can happen */
+		ide_pci_setup_ports(dev, d, ret, &idx[0]);
 
-	if (ret >= 0)
 		ide_device_add(idx, d);
+	}
 
 	return ret;
 }
@@ -557,13 +559,17 @@ int ide_setup_pci_devices(struct pci_dev
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	for (i = 0; i < 2; i++) {
-		ret = do_ide_setup_pci_device(pdev[i], d, &idx[i*2], !i);
+		ret = do_ide_setup_pci_device(pdev[i], d, !i);
+
 		/*
 		 * FIXME: Mom, mom, they stole me the helper function to undo
 		 * do_ide_setup_pci_device() on the first device!
 		 */
 		if (ret < 0)
 			goto out;
+
+		/* FIXME: silent failure can happen */
+		ide_pci_setup_ports(pdev[i], d, ret, &idx[i*2]);
 	}
 
 	ide_device_add(idx, d);
