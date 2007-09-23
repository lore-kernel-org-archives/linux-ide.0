From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: misc updates for AN
Date: Sun, 23 Sep 2007 13:14:11 +0900
Message-ID: <11905208512312-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:63937 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbXIWEOX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545849wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:22 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update AN support in preparation of PMP support.

* s/ata_id_has_AN/ata_id_has_atapi_AN/
* add AN enabled reporting during configuration
* add err_mask to AN configuration failure reporting
* update LOCKING comment for ata_scsi_media_change_notify()
* check whether ATA dev is attached to SCSI dev ata_scsi_media_change_notify()
* set ATA_FLAG_AN in ahci and sata_sil24

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Kriten Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/ata/ahci.c        |    2 +-
 drivers/ata/libata-core.c |   24 ++++++++++++++----------
 drivers/ata/libata-scsi.c |    7 ++++---
 drivers/ata/sata_sil24.c  |   13 +++++++++++--
 include/linux/ata.h       |    2 +-
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b721569..0a6b694 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -177,7 +177,7 @@ enum {
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-					  ATA_FLAG_ACPI_SATA,
+					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN,
 	AHCI_LFLAG_COMMON		= ATA_LFLAG_SKIP_D2H_BSY,
 };
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2116f27..63274b6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2012,7 +2012,8 @@ int ata_dev_configure(struct ata_device *dev)
 
 	/* ATAPI-specific feature tests */
 	else if (dev->class == ATA_DEV_ATAPI) {
-		char *cdb_intr_string = "";
+		const char *cdb_intr_string = "";
+		const char *atapi_an_string = "";
 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
@@ -2028,16 +2029,19 @@ int ata_dev_configure(struct ata_device *dev)
 		 * check to see if this ATAPI device supports
 		 * Asynchronous Notification
 		 */
-		if ((ap->flags & ATA_FLAG_AN) && ata_id_has_AN(id)) {
-			int err;
+		if ((ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id)) {
+			unsigned int err_mask;
+
 			/* issue SET feature command to turn this on */
-			err = ata_dev_set_AN(dev, SETFEATURES_SATA_ENABLE);
-			if (err)
+			err_mask = ata_dev_set_AN(dev, SETFEATURES_SATA_ENABLE);
+			if (err_mask)
 				ata_dev_printk(dev, KERN_ERR,
-						"unable to set AN, err %x\n",
-						err);
-			else
+					"failed to enable ATAPI AN "
+					"(err_mask=0x%x)\n", err_mask);
+			else {
 				dev->flags |= ATA_DFLAG_AN;
+				atapi_an_string = ", ATAPI AN";
+			}
 		}
 
 		if (ata_id_cdb_intr(dev->id)) {
@@ -2048,10 +2052,10 @@ int ata_dev_configure(struct ata_device *dev)
 		/* print device info to dmesg */
 		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO,
-				       "ATAPI: %s, %s, max %s%s\n",
+				       "ATAPI: %s, %s, max %s%s%s\n",
 				       modelbuf, fwrevbuf,
 				       ata_mode_string(xfer_mask),
-				       cdb_intr_string);
+				       cdb_intr_string, atapi_an_string);
 	}
 
 	/* determine max_sectors */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 35284b3..518d475 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3161,12 +3161,13 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
  *	event.
  *
  * 	LOCKING:
- * 	interrupt context, may not sleep.
+ * 	spin_lock_irqsave(host lock)
  */
-void ata_scsi_media_change_notify(struct ata_device *atadev)
+void ata_scsi_media_change_notify(struct ata_device *dev)
 {
 #ifdef OTHER_AN_PATCHES_HAVE_BEEN_APPLIED
-	scsi_device_event_notify(atadev->sdev, SDEV_MEDIA_CHANGE);
+	if (dev->sdev)
+		scsi_device_event_notify(dev->sdev, SDEV_MEDIA_CHANGE);
 #endif
 }
 EXPORT_SYMBOL_GPL(ata_scsi_media_change_notify);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 3dcb223..d9c010a 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -168,7 +168,7 @@ enum {
 
 	DEF_PORT_IRQ		= PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
 				  PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG |
-				  PORT_IRQ_UNK_FIS,
+				  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_NOTIFY,
 
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
@@ -237,7 +237,8 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA,
+				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
+				  ATA_FLAG_AN,
 	SIL24_COMMON_LFLAGS	= ATA_LFLAG_SKIP_D2H_BSY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
@@ -818,6 +819,14 @@ static void sil24_error_intr(struct ata_port *ap)
 
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
+	if (irq_stat & PORT_IRQ_SDB_NOTIFY) {
+		struct ata_device *dev = ap->link.device;
+
+		ata_ehi_push_desc(ehi, "SDB notify");
+		if (dev->flags & ATA_DFLAG_AN)
+			ata_scsi_media_change_notify(dev);
+	}
+
 	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
 		ata_ehi_hotplugged(ehi);
 		ata_ehi_push_desc(ehi, "%s",
diff --git a/include/linux/ata.h b/include/linux/ata.h
index a749f00..21f00a0 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -353,7 +353,7 @@ struct ata_taskfile {
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[48] & (1 << 0))
-#define ata_id_has_AN(id)	\
+#define ata_id_has_atapi_AN(id)	\
 	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
 	  ((id)[78] & (1 << 5)) )
 #define ata_id_iordy_disable(id) ((id)[49] & (1 << 10))
-- 
1.5.0.3


