From: Nate Watterson <nwatters@codeaurora.org>
Subject: [PATCH] ata: ahci_platform: Add shutdown handler
Date: Thu, 20 Jul 2017 15:26:24 -0400
Message-ID: <1500578784-15407-1-git-send-email-nwatters@codeaurora.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbdGTTb6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jul 2017 15:31:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nate Watterson <nwatters@codeaurora.org>

The newly introduced ahci_platform_shutdown() method is called during
system shutdown to disable host controller DMA and interrupts in order
to avoid potentially corrupting or otherwise interfering with a new
kernel being started with kexec.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/ata/ahci_platform.c    |  1 +
 drivers/ata/libahci_platform.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/ahci_platform.h  |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 62a04c8..99f9a89 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -93,6 +93,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
 	.remove = ata_platform_remove_one,
+	.shutdown = ahci_platform_shutdown,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_of_match,
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index cd2eab6..a270a11 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -602,6 +602,40 @@ static void ahci_host_stop(struct ata_host *host)
 	ahci_platform_disable_resources(hpriv);
 }
 
+/**
+ * ahci_platform_shutdown - Disable interrupts and stop DMA for host ports
+ * @dev: platform device pointer for the host
+ *
+ * This function is called during system shutdown and performs the minimal
+ * deconfiguration required to ensure that an ahci_platform host cannot
+ * corrupt or otherwise interfere with a new kernel being started with kexec.
+ */
+void ahci_platform_shutdown(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	int i;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		/* Disable port interrupts */
+		if (ap->ops->freeze)
+			ap->ops->freeze(ap);
+
+		/* Stop the port DMA engines */
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+	}
+
+	/* Disable and clear host interrupts */
+	writel(readl(mmio + HOST_CTL) & ~HOST_IRQ_EN, mmio + HOST_CTL);
+	readl(mmio + HOST_CTL); /* flush */
+	writel(GENMASK(host->n_ports, 0), mmio + HOST_IRQ_STAT);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_shutdown);
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * ahci_platform_suspend_host - Suspend an ahci-platform host
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index a270f25e..1b0a17b 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -36,6 +36,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 			    const struct ata_port_info *pi_template,
 			    struct scsi_host_template *sht);
 
+void ahci_platform_shutdown(struct platform_device *pdev);
+
 int ahci_platform_suspend_host(struct device *dev);
 int ahci_platform_resume_host(struct device *dev);
 int ahci_platform_suspend(struct device *dev);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.

