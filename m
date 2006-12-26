From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: handle pci_enable_device() failure while resuming
Date: Tue, 26 Dec 2006 19:39:50 +0900
Message-ID: <20061226103950.GA10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:51302 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932506AbWLZLHG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Dec 2006 06:07:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Handle pci_enable_device() failure while resuming.  This patch kills
the "ignoring return value of 'pci_enable_device'" warning message and
propagates __must_check through ata_pci_device_do_resume().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    4 +++-
 drivers/ata/libata-core.c |   22 +++++++++++++++++-----
 drivers/ata/sata_sil.c    |    6 +++++-
 drivers/ata/sata_sil24.c  |    5 ++++-
 include/linux/libata.h    |    2 +-
 5 files changed, 30 insertions(+), 9 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -6221,12 +6221,22 @@ void ata_pci_device_do_suspend(struct pc
 	}
 }
 
-void ata_pci_device_do_resume(struct pci_dev *pdev)
+int ata_pci_device_do_resume(struct pci_dev *pdev)
 {
+	int rc;
+
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "failed to enable device after resume (%d)\n", rc);
+		return rc;
+	}
+
 	pci_set_master(pdev);
+	return 0;
 }
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
@@ -6246,10 +6256,12 @@ int ata_pci_device_suspend(struct pci_de
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
 
-	ata_pci_device_do_resume(pdev);
-	ata_host_resume(host);
-	return 0;
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc == 0)
+		ata_host_resume(host);
+	return rc;
 }
 #endif /* CONFIG_PCI */
 
Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -1364,7 +1364,9 @@ static int ahci_pci_device_resume(struct
 	void __iomem *mmio = host->mmio_base;
 	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(mmio, pdev);
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -710,8 +710,12 @@ err_out:
 static int sil_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
-	ata_pci_device_do_resume(pdev);
 	sil_init_controller(pdev, host->n_ports, host->ports[0]->flags,
 			    host->mmio_base);
 	ata_host_resume(host);
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -1200,8 +1200,11 @@ static int sil24_pci_device_resume(struc
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct sil24_host_priv *hpriv = host->private_data;
+	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
 		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -715,7 +715,7 @@ extern int ata_pci_init_one (struct pci_
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern void ata_pci_device_do_resume(struct pci_dev *pdev);
+extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);

