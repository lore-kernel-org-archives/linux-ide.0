From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] sil24 defines for ATAPI and PM
Date: Sun, 13 Nov 2005 12:50:07 -0500
Message-ID: <43777CCF.1080001@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080305050205040103010206"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:12182 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751357AbVKMRuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2005 12:50:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Edward Falk <efalk@google.com>

This is a multi-part message in MIME format.
--------------080305050205040103010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's some stuff that should help get ATAPI and port multipliers going. 
      I'll integrate the associated code into the driver eventually, but 
I'm hoping Tejun or somebody will contribute that code for me.

	Jeff




--------------080305050205040103010206
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 55e744d..73803a5 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -139,6 +139,7 @@ enum {
 	PORT_CS_DEV_RST		= (1 << 1), /* device reset */
 	PORT_CS_INIT		= (1 << 2), /* port initialize */
 	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
+	PORT_CS_CDB16		= (1 << 5), /* 0=12b cdb, 1=16b cdb */
 	PORT_CS_RESUME		= (1 << 6), /* port resume */
 	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
 	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
@@ -188,11 +189,36 @@ enum {
 	PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during transfer */
 	PORT_CERR_SENDSERVICE	= 36, /* FIS received while sending service */
 
+	/* bits of PRB control field */
+	CTRL_PROTOCOL		= (1 << 0),  /* override def. ATA protocol */
+	CTRL_PACKET_READ	= (1 << 4),  /* PACKET cmd read */
+	CTRL_PACKET_WRITE	= (1 << 5),  /* PACKET cmd write */
+	CTRL_NIEN		= (1 << 6),  /* Mask completion irq */
+	CTRL_SRST		= (1 << 7),  /* Soft reset request (ign BSY?) */
+
+	/* PRB protocol field */
+	PRB_PROT_PACKET		= (1 << 16),
+	PRB_PROT_TCQ		= (1 << 17),
+	PRB_PROT_NCQ		= (1 << 18),
+	PRB_PROT_READ		= (1 << 19),
+	PRB_PROT_WRITE		= (1 << 20),
+	PRB_PROT_TRANSPARENT	= (1 << 21),
+
+	/* port RAM layout (0x000 - 0xFFF) */
+	RAM_SLOT_SZ		= 0x80,		/* size of one slot */
+	RAM_SLOT_N		= 31,
+	RAM_SLOT_PM_OFS		= 0xf80,
+	RAM_SLOT_PM_SZ		= 8,		/* struct sil24_pm_reg */
+	RAM_SLOT_PM_N		= 16,
+
 	/*
 	 * Other constants
 	 */
 	SGE_TRM			= (1 << 31), /* Last SGE in chain */
-	PRB_SOFT_RST		= (1 << 7),  /* Soft reset request (ign BSY?) */
+	SGE_LNK			= (1 << 30), /* linked list;
+						Points to SGT, not SGE */
+	SGE_DRD			= (1 << 29), /* discard data read (/dev/null) */
+					     /* data address ignored */
 
 	/* board id */
 	BID_SIL3124		= 0,
@@ -207,6 +233,19 @@ struct sil24_cmd_block {
 	struct sil24_sge sge[LIBATA_MAX_PRD];
 };
 
+/* ATAPI PRB */
+struct sil24_atapi_block {
+	struct sil24_prb prb;
+	u8 cdb[16];
+	struct sil24_sge sge[1];
+};
+
+/* per-port multiplier set of registers */
+struct sil24_pm_reg {
+	u32		status;
+	u32		qactive;
+};
+
 /*
  * ap->private_data
  *

--------------080305050205040103010206--
