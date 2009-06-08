From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: re-implement ide_pci_init_one() on top of ide_pci_init_two()
Date: Mon, 8 Jun 2009 22:24:56 +0200
Message-ID: <200906082224.56438.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41229 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbZFHUdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2009 16:33:15 -0400
Received: by mail-ew0-f210.google.com with SMTP id 6so4502448ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2009 13:33:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against ide-2.6.git/for-next

 drivers/ide/setup-pci.c |   70 ++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (C) 1998-2000  Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 1995-1998  Mark Lord
- *  Copyright (C)      2007  Bartlomiej Zolnierkiewicz
+ *  Copyright (C) 2007-2009  Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
  */
@@ -534,61 +534,15 @@ out:
 	return ret;
 }
 
-int ide_pci_init_one(struct pci_dev *dev, const struct ide_port_info *d,
-		     void *priv)
-{
-	struct ide_host *host;
-	struct ide_hw hw[2], *hws[] = { NULL, NULL };
-	int ret;
-
-	ret = ide_setup_pci_controller(dev, d, 1);
-	if (ret < 0)
-		goto out;
-
-	ide_pci_setup_ports(dev, d, &hw[0], &hws[0]);
-
-	host = ide_host_alloc(d, hws, 2);
-	if (host == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	host->dev[0] = &dev->dev;
-
-	host->host_priv = priv;
-
-	host->irq_flags = IRQF_SHARED;
-
-	pci_set_drvdata(dev, host);
-
-	ret = do_ide_setup_pci_device(dev, d, 1);
-	if (ret < 0)
-		goto out;
-
-	/* fixup IRQ */
-	if (ide_pci_is_in_compatibility_mode(dev)) {
-		hw[0].irq = pci_get_legacy_ide_irq(dev, 0);
-		hw[1].irq = pci_get_legacy_ide_irq(dev, 1);
-	} else
-		hw[1].irq = hw[0].irq = ret;
-
-	ret = ide_host_register(host, d, hws);
-	if (ret)
-		ide_host_free(host);
-out:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ide_pci_init_one);
-
 int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
 		     const struct ide_port_info *d, void *priv)
 {
 	struct pci_dev *pdev[] = { dev1, dev2 };
 	struct ide_host *host;
-	int ret, i;
+	int ret, i, n_ports = dev2 ? 4 : 2;
 	struct ide_hw hw[4], *hws[] = { NULL, NULL, NULL, NULL };
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < n_ports / 2; i++) {
 		ret = ide_setup_pci_controller(pdev[i], d, !i);
 		if (ret < 0)
 			goto out;
@@ -596,23 +550,24 @@ int ide_pci_init_two(struct pci_dev *dev
 		ide_pci_setup_ports(pdev[i], d, &hw[i*2], &hws[i*2]);
 	}
 
-	host = ide_host_alloc(d, hws, 4);
+	host = ide_host_alloc(d, hws, n_ports);
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	host->dev[0] = &dev1->dev;
-	host->dev[1] = &dev2->dev;
+	if (dev2)
+		host->dev[1] = &dev2->dev;
 
 	host->host_priv = priv;
-
 	host->irq_flags = IRQF_SHARED;
 
 	pci_set_drvdata(pdev[0], host);
-	pci_set_drvdata(pdev[1], host);
+	if (dev2)
+		pci_set_drvdata(pdev[1], host);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < n_ports / 2; i++) {
 		ret = do_ide_setup_pci_device(pdev[i], d, !i);
 
 		/*
@@ -638,6 +593,13 @@ out:
 }
 EXPORT_SYMBOL_GPL(ide_pci_init_two);
 
+int ide_pci_init_one(struct pci_dev *dev, const struct ide_port_info *d,
+		     void *priv)
+{
+	return ide_pci_init_two(dev, NULL, d, priv);
+}
+EXPORT_SYMBOL_GPL(ide_pci_init_one);
+
 void ide_pci_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
