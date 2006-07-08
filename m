From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata-pmp: add PMP related constants, fields, ops and update helpers
Date: Sat, 8 Jul 2006 14:58:07 +0900
Message-ID: <1152338287794-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.205]:45040 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964790AbWGHF5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:16 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206439wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:15 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PMP related constants, fields and ops.  Also, update
ata_class_enabled/disabled() such that PMP classes are considered.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

5ec84546db9b2cc5da979d3543f3939beeca1aca
diff --git a/include/linux/libata.h b/include/linux/libata.h
index dea1e5f..dce5ab8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -128,6 +128,7 @@ enum {
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
 	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_NCQ		= (1 << 3), /* device supports NCQ */
+	ATA_DFLAG_PMP_HRST_TO_RESUME = (1 << 4), /* requires hardreset */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
@@ -142,7 +143,9 @@ enum {
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
 	ATA_DEV_ATAPI		= 3,	/* ATAPI device */
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
-	ATA_DEV_NONE		= 5,	/* no device */
+	ATA_DEV_PMP		= 5,	/* SATA port multiplier */
+	ATA_DEV_PMP_UNSUP	= 6,	/* SATA port multiplier (unsupported) */
+	ATA_DEV_NONE		= 7,	/* no device */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -163,6 +166,8 @@ enum {
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_HP_POLLING	= (1 << 14), /* hotplug by polling */
+	ATA_FLAG_PMP		= (1 << 14),
+	ATA_FLAG_SDB_NOTIFY	= (1 << 15),
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -284,6 +289,9 @@ enum {
 	ATA_PROBE_MAX_TRIES	= 3,
 	ATA_EH_RESET_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
+	ATA_EH_PMP_TRIES	= 5,
+	ATA_EH_PMP_RESET_TRIES	= 2,
+	ATA_EH_PMP_LINK_TRIES	= 2,
 
 	/* Drive spinup time (time from power-on to the first D2H FIS)
 	 * in msecs - 8s currently.  Failing to get ready in this time
@@ -293,6 +301,8 @@ enum {
 	 * most devices.
 	 */
 	ATA_SPINUP_WAIT		= 8000,
+
+	SATA_PMP_SCR_TIMEOUT	= 500,
 };
 
 enum hsm_task_states {
@@ -450,7 +460,12 @@ struct ata_device {
 	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
-	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+
+	union {
+		u16		id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
+	};
+
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
@@ -509,6 +524,8 @@ struct ata_link {
 	unsigned int		active_tag;	/* active tag on this link */
 	u32			sactive;	/* active NCQ commands */
 
+	unsigned int		flags;		/* ATA_LFLAG_xxx */
+
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;
 
@@ -617,6 +634,12 @@ struct ata_port_operations {
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
+	/* port multiplier */
+	void (*pmp_attach) (struct ata_port *ap);
+	void (*pmp_detach) (struct ata_port *ap);
+	int (*pmp_read) (struct ata_device *dev, int pmp, int reg, u32 *r_val);
+	int (*pmp_write) (struct ata_device *dev, int pmp, int reg, u32 val);
+
 	/* Error handlers.  ->error_handler overrides ->eng_timeout and
 	 * indicates that new-style EH is in place.
 	 */
@@ -977,12 +1000,14 @@ static inline unsigned int ata_tag_inter
  */
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
-	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
+	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI ||
+		class == ATA_DEV_PMP;
 }
 
 static inline unsigned int ata_class_disabled(unsigned int class)
 {
-	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP;
+	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP ||
+		class == ATA_DEV_PMP_UNSUP;
 }
 
 static inline unsigned int ata_class_absent(unsigned int class)
-- 
1.3.2


