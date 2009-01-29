From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/8] libata: clear dev->ering in smarter way
Date: Thu, 29 Jan 2009 20:31:32 +0900
Message-ID: <1233228696-10562-5-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34105 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071AbZA2LcF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:32:05 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

dev->ering used to be cleared together with the rest of ata_device in
ata_dev_init() which is called whenever a probing event occurs.
dev->ering is about to be used to track probing failures so it needs
to remain persistent over multiple porbing events.  This patch
achieves this by doing the following.

* Instead of CLEAR_OFFSET, define CLEAR_BEGIN and CLEAR_END and only
  clear between BEGIN and END.  ering is moved after END.  The split
  of persistent area is to allow hotter items remain at the head.

* ering is explicitly cleared on ata_dev_disable() and when device
  attach succeeds.  So, ering is persistent throug a device's life
  time (unless explicitly cleared of course) and also through periods
  inbetween disablement of an attached device and successful detection
  of the next one.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |    4 ++--
 drivers/ata/libata-eh.c   |    7 +++++++
 include/linux/libata.h    |   18 ++++++++++--------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index daf0dec..6a5b8e2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5403,8 +5403,8 @@ void ata_dev_init(struct ata_device *dev)
 	dev->horkage = 0;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
-	       sizeof(*dev) - ATA_DEVICE_CLEAR_OFFSET);
+	memset((void *)dev + ATA_DEVICE_CLEAR_BEGIN, 0,
+	       ATA_DEVICE_CLEAR_END - ATA_DEVICE_CLEAR_BEGIN);
 	dev->pio_mask = UINT_MAX;
 	dev->mwdma_mask = UINT_MAX;
 	dev->udma_mask = UINT_MAX;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index aafe82b..90092c1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1194,6 +1194,11 @@ void ata_dev_disable(struct ata_device *dev)
 	ata_acpi_on_disable(dev);
 	ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 | ATA_DNXFER_QUIET);
 	dev->class++;
+
+	/* From now till the next successful probe, ering is used to
+	 * track probe failures.  Clear accumulated device error info.
+	 */
+	ata_ering_clear(&dev->ering);
 }
 
 /**
@@ -2765,6 +2770,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 						     readid_flags, dev->id);
 			switch (rc) {
 			case 0:
+				/* clear error info accumulated during probe */
+				ata_ering_clear(&dev->ering);
 				new_mask |= 1 << dev->devno;
 				break;
 			case -ENOENT:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b6b8a7f..7d7bc11 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -576,7 +576,7 @@ struct ata_device {
 	acpi_handle		acpi_handle;
 	union acpi_object	*gtf_cache;
 #endif
-	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
+	/* n_sector is CLEAR_BEGIN, read comment above CLEAR_BEGIN */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned long		unpark_deadline;
@@ -601,20 +601,22 @@ struct ata_device {
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
 
-	/* error history */
-	int			spdn_cnt;
-	struct ata_ering	ering;
-
 	union {
 		u16		id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
 	};
+
+	/* error history */
+	int			spdn_cnt;
+	/* ering is CLEAR_END, read comment above CLEAR_END */
+	struct ata_ering	ering;
 };
 
-/* Offset into struct ata_device.  Fields above it are maintained
- * acress device init.  Fields below are zeroed.
+/* Fields between ATA_DEVICE_CLEAR_BEGIN and ATA_DEVICE_CLEAR_END are
+ * cleared to zero on ata_dev_init().
  */
-#define ATA_DEVICE_CLEAR_OFFSET		offsetof(struct ata_device, n_sectors)
+#define ATA_DEVICE_CLEAR_BEGIN		offsetof(struct ata_device, n_sectors)
+#define ATA_DEVICE_CLEAR_END		offsetof(struct ata_device, ering)
 
 struct ata_eh_info {
 	struct ata_device	*dev;		/* offending device */
-- 
1.6.0.2

