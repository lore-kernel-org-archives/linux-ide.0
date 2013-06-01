From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ata: use pci_{get,set}_drvdata()
Date: Sat, 01 Jun 2013 12:03:57 +0900
Message-ID: <005701ce5e74$a8414470$f8c3cd50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27338 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3FADD7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 May 2013 23:03:59 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNP004811ULPC90@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Sat, 01 Jun 2013 12:03:57 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
pci_dev instead of using dev_{get,set}_drvdata() with &pdev->dev, so we
can directly pass a struct pci_dev.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/acard-ahci.c       |    4 ++--
 drivers/ata/ahci.c             |    4 ++--
 drivers/ata/ata_piix.c         |    6 +++---
 drivers/ata/pata_ali.c         |    2 +-
 drivers/ata/pata_amd.c         |    2 +-
 drivers/ata/pata_artop.c       |    2 +-
 drivers/ata/pata_atp867x.c     |    2 +-
 drivers/ata/pata_cmd640.c      |    2 +-
 drivers/ata/pata_cmd64x.c      |    2 +-
 drivers/ata/pata_cs5520.c      |    4 ++--
 drivers/ata/pata_cs5530.c      |    2 +-
 drivers/ata/pata_hpt366.c      |    2 +-
 drivers/ata/pata_hpt3x3.c      |    2 +-
 drivers/ata/pata_it821x.c      |    2 +-
 drivers/ata/pata_macio.c       |    6 +++---
 drivers/ata/pata_ninja32.c     |    2 +-
 drivers/ata/pata_ns87415.c     |    2 +-
 drivers/ata/pata_pdc2027x.c    |    2 +-
 drivers/ata/pata_rdc.c         |    2 +-
 drivers/ata/pata_rz1000.c      |    2 +-
 drivers/ata/pata_serverworks.c |    2 +-
 drivers/ata/pata_sil680.c      |    2 +-
 drivers/ata/pata_sis.c         |    2 +-
 drivers/ata/pata_sl82c105.c    |    2 +-
 drivers/ata/pata_triflex.c     |    2 +-
 drivers/ata/pata_via.c         |    2 +-
 drivers/ata/sata_inic162x.c    |    2 +-
 drivers/ata/sata_nv.c          |    2 +-
 drivers/ata/sata_sil.c         |    2 +-
 drivers/ata/sata_sil24.c       |    2 +-
 30 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 9d0cf01..fd665d9 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -128,7 +128,7 @@ static struct pci_driver acard_ahci_pci_driver = {
 #ifdef CONFIG_PM
 static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 ctl;
@@ -156,7 +156,7 @@ static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg
 
 static int acard_ahci_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 751f1ea..9ec4d2d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -618,7 +618,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 #ifdef CONFIG_PM
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 ctl;
@@ -646,7 +646,7 @@ static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 static int ahci_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9a8a674..cb06c8d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -993,7 +993,7 @@ static int piix_broken_suspend(void)
 
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned long flags;
 	int rc = 0;
 
@@ -1028,7 +1028,7 @@ static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 static int piix_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned long flags;
 	int rc;
 
@@ -1751,7 +1751,7 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 static void piix_remove_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	struct piix_host_priv *hpriv = host->private_data;
 
 	pci_write_config_dword(pdev, PIIX_IOCFG, hpriv->saved_iocfg);
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 61da069..1b7b2cc 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -592,7 +592,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int ali_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 82a0892..d23e2b3 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -578,7 +578,7 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int amd_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 74b215c..1581dee 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -426,7 +426,7 @@ static const struct pci_device_id artop_pci_tbl[] = {
 #ifdef CONFIG_PM
 static int atp8xx_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 041f50d..2ca5026 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -534,7 +534,7 @@ err_out:
 #ifdef CONFIG_PM
 static int atp867x_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 504b98b..8fb69e5 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -235,7 +235,7 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int cmd640_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 2949cfc..1275a8d 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -491,7 +491,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int cmd64x_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index bfcf377..f10baab 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -241,7 +241,7 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static int cs5520_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	u8 pcicfg;
 	int rc;
 
@@ -269,7 +269,7 @@ static int cs5520_reinit_one(struct pci_dev *pdev)
 
 static int cs5520_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc = 0;
 
 	rc = ata_host_suspend(host, mesg);
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 48389ae..f07f229 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -330,7 +330,7 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int cs5530_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 4be884a..35b5213 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -390,7 +390,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int hpt36x_reinit_one(struct pci_dev *dev)
 {
-	struct ata_host *host = dev_get_drvdata(&dev->dev);
+	struct ata_host *host = pci_get_drvdata(dev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(dev);
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 76c9314..85cf286 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -253,7 +253,7 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int hpt3x3_reinit_one(struct pci_dev *dev)
 {
-	struct ata_host *host = dev_get_drvdata(&dev->dev);
+	struct ata_host *host = pci_get_drvdata(dev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(dev);
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 9cc05d8..581e04d 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -939,7 +939,7 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM
 static int it821x_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e5725ed..c28d064 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1311,7 +1311,7 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 
 static void pata_macio_pci_detach(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 
 	ata_host_detach(host);
 }
@@ -1320,14 +1320,14 @@ static void pata_macio_pci_detach(struct pci_dev *pdev)
 
 static int pata_macio_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 
 	return pata_macio_do_suspend(host->private_data, mesg);
 }
 
 static int pata_macio_pci_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 
 	return pata_macio_do_resume(host->private_data);
 }
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 12010ed..9513e07 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -157,7 +157,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 static int ninja32_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 6f6fa10..16dc3a6 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -389,7 +389,7 @@ static const struct pci_device_id ns87415_pci_tbl[] = {
 #ifdef CONFIG_PM
 static int ns87415_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index c76e659..9d874c8 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -765,7 +765,7 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 #ifdef CONFIG_PM
 static int pdc2027x_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned int board_idx;
 	int rc;
 
diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 6a86655..79a970f 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -364,7 +364,7 @@ static int rdc_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 static void rdc_remove_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	struct rdc_host_priv *hpriv = host->private_data;
 
 	pci_write_config_dword(pdev, 0x54, hpriv->saved_iocfg);
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 60f4de2..040b093 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -105,7 +105,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 #ifdef CONFIG_PM
 static int rz1000_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index f3febbc..96c6a79 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -440,7 +440,7 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 #ifdef CONFIG_PM
 static int serverworks_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 64c5f0d..c4b0b07 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -407,7 +407,7 @@ use_ioports:
 #ifdef CONFIG_PM
 static int sil680_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int try_mmio, rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 2d5ac13..1e83636 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -873,7 +873,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_PM
 static int sis_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 738e000..6816911 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -341,7 +341,7 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 #ifdef CONFIG_PM
 static int sl82c105_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index c8e589d..94473da 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -211,7 +211,7 @@ static const struct pci_device_id triflex[] = {
 #ifdef CONFIG_PM
 static int triflex_ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc = 0;
 
 	rc = ata_host_suspend(host, mesg);
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 8d2a9fd..c3ab9a6 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -673,7 +673,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static int via_reinit_one(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 1e6827c..e451317 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -776,7 +776,7 @@ static int init_controller(void __iomem *mmio_base, u16 hctl)
 #ifdef CONFIG_PM
 static int inic_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	struct inic_host_priv *hpriv = host->private_data;
 	int rc;
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 85ee499..d74def8 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2435,7 +2435,7 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_PM
 static int nv_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	struct nv_host_priv *hpriv = host->private_data;
 	int rc;
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 0ae3ca4..d67fc35 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -805,7 +805,7 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_PM
 static int sil_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 59f0d63..aa1051b 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1353,7 +1353,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_PM
 static int sil24_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	void __iomem *host_base = host->iomap[SIL24_HOST_BAR];
 	int rc;
 
-- 
1.7.10.4


