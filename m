From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix compile warning caused by ignoring __must_check results
Date: Sat, 20 Jan 2007 14:23:29 +0900
Message-ID: <20070120052329.GB24749@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:7859 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965003AbXATFXf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jan 2007 00:23:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so554594nze
        for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 21:23:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Fix compile warnings in pata_cs5530, sata_inic162x and sata_nv which
are caused by throwing away return values marked with __must_check.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_cs5530.c   |    6 +++++-
 drivers/ata/sata_inic162x.c |    4 +++-
 drivers/ata/sata_nv.c       |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

Index: work/drivers/ata/pata_cs5530.c
===================================================================
--- work.orig/drivers/ata/pata_cs5530.c
+++ work/drivers/ata/pata_cs5530.c
@@ -251,6 +251,7 @@ static int cs5530_is_palmax(void)
 static int cs5530_init_chip(void)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL, *dev = NULL;
+	int rc;
 
 	while ((dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_ANY_ID, dev)) != NULL) {
 		switch (dev->device) {
@@ -272,7 +273,10 @@ static int cs5530_init_chip(void)
 	}
 
 	pci_set_master(cs5530_0);
-	pci_set_mwi(cs5530_0);
+	rc = pci_set_mwi(cs5530_0);
+	if (rc)
+		dev_printk(KERN_WARNING, &cs5530_0->dev,
+			   "WARNING: failed to set MWI\n");
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -649,7 +649,9 @@ static int inic_pci_device_resume(struct
 	void __iomem *mmio_base = host->mmio_base;
 	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		printk("XXX\n");
Index: work/drivers/ata/sata_nv.c
===================================================================
--- work.orig/drivers/ata/sata_nv.c
+++ work/drivers/ata/sata_nv.c
@@ -1554,8 +1554,11 @@ static int nv_pci_device_resume(struct p
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct nv_host_priv *hpriv = host->private_data;
+	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		if(hpriv->type >= CK804) {
