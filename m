From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/50] ide: add ide_pci_remove() helper
Date: Sun, 06 Jul 2008 19:20:28 +0200
Message-ID: <48710242.1ade660a.3458.6293@mx.google.com>
References: <20080706172010.559358957@bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13310 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265AbYGFRfA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 13:35:00 -0400
Received: by ug-out-1314.google.com with SMTP id h2so985611ugf.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 10:35:00 -0700 (PDT)
Content-Disposition: inline; filename=ide-add-ide_pci_remove-helper.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Add 'unsigned long host_flags' field to struct ide_host.

* Set ->host_flags in ide_host_alloc_all().

* Always set PCI dev's ->driver_data in ide_pci_init_{one,two}().

* Add ide_pci_remove() helper (the default implementation for
  struct pci_driver's ->remove method).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    3 +++
 drivers/ide/setup-pci.c |   39 +++++++++++++++++++++++++++++++++------
 include/linux/ide.h     |    2 ++
 3 files changed, 38 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1613,6 +1613,9 @@ struct ide_host *ide_host_alloc_all(cons
 	if (hws[0])
 		host->dev[0] = hws[0]->dev;
 
+	if (d)
+		host->host_flags = d->host_flags;
+
 	return host;
 }
 EXPORT_SYMBOL_GPL(ide_host_alloc_all);
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -547,8 +547,7 @@ int ide_pci_init_one(struct pci_dev *dev
 
 	host->host_priv = priv;
 
-	if (priv)
-		pci_set_drvdata(dev, host);
+	pci_set_drvdata(dev, host);
 
 	ret = do_ide_setup_pci_device(dev, d, 1);
 	if (ret < 0)
@@ -592,10 +591,8 @@ int ide_pci_init_two(struct pci_dev *dev
 
 	host->host_priv = priv;
 
-	if (priv) {
-		pci_set_drvdata(pdev[0], host);
-		pci_set_drvdata(pdev[1], host);
-	}
+	pci_set_drvdata(pdev[0], host);
+	pci_set_drvdata(pdev[1], host);
 
 	for (i = 0; i < 2; i++) {
 		ret = do_ide_setup_pci_device(pdev[i], d, !i);
@@ -618,3 +615,33 @@ out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ide_pci_init_two);
+
+void ide_pci_remove(struct pci_dev *dev)
+{
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
+	int bars;
+
+	if (host->host_flags & IDE_HFLAG_SINGLE)
+		bars = (1 << 2) - 1;
+	else
+		bars = (1 << 4) - 1;
+
+	if ((host->host_flags & IDE_HFLAG_NO_DMA) == 0) {
+		if (host->host_flags & IDE_HFLAG_CS5520)
+			bars |= (1 << 2);
+		else
+			bars |= (1 << 4);
+	}
+
+	ide_host_remove(host);
+
+	if (dev2)
+		pci_release_selected_regions(dev2, bars);
+	pci_release_selected_regions(dev, bars);
+
+	if (dev2)
+		pci_disable_device(dev2);
+	pci_disable_device(dev);
+}
+EXPORT_SYMBOL_GPL(ide_pci_remove);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -616,6 +616,7 @@ struct ide_host {
 	ide_hwif_t	*ports[MAX_HWIFS];
 	unsigned int	n_ports;
 	struct device	*dev[2];
+	unsigned long	host_flags;
 	void		*host_priv;
 };
 
@@ -1198,6 +1199,7 @@ struct ide_port_info {
 int ide_pci_init_one(struct pci_dev *, const struct ide_port_info *, void *);
 int ide_pci_init_two(struct pci_dev *, struct pci_dev *,
 		     const struct ide_port_info *, void *);
+void ide_pci_remove(struct pci_dev *);
 
 void ide_map_sg(ide_drive_t *, struct request *);
 void ide_init_sg_cmd(ide_drive_t *, struct request *);

-- 

