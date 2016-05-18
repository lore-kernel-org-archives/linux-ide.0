From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ata: Use IS_ENABLED() instead of checking for built-in or module
Date: Wed, 18 May 2016 16:11:28 -0400
Message-ID: <1463602288-10393-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60585 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbcERULn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 May 2016 16:11:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/ata/ahci.c         | 2 +-
 drivers/ata/pata_marvell.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a83bbcc58b4c..90eabaf81215 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -580,7 +580,7 @@ static struct pci_driver ahci_pci_driver = {
 	},
 };
 
-#if defined(CONFIG_PATA_MARVELL) || defined(CONFIG_PATA_MARVELL_MODULE)
+#if IS_ENABLED(CONFIG_PATA_MARVELL)
 static int marvell_enable;
 #else
 static int marvell_enable = 1;
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index ae9feb1ba8f7..ff468a6fd8dd 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -146,7 +146,7 @@ static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	if (pdev->device == 0x6101)
 		ppi[1] = &ata_dummy_port_info;
 
-#if defined(CONFIG_SATA_AHCI) || defined(CONFIG_SATA_AHCI_MODULE)
+#if IS_ENABLED(CONFIG_SATA_AHCI)
 	if (!marvell_pata_active(pdev)) {
 		printk(KERN_INFO DRV_NAME ": PATA port not active, deferring to AHCI driver.\n");
 		return -ENODEV;
-- 
2.5.5

