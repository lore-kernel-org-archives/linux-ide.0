Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D49C352A2
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9455E20726
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 10:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgBGKAZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:00:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGKAZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 05:00:25 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j00Qx-0006gM-4C; Fri, 07 Feb 2020 10:00:23 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     axboe@kernel.dk
Cc:     anthony.wong@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: ahci: Add sysfs attribute to show remapped NVMe device count
Date:   Fri,  7 Feb 2020 18:00:16 +0800
Message-Id: <20200207100016.32605-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add a new sysfs attribute to show how many NVMe devices are remapped.

Userspace like distro installer can use this info to ask user to change
the BIOS setting.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/ata/ahci.c | 28 ++++++++++++++++++++++++----
 drivers/ata/ahci.h |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11ea1aff40db..cdbd995a7a6b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1488,7 +1488,7 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 static void ahci_remap_check(struct pci_dev *pdev, int bar,
 		struct ahci_host_priv *hpriv)
 {
-	int i, count = 0;
+	int i;
 	u32 cap;
 
 	/*
@@ -1509,13 +1509,14 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
 			continue;
 
 		/* We've found a remapped device */
-		count++;
+		hpriv->remapped_nvme++;
 	}
 
-	if (!count)
+	if (!hpriv->remapped_nvme)
 		return;
 
-	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
+	dev_warn(&pdev->dev, "Found %u remapped NVMe devices.\n",
+		 hpriv->remapped_nvme);
 	dev_warn(&pdev->dev,
 		 "Switch your BIOS from RAID to AHCI mode to use them.\n");
 
@@ -1635,6 +1636,18 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
 	}
 }
 
+static ssize_t remapped_nvme_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	return sprintf(buf, "%u\n", hpriv->remapped_nvme);
+}
+
+static DEVICE_ATTR_RO(remapped_nvme);
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1735,6 +1748,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
 
+	sysfs_add_file_to_group(&pdev->dev.kobj,
+				&dev_attr_remapped_nvme.attr,
+				NULL);
+
 	/* must set flag prior to save config in order to take effect */
 	if (ahci_broken_devslp(pdev))
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
@@ -1886,6 +1903,9 @@ static void ahci_shutdown_one(struct pci_dev *pdev)
 
 static void ahci_remove_one(struct pci_dev *pdev)
 {
+	sysfs_remove_file_from_group(&pdev->dev.kobj,
+				     &dev_attr_remapped_nvme.attr,
+				     NULL);
 	pm_runtime_get_noresume(&pdev->dev);
 	ata_pci_remove_one(pdev);
 }
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 3dbf398c92ea..d991dd46e89c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -336,6 +336,7 @@ struct ahci_host_priv {
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
+	u32			remapped_nvme;	/* NVMe remapped device count */
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct reset_control	*rsts;		/* Optional */
-- 
2.17.1

