From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/10] libata-acpi: add new hooks ata_acpi_dissociate() and ata_acpi_on_disable()
Date: Sat, 15 Dec 2007 15:05:01 +0900
Message-ID: <1197698707574-git-send-email-htejun@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:53450 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351AbXLOGF0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193515rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:24 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add two hooks - ata_acpi_dissociate() which is called during driver
detach after the whole host is shutdown and ata_acpi_on_disable()
which is called when a device is disabled.

Signed-off-by: Tejun heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   28 ++++++++++++++++++++++++++++
 drivers/ata/libata-core.c |    4 ++++
 drivers/ata/libata.h      |    8 ++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 8ae36ad..9e5fc5d 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -188,6 +188,21 @@ void ata_acpi_associate(struct ata_host *host)
 }
 
 /**
+ * ata_acpi_dissociate - dissociate ATA host from ACPI objects
+ * @host: target ATA host
+ *
+ * This function is called during driver detach after the whole host
+ * is shut down.
+ *
+ * LOCKING:
+ * EH context.
+ */
+void ata_acpi_dissociate(struct ata_host *host)
+{
+	/* nada */
+}
+
+/**
  * ata_acpi_gtm - execute _GTM
  * @ap: target ATA port
  * @gtm: out parameter for _GTM result
@@ -716,3 +731,16 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 	dev->flags |= ATA_DFLAG_ACPI_FAILED;
 	return rc;
 }
+
+/**
+ * ata_acpi_on_disable - ATA ACPI hook called when a device is disabled
+ * @dev: target ATA device
+ *
+ * This function is called when @dev is about to be disabled.
+ *
+ * LOCKING:
+ * EH context.
+ */
+void ata_acpi_on_disable(struct ata_device *dev)
+{
+}
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a8131e5..0e21322 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -622,6 +622,7 @@ void ata_dev_disable(struct ata_device *dev)
 	if (ata_dev_enabled(dev)) {
 		if (ata_msg_drv(dev->link->ap))
 			ata_dev_printk(dev, KERN_WARNING, "disabled\n");
+		ata_acpi_on_disable(dev);
 		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 |
 					     ATA_DNXFER_QUIET);
 		dev->class++;
@@ -7247,6 +7248,9 @@ void ata_host_detach(struct ata_host *host)
 
 	for (i = 0; i < host->n_ports; i++)
 		ata_port_detach(host->ports[i]);
+
+	/* the host is dead now, dissociate ACPI */
+	ata_acpi_dissociate(host);
 }
 
 /**
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0e6cf3a..bbe59c2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -108,15 +108,19 @@ extern void ata_lpm_schedule(struct ata_port *ap, enum link_pm);
 #ifdef CONFIG_ATA_ACPI
 extern void ata_acpi_associate_sata_port(struct ata_port *ap);
 extern void ata_acpi_associate(struct ata_host *host);
+extern void ata_acpi_dissociate(struct ata_host *host);
 extern int ata_acpi_on_suspend(struct ata_port *ap);
 extern void ata_acpi_on_resume(struct ata_port *ap);
-extern int ata_acpi_on_devcfg(struct ata_device *adev);
+extern int ata_acpi_on_devcfg(struct ata_device *dev);
+extern void ata_acpi_on_disable(struct ata_device *dev);
 #else
 static inline void ata_acpi_associate_sata_port(struct ata_port *ap) { }
 static inline void ata_acpi_associate(struct ata_host *host) { }
+static inline void ata_acpi_dissociate(struct ata_host *host) { }
 static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
 static inline void ata_acpi_on_resume(struct ata_port *ap) { }
-static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
+static inline int ata_acpi_on_devcfg(struct ata_device *dev) { return 0; }
+static inline void ata_acpi_on_disable(struct ata_device *dev) { }
 #endif
 
 /* libata-scsi.c */
-- 
1.5.2.4

