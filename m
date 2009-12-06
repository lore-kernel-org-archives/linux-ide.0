From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 6/6] sata_mv: add power management support for the PCI controllers.
Date: Sun,  6 Dec 2009 18:26:22 +0200
Message-ID: <1260116782-31714-6-git-send-email-saeed@marvell.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
 <1260116782-31714-2-git-send-email-saeed@marvell.com>
 <1260116782-31714-3-git-send-email-saeed@marvell.com>
 <1260116782-31714-4-git-send-email-saeed@marvell.com>
 <1260116782-31714-5-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50760 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbZLFQ03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 11:26:29 -0500
In-Reply-To: <1260116782-31714-5-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 71ac62e..704d86f 100755
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4161,6 +4161,9 @@ static struct platform_driver mv_platform_driver = {
 #ifdef CONFIG_PCI
 static int mv_pci_init_one(struct pci_dev *pdev,
 			   const struct pci_device_id *ent);
+#ifdef CONFIG_PM
+static int mv_pci_device_resume(struct pci_dev *pdev);
+#endif
 
 
 static struct pci_driver mv_pci_driver = {
@@ -4168,6 +4171,11 @@ static struct pci_driver mv_pci_driver = {
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_pci_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= mv_pci_device_resume,
+#endif
+
 };
 
 /* move to PCI layer or libata core? */
@@ -4324,6 +4332,27 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	return ata_host_activate(host, pdev->irq, mv_interrupt, IRQF_SHARED,
 				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
 }
+
+#ifdef CONFIG_PM
+static int mv_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
+	/* initialize adapter */
+	rc = mv_init_host(host);
+	if (rc)
+		return rc;
+
+	ata_host_resume(host);
+
+	return 0;
+}
+#endif
 #endif
 
 static int mv_platform_probe(struct platform_device *pdev);
-- 
1.6.0.4

