From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/20] libata: use LLD name where possible
Date: Sat, 19 Aug 2006 17:59:33 +0900
Message-ID: <11559779732719-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:44805 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751656AbWHSI76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:58 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465945pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:58 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

When acquiring resources, use LLD name where possible.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c   |   12 +++++++++++-
 drivers/ata/libata-legacy.c |    2 +-
 drivers/ata/libata-pci.c    |    2 +-
 drivers/ata/libata.h        |    1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4b85c88..96709de 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -103,6 +103,16 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
+const char *ata_drv_name(struct ata_host *host)
+{
+	const char *name = dev_driver_string(host->dev);
+
+	if (name[0] != '\0')
+		return name;
+
+	return DRV_NAME;
+}
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
@@ -5744,7 +5754,7 @@ int ata_host_request_irq_marker(struct a
 		goto err;
 	}
 
-	rc = request_irq(irq, handler, irq_flags, DRV_NAME, dev_id);
+	rc = request_irq(irq, handler, irq_flags, ata_drv_name(host), dev_id);
 	if (rc) {
 		reason = "failed to request IRQ";
 		goto err;
diff --git a/drivers/ata/libata-legacy.c b/drivers/ata/libata-legacy.c
index 00b70b0..c519602 100644
--- a/drivers/ata/libata-legacy.c
+++ b/drivers/ata/libata-legacy.c
@@ -57,7 +57,7 @@ static int ata_legacy_acquire_port(struc
 	struct ata_host *host = ap->host;
 	unsigned long cmd_addr = ata_legacy_addr(ap->port_no, 0);
 
-	if (request_region(cmd_addr, 8, "libata") != NULL)
+	if (request_region(cmd_addr, 8, ata_drv_name(host)) != NULL)
 		host->legacy_flags |= ATA_LEGACY_RES_PRI << ap->port_no;
 	else {
 		struct resource *conflict, res;
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
index 6e2c454..cb61679 100644
--- a/drivers/ata/libata-pci.c
+++ b/drivers/ata/libata-pci.c
@@ -166,7 +166,7 @@ int ata_pci_acquire_resources(struct ata
 		goto err;
 	}
 
-	rc = pci_request_regions(pdev, DRV_NAME);
+	rc = pci_request_regions(pdev, ata_drv_name(host));
 	if (rc) {
 		host->flags |= ATA_HOST_DEV_BUSY;
 		reason = "failed to request PCI regions";
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0601c4a..fcb7a66 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -39,6 +39,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern const char *ata_drv_name(struct ata_host *host);
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
-- 
1.4.1.1


