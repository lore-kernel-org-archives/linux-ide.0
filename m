From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 405/493] ide: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:54 -0500
Message-ID: <1353349642-3677-405-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41486 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab2KSSe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 13:34:56 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: linux-ide@vger.kernel.org 
---
 drivers/ide/aec62xx.c      | 2 +-
 drivers/ide/cy82c693.c     | 2 +-
 drivers/ide/hpt366.c       | 2 +-
 drivers/ide/icside.c       | 2 +-
 drivers/ide/ide_platform.c | 2 +-
 drivers/ide/it821x.c       | 2 +-
 drivers/ide/pdc202xx_new.c | 2 +-
 drivers/ide/rapide.c       | 2 +-
 drivers/ide/scc_pata.c     | 2 +-
 drivers/ide/siimage.c      | 2 +-
 drivers/ide/sis5513.c      | 2 +-
 drivers/ide/tc86c001.c     | 2 +-
 drivers/ide/via82cxxx.c    | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
index 35ffff1..c7eaf20 100644
--- a/drivers/ide/aec62xx.c
+++ b/drivers/ide/aec62xx.c
@@ -287,7 +287,7 @@ static int aec62xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return err;
 }
 
-static void __devexit aec62xx_remove(struct pci_dev *dev)
+static void aec62xx_remove(struct pci_dev *dev)
 {
 	ide_pci_remove(dev);
 	pci_disable_device(dev);
diff --git a/drivers/ide/cy82c693.c b/drivers/ide/cy82c693.c
index 1ea2d59..8955162 100644
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -190,7 +190,7 @@ static int cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	return ret;
 }
 
-static void __devexit cy82c693_remove(struct pci_dev *dev)
+static void cy82c693_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 9cf2093..696b6c1 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -1499,7 +1499,7 @@ static int hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void __devexit hpt366_remove(struct pci_dev *dev)
+static void hpt366_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct ide_info *info = host->host_priv;
diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index d17d3a7..8eeda28 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -604,7 +604,7 @@ icside_probe(struct expansion_card *ec, const struct ecard_id *id)
 	return ret;
 }
 
-static void __devexit icside_remove(struct expansion_card *ec)
+static void icside_remove(struct expansion_card *ec)
 {
 	struct icside_state *state = ecard_get_drvdata(ec);
 
diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index d2b648a..6bfdf66 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -115,7 +115,7 @@ out:
 	return ret;
 }
 
-static int __devexit plat_ide_remove(struct platform_device *pdev)
+static int plat_ide_remove(struct platform_device *pdev)
 {
 	struct ide_host *host = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index 7054004..f01ba46 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -667,7 +667,7 @@ static int it821x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return rc;
 }
 
-static void __devexit it821x_remove(struct pci_dev *dev)
+static void it821x_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct it821x_dev *itdevs = host->host_priv;
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 0a1afa2..df73cbd 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -514,7 +514,7 @@ static int pdc202new_init_one(struct pci_dev *dev, const struct pci_device_id *i
 	return ide_pci_init_one(dev, d, NULL);
 }
 
-static void __devexit pdc202new_remove(struct pci_dev *dev)
+static void pdc202new_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct pci_dev *dev2 = host->dev[1] ? to_pci_dev(host->dev[1]) : NULL;
diff --git a/drivers/ide/rapide.c b/drivers/ide/rapide.c
index 052a33e..8b39f21 100644
--- a/drivers/ide/rapide.c
+++ b/drivers/ide/rapide.c
@@ -64,7 +64,7 @@ rapide_probe(struct expansion_card *ec, const struct ecard_id *id)
 	return ret;
 }
 
-static void __devexit rapide_remove(struct expansion_card *ec)
+static void rapide_remove(struct expansion_card *ec)
 {
 	struct ide_host *host = ecard_get_drvdata(ec);
 
diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
index a250a13..9eedfe0 100644
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -846,7 +846,7 @@ static int scc_init_one(struct pci_dev *dev, const struct pci_device_id *id)
  *	Called by the PCI code when it removes an SCC PATA controller.
  */
 
-static void __devexit scc_remove(struct pci_dev *dev)
+static void scc_remove(struct pci_dev *dev)
 {
 	struct scc_ports *ports = pci_get_drvdata(dev);
 	struct ide_host *host = ports->host;
diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index 3791333..bb065f0 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -790,7 +790,7 @@ static int siimage_init_one(struct pci_dev *dev,
 	return rc;
 }
 
-static void __devexit siimage_remove(struct pci_dev *dev)
+static void siimage_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	void __iomem *ioaddr = host->host_priv;
diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index dd33d4d..247853e 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -595,7 +595,7 @@ static int sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return ide_pci_init_one(dev, &d, NULL);
 }
 
-static void __devexit sis5513_remove(struct pci_dev *dev)
+static void sis5513_remove(struct pci_dev *dev)
 {
 	ide_pci_remove(dev);
 	pci_disable_device(dev);
diff --git a/drivers/ide/tc86c001.c b/drivers/ide/tc86c001.c
index d364319b8..345c773 100644
--- a/drivers/ide/tc86c001.c
+++ b/drivers/ide/tc86c001.c
@@ -232,7 +232,7 @@ out:
 	return rc;
 }
 
-static void __devexit tc86c001_remove(struct pci_dev *dev)
+static void tc86c001_remove(struct pci_dev *dev)
 {
 	ide_pci_remove(dev);
 	pci_release_region(dev, 5);
diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index b73d5fc..01464f1 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -489,7 +489,7 @@ static int via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return rc;
 }
 
-static void __devexit via_remove(struct pci_dev *dev)
+static void via_remove(struct pci_dev *dev)
 {
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct via82cxxx_dev *vdev = host->host_priv;
-- 
1.8.0

