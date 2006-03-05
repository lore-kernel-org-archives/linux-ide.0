From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] libata: improve xfer mask constants and update ata_mode_string()
Date: Mon, 6 Mar 2006 04:31:56 +0900
Message-ID: <11415871161551-git-send-email-htejun@gmail.com>
References: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:10851 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751795AbWCETcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:01 -0500
Received: by pproxy.gmail.com with SMTP id i75so637258pye
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:00 -0800 (PST)
In-Reply-To: <11415871161709-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ATA_BITS_*, ATA_MASK_* macros and reorder xfer_mask fields such
that higher transfer mode is placed at higher order bit.  As thie
reordering breaks ata_mode_string(), this patch also rewrites
ata_mode_string().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   44 +++++++++++++++++---------------------------
 include/linux/libata.h     |   16 ++++++++++++----
 2 files changed, 29 insertions(+), 31 deletions(-)

ae787be679d5411a1877134ba7d2cfbc7e1cdb69
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6d8aa86..18418c8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -232,6 +232,14 @@ int ata_rwcmd_protocol(struct ata_queued
 }
 
 static const char * const xfer_mode_str[] = {
+	"PIO0",
+	"PIO1",
+	"PIO2",
+	"PIO3",
+	"PIO4",
+	"MWDMA0",
+	"MWDMA1",
+	"MWDMA2",
 	"UDMA/16",
 	"UDMA/25",
 	"UDMA/33",
@@ -240,49 +248,31 @@ static const char * const xfer_mode_str[
 	"UDMA/100",
 	"UDMA/133",
 	"UDMA7",
-	"MWDMA0",
-	"MWDMA1",
-	"MWDMA2",
-	"PIO0",
-	"PIO1",
-	"PIO2",
-	"PIO3",
-	"PIO4",
 };
 
 /**
- *	ata_udma_string - convert UDMA bit offset to string
- *	@mask: mask of bits supported; only highest bit counts.
+ *	ata_mode_string - convert xfer_mask to string
+ *	@xfer_mask: mask of bits supported; only highest bit counts.
  *
  *	Determine string which represents the highest speed
- *	(highest bit in @udma_mask).
+ *	(highest bit in @modemask).
  *
  *	LOCKING:
  *	None.
  *
  *	RETURNS:
  *	Constant C string representing highest speed listed in
- *	@udma_mask, or the constant C string "<n/a>".
+ *	@mode_mask, or the constant C string "<n/a>".
  */
 
-static const char *ata_mode_string(unsigned int mask)
+static const char *ata_mode_string(unsigned int xfer_mask)
 {
-	int i;
-
-	for (i = 7; i >= 0; i--)
-		if (mask & (1 << i))
-			goto out;
-	for (i = ATA_SHIFT_MWDMA + 2; i >= ATA_SHIFT_MWDMA; i--)
-		if (mask & (1 << i))
-			goto out;
-	for (i = ATA_SHIFT_PIO + 4; i >= ATA_SHIFT_PIO; i--)
-		if (mask & (1 << i))
-			goto out;
+	int highbit;
 
+	highbit = fls(xfer_mask) - 1;
+	if (highbit >= 0 && highbit < ARRAY_SIZE(xfer_mode_str))
+		return xfer_mode_str[highbit];
 	return "<n/a>";
-
-out:
-	return xfer_mode_str[i];
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1567492..239408e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -188,11 +188,19 @@ enum {
 	PORT_DISABLED		= 2,
 
 	/* encoding various smaller bitmaps into a single
-	 * unsigned long bitmap
+	 * unsigned int bitmap
 	 */
-	ATA_SHIFT_UDMA		= 0,
-	ATA_SHIFT_MWDMA		= 8,
-	ATA_SHIFT_PIO		= 11,
+	ATA_BITS_PIO		= 5,
+	ATA_BITS_MWDMA		= 3,
+	ATA_BITS_UDMA		= 8,
+
+	ATA_SHIFT_PIO		= 0,
+	ATA_SHIFT_MWDMA		= ATA_SHIFT_PIO + ATA_BITS_PIO,
+	ATA_SHIFT_UDMA		= ATA_SHIFT_MWDMA + ATA_BITS_MWDMA,
+
+	ATA_MASK_PIO		= ((1 << ATA_BITS_PIO) - 1) << ATA_SHIFT_PIO,
+	ATA_MASK_MWDMA		= ((1 << ATA_BITS_MWDMA) - 1) << ATA_SHIFT_MWDMA,
+	ATA_MASK_UDMA		= ((1 << ATA_BITS_UDMA) - 1) << ATA_SHIFT_UDMA,
 
 	/* size of buffer to pad xfers ending on unaligned boundaries */
 	ATA_DMA_PAD_SZ		= 4,
-- 
1.2.4


