From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] libata: add xfer_mask handling functions
Date: Mon, 6 Mar 2006 04:31:56 +0900
Message-ID: <11415871161635-git-send-email-htejun@gmail.com>
References: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:57429 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751805AbWCETcC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:02 -0500
Received: by zproxy.gmail.com with SMTP id 14so1085678nzn
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:01 -0800 (PST)
In-Reply-To: <11415871161709-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ata_pack_xfermask(), ata_xfer_mask2mode(), ata_xfer_mode2mask(),
ata_xfer_mode2shift() and ata_id_xfermask().  These functions will be
used by following patches to simplify xfer_mask handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  147 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 147 insertions(+), 0 deletions(-)

3247748741bb32ca18e3fa3c0dd14690dbd184a6
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 18418c8..9946618 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -231,6 +231,108 @@ int ata_rwcmd_protocol(struct ata_queued
 	return -1;
 }
 
+/**
+ *	ata_pack_xfermask - Pack pio, mwdma and udma masks into xfer_mask
+ *	@pio_mask: pio_mask
+ *	@mwdma_mask: mwdma_mask
+ *	@udma_mask: udma_mask
+ *
+ *	Pack @pio_mask, @mwdma_mask and @udma_mask into a single
+ *	unsigned int xfer_mask.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Packed xfer_mask.
+ */
+static unsigned int ata_pack_xfermask(unsigned int pio_mask,
+				      unsigned int mwdma_mask,
+				      unsigned int udma_mask)
+{
+	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
+		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
+		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
+}
+
+static const struct ata_xfer_ent {
+	unsigned int shift, bits;
+	u8 base;
+} ata_xfer_tbl[] = {
+	{ ATA_SHIFT_PIO, ATA_BITS_PIO, XFER_PIO_0 },
+	{ ATA_SHIFT_MWDMA, ATA_BITS_MWDMA, XFER_MW_DMA_0 },
+	{ ATA_SHIFT_UDMA, ATA_BITS_UDMA, XFER_UDMA_0 },
+	{ -1, },
+};
+
+/**
+ *	ata_xfer_mask2mode - Find matching XFER_* for the given xfer_mask
+ *	@xfer_mask: xfer_mask of interest
+ *
+ *	Return matching XFER_* value for @xfer_mask.  Only the highest
+ *	bit of @xfer_mask is considered.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Matching XFER_* value, 0 if no match found.
+ */
+static u8 ata_xfer_mask2mode(unsigned int xfer_mask)
+{
+	int highbit = fls(xfer_mask) - 1;
+	const struct ata_xfer_ent *ent;
+
+	for (ent = ata_xfer_tbl; ent->shift >= 0; ent++)
+		if (highbit >= ent->shift && highbit < ent->shift + ent->bits)
+			return ent->base + highbit - ent->shift;
+	return 0;
+}
+
+/**
+ *	ata_xfer_mode2mask - Find matching xfer_mask for XFER_*
+ *	@xfer_mode: XFER_* of interest
+ *
+ *	Return matching xfer_mask for @xfer_mode.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Matching xfer_mask, 0 if no match found.
+ */
+static unsigned int ata_xfer_mode2mask(u8 xfer_mode)
+{
+	const struct ata_xfer_ent *ent;
+
+	for (ent = ata_xfer_tbl; ent->shift >= 0; ent++)
+		if (xfer_mode >= ent->base && xfer_mode < ent->base + ent->bits)
+			return 1 << (ent->shift + xfer_mode - ent->base);
+	return 0;
+}
+
+/**
+ *	ata_xfer_mode2shift - Find matching xfer_shift for XFER_*
+ *	@xfer_mode: XFER_* of interest
+ *
+ *	Return matching xfer_shift for @xfer_mode.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Matching xfer_shift, -1 if no match found.
+ */
+static int ata_xfer_mode2shift(unsigned int xfer_mode)
+{
+	const struct ata_xfer_ent *ent;
+
+	for (ent = ata_xfer_tbl; ent->shift >= 0; ent++)
+		if (xfer_mode >= ent->base && xfer_mode < ent->base + ent->bits)
+			return ent->shift;
+	return -1;
+}
+
 static const char * const xfer_mode_str[] = {
 	"PIO0",
 	"PIO1",
@@ -682,6 +784,51 @@ static inline void ata_dump_id(const u16
 		id[93]);
 }
 
+/**
+ *	ata_id_xfermask - Compute xfermask from the given IDENTIFY data
+ *	@id: IDENTIFY data to compute xfer mask from
+ *
+ *	Compute the xfermask for this device. This is not as trivial
+ *	as it seems if we must consider early devices correctly.
+ *
+ *	FIXME: pre IDE drive timing (do we care ?).
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Computed xfermask
+ */
+static unsigned int ata_id_xfermask(const u16 *id)
+{
+	unsigned int pio_mask, mwdma_mask, udma_mask;
+
+	/* Usual case. Word 53 indicates word 64 is valid */
+	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
+		pio_mask = id[ATA_ID_PIO_MODES] & 0x03;
+		pio_mask <<= 3;
+		pio_mask |= 0x7;
+	} else {
+		/* If word 64 isn't valid then Word 51 high byte holds
+		 * the PIO timing number for the maximum. Turn it into
+		 * a mask.
+		 */
+		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
+
+		/* But wait.. there's more. Design your standards by
+		 * committee and you too can get a free iordy field to
+		 * process. However its the speeds not the modes that
+		 * are supported... Note drivers using the timing API
+		 * will get this right anyway
+		 */
+	}
+
+	mwdma_mask = id[ATA_ID_MWDMA_MODES] & 0x07;
+	udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
+
+	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
+}
+
 /*
  *	Compute the PIO modes available for this device. This is not as
  *	trivial as it seems if we must consider early devices correctly.
-- 
1.2.4


