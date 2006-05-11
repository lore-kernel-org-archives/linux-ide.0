From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/10] libata-pm: add PM related constants, fields, ops and update helpers
Date: Fri, 12 May 2006 01:43:42 +0900
Message-ID: <11473658221807-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:17050 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030341AbWEKQnt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:49 -0400
Received: by wr-out-0506.google.com with SMTP id 55so370074wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:49 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PM related constants, fields and ops.  Also, update
ata_class_enabled/disabled() such that PM classes are considered.

---

 include/linux/libata.h |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

0b01a8f6e5988eac0df74062857194288714042a
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bbfd176..c25d8d2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -139,7 +139,9 @@ enum {
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
 	ATA_DEV_ATAPI		= 3,	/* ATAPI device */
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
-	ATA_DEV_NONE		= 5,	/* no device */
+	ATA_DEV_PM		= 5,	/* SATA port multiplier */
+	ATA_DEV_PM_UNSUP	= 6,	/* SATA port multiplier (unsupported) */
+	ATA_DEV_NONE		= 7,	/* no device */
 
 	ATA_DEV_ERING_SIZE	= 32,	/* record 32 recent errors */
 
@@ -161,6 +163,8 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
 					      * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
+	ATA_FLAG_PM		= (1 << 12), /* host supports port multiplier */
+	ATA_FLAG_SDB_NOTIFY	= (1 << 13), /* host support SDB notify */
 
 	ATA_FLAG_DEBUGMSG	= (1 << 14),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
@@ -263,6 +267,9 @@ enum {
 	ATA_PROBE_MAX_TRIES	= 3,
 	ATA_EH_RESET_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
+	ATA_EH_PM_TRIES		= 5,
+	ATA_EH_PM_RESET_TRIES	= 2,
+	ATA_EH_PM_LINK_TRIES	= 2,
 
 	/* timing constants in millisecs */
 	ATA_DEBOUNCE_QUICK_INTERVAL	= 5,
@@ -272,6 +279,8 @@ enum {
 	ATA_DEBOUNCE_INTERVAL	= 10,
 	ATA_DEBOUNCE_DURATION	= 500,
 	ATA_DEBOUNCE_TIMEOUT	= 10000,
+
+	ATA_PM_SCR_TIMEOUT	= 500,
 };
 
 enum hsm_task_states {
@@ -433,7 +442,12 @@ struct ata_device {
 	/* fields above n_sectors are not cleared across device init */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
-	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+
+	union {
+		u16		id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+		u32		gscr[ATA_PM_GSCR_DWORDS]; /* PM GSCR block */
+	};
+
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
@@ -580,6 +594,12 @@ struct ata_port_operations {
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
+	/* port multiplier */
+	void (*pm_attach) (struct ata_port *ap);
+	void (*pm_detach) (struct ata_port *ap);
+	int (*pm_read) (struct ata_device *dev, int pmp, int reg, u32 *r_val);
+	int (*pm_write) (struct ata_device *dev, int pmp, int reg, u32 val);
+
 	/* Error handlers.  ->error_handler overrides ->eng_timeout and
 	 * indicates that new-style EH is in place.
 	 */
@@ -894,12 +914,14 @@ static inline unsigned int ata_tag_inter
  */
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
-	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
+	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI ||
+		class == ATA_DEV_PM;
 }
 
 static inline unsigned int ata_class_disabled(unsigned int class)
 {
-	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP;
+	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP ||
+		class == ATA_DEV_PM_UNSUP;
 }
 
 static inline unsigned int ata_class_absent(unsigned int class)
-- 
1.2.4


