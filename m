From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/10] libata-acpi: implement dev->gtf_cache and evaluate _GTF right after _STM during resume
Date: Sat, 15 Dec 2007 15:05:03 +0900
Message-ID: <11976987073001-git-send-email-htejun@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:52978 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbXLOGFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193512rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:19 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

On certain implementations, _GTF evaluation depends on preceding _STM
and both can be pretty picky about the configuration.  Using _GTM
result cached during controller initialization satisfies the most
neurotic _STM implementation.  However, libata evaluates _GTF after
reset during device configuration and the hardware state can be
different from what _GTF expects and can cause evaluation failure.

This patch adds dev->gtf_cache and updates ata_dev_get_GTF() such that
it uses the cached value if available.  Cache is cleared with a call
to ata_acpi_clear_gtf().

Because for SATA ACPI nodes _GTF must be evaluated after _SDD which
can't be done till IDENTIFY is complete, _GTF caching from
ata_acpi_on_resume() is used only for IDE ACPI nodes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   69 ++++++++++++++++++++++++++++++++-------------
 include/linux/libata.h    |    1 +
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b3aeca3..e0dd132 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -41,6 +41,12 @@ static int is_pci_dev(struct device *dev)
 	return (dev->bus == &pci_bus_type);
 }
 
+static void ata_acpi_clear_gtf(struct ata_device *dev)
+{
+	kfree(dev->gtf_cache);
+	dev->gtf_cache = NULL;
+}
+
 /**
  * ata_acpi_associate_sata_port - associate SATA port with ACPI objects
  * @ap: target SATA port
@@ -327,7 +333,6 @@ EXPORT_SYMBOL_GPL(ata_acpi_stm);
  * ata_dev_get_GTF - get the drive bootup default taskfile settings
  * @dev: target ATA device
  * @gtf: output parameter for buffer containing _GTF taskfile arrays
- * @ptr_to_free: pointer which should be freed
  *
  * This applies to both PATA and SATA drives.
  *
@@ -344,8 +349,7 @@ EXPORT_SYMBOL_GPL(ata_acpi_stm);
  * Number of taskfiles on success, 0 if _GTF doesn't exist or doesn't
  * contain valid data.
  */
-static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
-			   void **ptr_to_free)
+static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 {
 	struct ata_port *ap = dev->link->ap;
 	acpi_status status;
@@ -353,6 +357,12 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 	union acpi_object *out_obj;
 	int rc = 0;
 
+	/* if _GTF is cached, use the cached value */
+	if (dev->gtf_cache) {
+		out_obj = dev->gtf_cache;
+		goto done;
+	}
+
 	/* set up output buffer */
 	output.length = ACPI_ALLOCATE_BUFFER;
 	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
@@ -363,6 +373,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 
 	/* _GTF has no input parameters */
 	status = acpi_evaluate_object(dev->acpi_handle, "_GTF", NULL, &output);
+	out_obj = dev->gtf_cache = output.pointer;
 
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
@@ -383,7 +394,6 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 		goto out_free;
 	}
 
-	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		ata_dev_printk(dev, KERN_WARNING,
 			       "_GTF unexpected object type 0x%x\n",
@@ -398,18 +408,19 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 		goto out_free;
 	}
 
-	*ptr_to_free = out_obj;
-	*gtf = (void *)out_obj->buffer.pointer;
+ done:
 	rc = out_obj->buffer.length / REGS_PER_GTF;
-
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "%s: returning "
-			"gtf=%p, gtf_count=%d, ptr_to_free=%p\n",
-			__FUNCTION__, *gtf, rc, *ptr_to_free);
+	if (gtf) {
+		*gtf = (void *)out_obj->buffer.pointer;
+		if (ata_msg_probe(ap))
+			ata_dev_printk(dev, KERN_DEBUG,
+				       "%s: returning gtf=%p, gtf_count=%d\n",
+				       __FUNCTION__, *gtf, rc);
+	}
 	return rc;
 
  out_free:
-	kfree(output.pointer);
+	ata_acpi_clear_gtf(dev);
 	return rc;
 }
 
@@ -533,11 +544,10 @@ static int taskfile_load_raw(struct ata_device *dev,
 static int ata_acpi_exec_tfs(struct ata_device *dev)
 {
 	struct ata_acpi_gtf *gtf = NULL;
-	void *ptr_to_free = NULL;
 	int gtf_count, i, rc;
 
 	/* get taskfiles */
-	gtf_count = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
+	gtf_count = ata_dev_get_GTF(dev, &gtf);
 
 	/* execute them */
 	for (i = 0, rc = 0; i < gtf_count; i++) {
@@ -551,7 +561,7 @@ static int ata_acpi_exec_tfs(struct ata_device *dev)
 			rc = tmp;
 	}
 
-	kfree(ptr_to_free);
+	ata_acpi_clear_gtf(dev);
 
 	if (rc == 0)
 		return gtf_count;
@@ -644,13 +654,31 @@ void ata_acpi_on_resume(struct ata_port *ap)
 	const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
 	struct ata_device *dev;
 
-	/* restore timing parameters */
-	if (ap->acpi_handle && gtm)
+	if (ap->acpi_handle && gtm) {
+		/* _GTM valid */
+
+		/* restore timing parameters */
 		ata_acpi_stm(ap, gtm);
 
-	/* schedule _GTF */
-	ata_link_for_each_dev(dev, &ap->link)
-		dev->flags |= ATA_DFLAG_ACPI_PENDING;
+		/* _GTF should immediately follow _STM so that it can
+		 * use values set by _STM.  Cache _GTF result and
+		 * schedule _GTF.
+		 */
+		ata_link_for_each_dev(dev, &ap->link) {
+			ata_acpi_clear_gtf(dev);
+			if (ata_dev_get_GTF(dev, NULL) >= 0)
+				dev->flags |= ATA_DFLAG_ACPI_PENDING;
+		}
+	} else {
+		/* SATA _GTF needs to be evaulated after _SDD and
+		 * there's no reason to evaluate IDE _GTF early
+		 * without _STM.  Clear cache and schedule _GTF.
+		 */
+		ata_link_for_each_dev(dev, &ap->link) {
+			ata_acpi_clear_gtf(dev);
+			dev->flags |= ATA_DFLAG_ACPI_PENDING;
+		}
+	}
 }
 
 /**
@@ -735,4 +763,5 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
  */
 void ata_acpi_on_disable(struct ata_device *dev)
 {
+	ata_acpi_clear_gtf(dev);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ba84d8a..cb91280 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -498,6 +498,7 @@ struct ata_device {
 	struct scsi_device	*sdev;		/* attached SCSI device */
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
+	union acpi_object	*gtf_cache;
 #endif
 	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
 	u64			n_sectors;	/* size of device, if ATA */
-- 
1.5.2.4

