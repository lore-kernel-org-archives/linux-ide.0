From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata-pmp-prep: add PMP related constants, fields, ops and update helpers
Date: Sun, 23 Sep 2007 13:14:12 +0900
Message-ID: <11905208521816-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:50630 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbXIWEOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1140954rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:19 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PMP related constants, fields and ops.  Also, update
ata_class_enabled/disabled() such that PMP classes are considered.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3ab2196..c3820f1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -155,7 +155,11 @@ enum {
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
 	ATA_DEV_ATAPI		= 3,	/* ATAPI device */
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
-	ATA_DEV_NONE		= 5,	/* no device */
+	ATA_DEV_PMP		= 5,	/* SATA port multiplier */
+	ATA_DEV_PMP_UNSUP	= 6,	/* SATA port multiplier (unsupported) */
+	ATA_DEV_SEMB		= 7,	/* SEMB */
+	ATA_DEV_SEMB_UNSUP	= 8,	/* SEMB (unsupported) */
+	ATA_DEV_NONE		= 9,	/* no device */
 
 	/* struct ata_link flags */
 	ATA_LFLAG_HRST_TO_RESUME = (1 << 0), /* hardreset to resume link */
@@ -181,6 +185,7 @@ enum {
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
 	ATA_FLAG_AN		= (1 << 18), /* controller supports AN */
+	ATA_FLAG_PMP		= (1 << 19), /* controller supports PMP */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
@@ -299,6 +304,10 @@ enum {
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
+	ATA_EH_PMP_TRIES	= 5,
+	ATA_EH_PMP_LINK_TRIES	= 3,
+
+	SATA_PMP_SCR_TIMEOUT	= 250,
 
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependant */
@@ -450,7 +459,12 @@ struct ata_device {
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
@@ -628,6 +642,12 @@ struct ata_port_operations {
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
@@ -1033,12 +1053,14 @@ static inline unsigned int ata_tag_internal(unsigned int tag)
  */
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
-	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
+	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI ||
+		class == ATA_DEV_PMP || class == ATA_DEV_SEMB;
 }
 
 static inline unsigned int ata_class_disabled(unsigned int class)
 {
-	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP;
+	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP ||
+		class == ATA_DEV_PMP_UNSUP || class == ATA_DEV_SEMB_UNSUP;
 }
 
 static inline unsigned int ata_class_absent(unsigned int class)
-- 
1.5.0.3


