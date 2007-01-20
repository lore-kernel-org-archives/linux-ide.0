From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH RESEND] libata: fix compile warning caused by ignoring __must_check results
Date: Sat, 20 Jan 2007 15:50:48 +0900
Message-ID: <20070120065048.GD24749@htj.dyndns.org>
References: <20070120064554.GC24749@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:5113 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965098AbXATGuz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jan 2007 01:50:55 -0500
Received: by wx-out-0506.google.com with SMTP id h31so728130wxd
        for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 22:50:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070120064554.GC24749@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

* Fix compile warnings in pata_cs5530, sata_inic162x and sata_nv which
  are caused by throwing away return values marked with __must_check.

* pci_request_region() is marked with __must_check.
  ata_pci_init_one() didn't check return value for legacy devices
  triggering warning message.  This patch adds dummy assignment to rc
  to remove the warnings.  Ignoring the return value is intentional.
  Acquiring regions for legacy ctl and bmdma areas is recently added
  and we don't wanna fail initialization even if it fails (at least
  not yet).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Sorry, forgot to update description after adding sff changes.
Otherwise, the patch is identical.

 drivers/ata/libata-sff.c    |   10 +++++++---
 drivers/ata/pata_cs5530.c   |    6 +++++-
 drivers/ata/sata_inic162x.c |    4 +++-
 drivers/ata/sata_nv.c       |    5 ++++-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 69a5910..c7acbe9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1096,12 +1096,16 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		} else
 			legacy_mode |= ATA_PORT_SECONDARY;
 
+		/* For backward-compatibility reasons, we don't care
+		 * whether the followings succeed or fail.  Throw away
+		 * return value explicitly to override __must_check.
+		 */
 		if (legacy_mode & ATA_PORT_PRIMARY)
-			pci_request_region(pdev, 1, DRV_NAME);
+			rc = pci_request_region(pdev, 1, DRV_NAME);
 		if (legacy_mode & ATA_PORT_SECONDARY)
-			pci_request_region(pdev, 3, DRV_NAME);
+			rc = pci_request_region(pdev, 3, DRV_NAME);
 		/* If there is a DMA resource, allocate it */
-		pci_request_region(pdev, 4, DRV_NAME);
+		rc = pci_request_region(pdev, 4, DRV_NAME);
 	}
 
 	/* we have legacy mode, but all ports are unavailable */
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 611d90f..d0e542c 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
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
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index b67817e..6cd1fe9 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -649,7 +649,9 @@ static int inic_pci_device_resume(struct pci_dev *pdev)
 	void __iomem *mmio_base = host->mmio_base;
 	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		printk("XXX\n");
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index cc10e43..9d8db97 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1554,8 +1554,11 @@ static int nv_pci_device_resume(struct pci_dev *pdev)
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
-- 
1.4.4.3

