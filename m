From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 3/3] Update users of ACPI-SATA/PATA functions
Date: Fri, 23 Jun 2006 14:40:37 +0800
Message-ID: <1151044837.7132.156.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27554 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932903AbWFWGxT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jun 2006 02:53:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, rdunlap@xenotime.net, htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Update users of ACPI-SATA functions.


Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 drivers/scsi/libata-eh.c   |    5 ++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

0ac97b2689bb2a55a38b6161d5a716c5f7e387ed
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a11b674..6f705a2 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1446,6 +1446,9 @@ int ata_dev_configure(struct ata_device 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
+	rc = ata_acpi_push_id(ap, dev->devno);
+	if (rc) goto err_out_nosup;
+
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
 	return 0;
 
@@ -1533,6 +1536,9 @@ static int ata_bus_probe(struct ata_port
 		goto fail;
 	}
 
+	/* retrieve and execute the ATA task file of _GTF */
+	ata_acpi_exec_tfs(ap);
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		if (ata_dev_enabled(&ap->device[i]))
 			return 0;
@@ -5005,6 +5011,9 @@ int ata_device_resume(struct ata_device 
 	if (dev->class == ATA_DEV_ATA)
 		ata_start_drive(dev);
 
+	/* retrieve and execute the ATA task file of _GTF */
+	ata_acpi_exec_tfs(ap);
+
 	return 0;
 }
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 531a4e1..aacf37e 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1711,13 +1711,16 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
-	/* configure transfer mode if the port has been reset */
+	/* configure transfer mode and execute task file of _GTF
+	 * if the port has been reset.
+	 */
 	if (ehc->i.flags & ATA_EHI_DID_RESET) {
 		rc = ata_set_mode(ap, &dev);
 		if (rc) {
 			down_xfermask = 1;
 			goto dev_fail;
 		}
+		ata_acpi_exec_tfs(ap);
 	}
 
 	goto out;
-- 
1.2.6
