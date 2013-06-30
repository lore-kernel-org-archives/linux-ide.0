From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] libata: move 'struct ata_taskfile' and friends from ata.h to libata.h
Date: Mon, 1 Jul 2013 00:01:32 +0400
Message-ID: <201307010001.32816.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:41001 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab3F3UBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jun 2013 16:01:35 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so3638685lab.23
        for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2013 13:01:33 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Move 'struct ata_taskfile', ata_prot_flags() and their friends from
<linux/ata.h> to <linux/libata.h>. They were misplaced from the beginning,  as
<linux/ata.h> should cover ATA/ATAPI and related standards only -- to which the
aforementioned structure and function have only remote relation. 

I would have moved 'enum ata_tf_protocols' closely related to 'struct
ata_taskfile' but it unfortunately gets used by 'drivers/ide/ide-ioctls.c'...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against 'for-3.11' branch of Tejun Heo's 'libata.git' repo.

I could have published this patch back in August 2012 when it was created but I
did hope to finish work on the rest of the patchset some time which has happened
only now, and unfortunately it became clear that some more debugging is needed. 

 include/linux/ata.h    |  102 -------------------------------------------------
 include/linux/libata.h |  102 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 102 deletions(-)

Index: libata/include/linux/ata.h
===================================================================
--- libata.orig/include/linux/ata.h
+++ libata/include/linux/ata.h
@@ -446,22 +446,6 @@ enum {
 	SERR_TRANS_ST_ERROR	= (1 << 24), /* Transport state trans. error */
 	SERR_UNRECOG_FIS	= (1 << 25), /* Unrecognized FIS */
 	SERR_DEV_XCHG		= (1 << 26), /* device exchanged */
-
-	/* struct ata_taskfile flags */
-	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
-	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
-	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
-	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
-	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
-	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
-	ATA_TFLAG_POLLING	= (1 << 6), /* set nIEN to 1 and use polling */
-
-	/* protocol flags */
-	ATA_PROT_FLAG_PIO	= (1 << 0), /* is PIO */
-	ATA_PROT_FLAG_DMA	= (1 << 1), /* is DMA */
-	ATA_PROT_FLAG_DATA	= ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
-	ATA_PROT_FLAG_NCQ	= (1 << 2), /* is NCQ */
-	ATA_PROT_FLAG_ATAPI	= (1 << 3), /* is ATAPI */
 };
 
 enum ata_tf_protocols {
@@ -488,83 +472,6 @@ struct ata_bmdma_prd {
 	__le32			flags_len;
 };
 
-struct ata_taskfile {
-	unsigned long		flags;		/* ATA_TFLAG_xxx */
-	u8			protocol;	/* ATA_PROT_xxx */
-
-	u8			ctl;		/* control reg */
-
-	u8			hob_feature;	/* additional data */
-	u8			hob_nsect;	/* to support LBA48 */
-	u8			hob_lbal;
-	u8			hob_lbam;
-	u8			hob_lbah;
-
-	u8			feature;
-	u8			nsect;
-	u8			lbal;
-	u8			lbam;
-	u8			lbah;
-
-	u8			device;
-
-	u8			command;	/* IO operation */
-};
-
-/*
- * protocol tests
- */
-static inline unsigned int ata_prot_flags(u8 prot)
-{
-	switch (prot) {
-	case ATA_PROT_NODATA:
-		return 0;
-	case ATA_PROT_PIO:
-		return ATA_PROT_FLAG_PIO;
-	case ATA_PROT_DMA:
-		return ATA_PROT_FLAG_DMA;
-	case ATA_PROT_NCQ:
-		return ATA_PROT_FLAG_DMA | ATA_PROT_FLAG_NCQ;
-	case ATAPI_PROT_NODATA:
-		return ATA_PROT_FLAG_ATAPI;
-	case ATAPI_PROT_PIO:
-		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_PIO;
-	case ATAPI_PROT_DMA:
-		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_DMA;
-	}
-	return 0;
-}
-
-static inline int ata_is_atapi(u8 prot)
-{
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_ATAPI;
-}
-
-static inline int ata_is_nodata(u8 prot)
-{
-	return !(ata_prot_flags(prot) & ATA_PROT_FLAG_DATA);
-}
-
-static inline int ata_is_pio(u8 prot)
-{
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_PIO;
-}
-
-static inline int ata_is_dma(u8 prot)
-{
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_DMA;
-}
-
-static inline int ata_is_ncq(u8 prot)
-{
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_NCQ;
-}
-
-static inline int ata_is_data(u8 prot)
-{
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
-}
-
 /*
  * id tests
  */
@@ -1060,15 +967,6 @@ static inline unsigned ata_set_lba_range
 	return used_bytes;
 }
 
-static inline int is_multi_taskfile(struct ata_taskfile *tf)
-{
-	return (tf->command == ATA_CMD_READ_MULTI) ||
-	       (tf->command == ATA_CMD_WRITE_MULTI) ||
-	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
-	       (tf->command == ATA_CMD_WRITE_MULTI_EXT) ||
-	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
-}
-
 static inline bool ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
Index: libata/include/linux/libata.h
===================================================================
--- libata.orig/include/linux/libata.h
+++ libata/include/linux/libata.h
@@ -138,6 +138,22 @@ enum {
 	ATA_SHT_THIS_ID		= -1,
 	ATA_SHT_USE_CLUSTERING	= 1,
 
+	/* struct ata_taskfile flags */
+	ATA_TFLAG_LBA48		= (1 << 0), /* enable 48-bit LBA and "HOB" */
+	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
+	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
+	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
+	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
+	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
+	ATA_TFLAG_POLLING	= (1 << 6), /* set nIEN to 1 and use polling */
+
+	/* protocol flags */
+	ATA_PROT_FLAG_PIO	= (1 << 0), /* is PIO */
+	ATA_PROT_FLAG_DMA	= (1 << 1), /* is DMA */
+	ATA_PROT_FLAG_DATA	= ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
+	ATA_PROT_FLAG_NCQ	= (1 << 2), /* is NCQ */
+	ATA_PROT_FLAG_ATAPI	= (1 << 3), /* is ATAPI */
+
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
@@ -518,6 +534,29 @@ enum sw_activity {
 	BLINK_OFF,
 };
 
+struct ata_taskfile {
+	unsigned long		flags;		/* ATA_TFLAG_xxx */
+	u8			protocol;	/* ATA_PROT_xxx */
+
+	u8			ctl;		/* control reg */
+
+	u8			hob_feature;	/* additional data */
+	u8			hob_nsect;	/* to support LBA48 */
+	u8			hob_lbal;
+	u8			hob_lbam;
+	u8			hob_lbah;
+
+	u8			feature;
+	u8			nsect;
+	u8			lbal;
+	u8			lbam;
+	u8			lbah;
+
+	u8			device;
+
+	u8			command;	/* IO operation */
+};
+
 #ifdef CONFIG_ATA_SFF
 struct ata_ioports {
 	void __iomem		*cmd_addr;
@@ -959,6 +998,69 @@ extern const unsigned long sata_deb_timi
 extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
+/*
+ * protocol tests
+ */
+static inline unsigned int ata_prot_flags(u8 prot)
+{
+	switch (prot) {
+	case ATA_PROT_NODATA:
+		return 0;
+	case ATA_PROT_PIO:
+		return ATA_PROT_FLAG_PIO;
+	case ATA_PROT_DMA:
+		return ATA_PROT_FLAG_DMA;
+	case ATA_PROT_NCQ:
+		return ATA_PROT_FLAG_DMA | ATA_PROT_FLAG_NCQ;
+	case ATAPI_PROT_NODATA:
+		return ATA_PROT_FLAG_ATAPI;
+	case ATAPI_PROT_PIO:
+		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_PIO;
+	case ATAPI_PROT_DMA:
+		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_DMA;
+	}
+	return 0;
+}
+
+static inline int ata_is_atapi(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_ATAPI;
+}
+
+static inline int ata_is_nodata(u8 prot)
+{
+	return !(ata_prot_flags(prot) & ATA_PROT_FLAG_DATA);
+}
+
+static inline int ata_is_pio(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_PIO;
+}
+
+static inline int ata_is_dma(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_DMA;
+}
+
+static inline int ata_is_ncq(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_NCQ;
+}
+
+static inline int ata_is_data(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
+}
+
+static inline int is_multi_taskfile(struct ata_taskfile *tf)
+{
+	return (tf->command == ATA_CMD_READ_MULTI) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI) ||
+	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
+}
+
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
 {
