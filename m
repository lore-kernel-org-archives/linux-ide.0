From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] libata: Add three more columns to the ata_timing table.
Date: Mon, 24 Nov 2008 17:39:40 -0800
Message-ID: <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:60065 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbYKYBjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 20:39:46 -0500
In-Reply-To: <492B56B0.9030409@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>

The forthcoming OCTEON SOC Compact Flash driver needs a few more
timing values than were available in the ata_timing table.  I add new
columns for write_hold, read_hold, and read_holdz times.  The values
were obtained from the Compact Flash specification Rev 4.1.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
 include/linux/libata.h    |   14 ++++++--
 2 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4214bfb..b29b7df 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2946,33 +2946,33 @@ int sata_set_spd(struct ata_link *link)
  */
 
 static const struct ata_timing ata_timing[] = {
-/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 }, */
-	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },
-	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
-	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
-	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
-	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
-	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 },
-	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 },
-
-	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
-	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
-	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
-
-	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
-	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
-	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
-	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
-	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
-
-/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 }, */
-	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
-	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
-	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
-	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
-	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
-	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
-	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
+/*	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 30, 5, 30, 960,   0 }, */
+	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 30, 5, 30, 600,   0 },
+	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 20, 5, 30, 383,   0 },
+	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 15, 5, 30, 240,   0 },
+	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 10, 5, 30, 180,   0 },
+	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 10, 5, 30, 120,   0 },
+	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25,  5, 5, 20, 100,   0 },
+	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  5, 5, 20,  80,   0 },
+
+	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 30, 5, 0,  960,   0 },
+	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 30, 5, 0,  480,   0 },
+	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 15, 5, 0,  240,   0 },
+
+	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 20, 20, 0, 480,   0 },
+	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 15, 5, 0,  150,   0 },
+	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 10, 5, 0,  120,   0 },
+	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25,  5, 5, 0,  100,   0 },
+	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  5, 5, 0,   80,   0 },
+
+/*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,  0, 0, 0,    0, 150 }, */
+	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0, 120 },
+	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0,  80 },
+	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0,  60 },
+	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0,  45 },
+	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0,  30 },
+	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0,  20 },
+	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,  0, 0, 0,    0,  15 },
 
 	{ 0xFF }
 };
@@ -2982,14 +2982,17 @@ static const struct ata_timing ata_timing[] = {
 
 static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
 {
-	q->setup   = EZ(t->setup   * 1000,  T);
-	q->act8b   = EZ(t->act8b   * 1000,  T);
-	q->rec8b   = EZ(t->rec8b   * 1000,  T);
-	q->cyc8b   = EZ(t->cyc8b   * 1000,  T);
-	q->active  = EZ(t->active  * 1000,  T);
-	q->recover = EZ(t->recover * 1000,  T);
-	q->cycle   = EZ(t->cycle   * 1000,  T);
-	q->udma    = EZ(t->udma    * 1000, UT);
+	q->setup	= EZ(t->setup      * 1000,  T);
+	q->act8b	= EZ(t->act8b      * 1000,  T);
+	q->rec8b	= EZ(t->rec8b      * 1000,  T);
+	q->cyc8b	= EZ(t->cyc8b      * 1000,  T);
+	q->active	= EZ(t->active     * 1000,  T);
+	q->recover	= EZ(t->recover    * 1000,  T);
+	q->write_hold	= EZ(t->write_hold * 1000,  T);
+	q->read_hold	= EZ(t->read_hold  * 1000,  T);
+	q->read_holdz	= EZ(t->read_holdz * 1000,  T);
+	q->cycle	= EZ(t->cycle      * 1000,  T);
+	q->udma		= EZ(t->udma       * 1000, UT);
 }
 
 void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
@@ -3001,6 +3004,9 @@ void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
 	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
 	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
 	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
+	if (what & ATA_TIMING_WRITE_HOLD) m->write_hold = max(a->write_hold, b->write_hold);
+	if (what & ATA_TIMING_READ_HOLD) m->read_hold = max(a->read_hold, b->read_hold);
+	if (what & ATA_TIMING_READ_HOLDZ) m->read_holdz = max(a->read_holdz, b->read_holdz);
 	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
 	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 59b0f1c..7c44e45 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -398,12 +398,17 @@ enum {
 				  ATA_TIMING_CYC8B,
 	ATA_TIMING_ACTIVE	= (1 << 4),
 	ATA_TIMING_RECOVER	= (1 << 5),
-	ATA_TIMING_CYCLE	= (1 << 6),
-	ATA_TIMING_UDMA		= (1 << 7),
+	ATA_TIMING_WRITE_HOLD	= (1 << 6),
+	ATA_TIMING_READ_HOLD	= (1 << 7),
+	ATA_TIMING_READ_HOLDZ	= (1 << 8),
+	ATA_TIMING_CYCLE	= (1 << 9),
+	ATA_TIMING_UDMA		= (1 << 10),
 	ATA_TIMING_ALL		= ATA_TIMING_SETUP | ATA_TIMING_ACT8B |
 				  ATA_TIMING_REC8B | ATA_TIMING_CYC8B |
 				  ATA_TIMING_ACTIVE | ATA_TIMING_RECOVER |
-				  ATA_TIMING_CYCLE | ATA_TIMING_UDMA,
+				  ATA_TIMING_WRITE_HOLD | ATA_TIMING_READ_HOLD |
+				  ATA_TIMING_READ_HOLDZ | ATA_TIMING_CYCLE |
+				  ATA_TIMING_UDMA,
 };
 
 enum ata_xfer_mask {
@@ -863,6 +868,9 @@ struct ata_timing {
 	unsigned short cyc8b;		/* t0 for 8-bit I/O */
 	unsigned short active;		/* t2 or tD */
 	unsigned short recover;		/* t2i or tK */
+	unsigned short write_hold;	/* t4 */
+	unsigned short read_hold;	/* t6 */
+	unsigned short read_holdz;	/* t6z  or tj */
 	unsigned short cycle;		/* t0 */
 	unsigned short udma;		/* t2CYCTYP/2 */
 };
-- 
1.5.6.5

