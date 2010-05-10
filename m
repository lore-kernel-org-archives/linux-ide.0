From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/23] pata_sch: use ata_pci_sff_init_one()
Date: Mon, 10 May 2010 21:41:25 +0200
Message-ID: <1273520507-32459-2-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44922 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755782Ab0EJTmJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:09 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

pata_sch is standard SFF.  No reason to open code init.  Use
ata_pci_sff_init_one() instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_sch.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index 99cceb4..86b3d01 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -174,22 +174,12 @@ static int __devinit sch_init_one(struct pci_dev *pdev,
 {
 	static int printed_version;
 	const struct ata_port_info *ppi[] = { &sch_port_info, NULL };
-	struct ata_host *host;
-	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	/* enable device and prepare host */
-	rc = pcim_enable_device(pdev);
-	if (rc)
-		return rc;
-	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
-	if (rc)
-		return rc;
-	pci_set_master(pdev);
-	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &sch_sht);
+	return ata_pci_sff_init_one(pdev, ppi, &sch_sht, NULL, 0);
 }
 
 static int __init sch_init(void)
-- 
1.6.4.2

