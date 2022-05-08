Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05ADC4332F
	for <linux-ide@archiver.kernel.org>; Sun,  8 May 2022 20:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiEHUpp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 8 May 2022 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiEHUpi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 8 May 2022 16:45:38 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5914EAE68
        for <linux-ide@vger.kernel.org>; Sun,  8 May 2022 13:41:43 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 94BB520BFC9A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 2/3] ata: make ata_device::{pio|mwdma|udma}_mask *unsigned int*
Date:   Sun, 8 May 2022 23:41:38 +0300
Message-ID: <20220508204139.4961-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220508204139.4961-1-s.shtylyov@omp.ru>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The {pio|mwdma|udma}_mask fields of the *struct* ata_device are declared
as *unsigned long* (which is a 64-bit type on 64-bit architectures) while
the actual masks should easily fit into just 8 bits. The alike fields in
the *struct* ata_port are already declared as *unsigned int*, so follow
the suit, converting ata_[un]pack_xfermask() as necessary...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-acpi.c |  3 +--
 drivers/ata/libata-core.c | 18 +++++++++---------
 include/linux/libata.h    | 18 +++++++++---------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index cdb7c0238a43..61b4ccf88bf1 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -525,8 +525,7 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 	struct ata_device *dev;
 
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
-		unsigned long udma_mask;
-		unsigned int xfer_mask;
+		unsigned int xfer_mask, udma_mask;
 
 		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
 		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a6f301c3359..44af61dfba77 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -418,7 +418,7 @@ static void ata_force_xfermask(struct ata_device *dev)
 
 	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
 		const struct ata_force_ent *fe = &ata_force_tbl[i];
-		unsigned long pio_mask, mwdma_mask, udma_mask;
+		unsigned int pio_mask, mwdma_mask, udma_mask;
 
 		if (fe->port != -1 && fe->port != dev->link->ap->print_id)
 			continue;
@@ -796,11 +796,11 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
  *	RETURNS:
  *	Packed xfer_mask.
  */
-unsigned int ata_pack_xfermask(unsigned long pio_mask,
-			       unsigned long mwdma_mask,
-			       unsigned long udma_mask)
+unsigned int ata_pack_xfermask(unsigned int pio_mask,
+			       unsigned int mwdma_mask,
+			       unsigned int udma_mask)
 {
-	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
+	return	((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
 		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
 		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
 }
@@ -816,8 +816,8 @@ EXPORT_SYMBOL_GPL(ata_pack_xfermask);
  *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
  *	Any NULL destination masks will be ignored.
  */
-void ata_unpack_xfermask(unsigned int xfer_mask, unsigned long *pio_mask,
-			 unsigned long *mwdma_mask, unsigned long *udma_mask)
+void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
+			 unsigned int *mwdma_mask, unsigned int *udma_mask)
 {
 	if (pio_mask)
 		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
@@ -1378,7 +1378,7 @@ static inline void ata_dump_id(struct ata_device *dev, const u16 *id)
  */
 unsigned int ata_id_xfermask(const u16 *id)
 {
-	unsigned long pio_mask, mwdma_mask, udma_mask;
+	unsigned int pio_mask, mwdma_mask, udma_mask;
 
 	/* Usual case. Word 53 indicates word 64 is valid */
 	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
@@ -3191,7 +3191,7 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 {
 	char buf[32];
 	unsigned int orig_mask, xfer_mask;
-	unsigned long pio_mask, mwdma_mask, udma_mask;
+	unsigned int pio_mask, mwdma_mask, udma_mask;
 	int quiet, highbit;
 
 	quiet = !!(sel & ATA_DNXFER_QUIET);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1429b7012ae8..f6fc482d767a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -677,9 +677,9 @@ struct ata_device {
 	unsigned int		cdb_len;
 
 	/* per-dev xfer mask */
-	unsigned long		pio_mask;
-	unsigned long		mwdma_mask;
-	unsigned long		udma_mask;
+	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
+	unsigned int		udma_mask;
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
@@ -1100,13 +1100,13 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
 extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
 			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
-extern unsigned int ata_pack_xfermask(unsigned long pio_mask,
-				      unsigned long mwdma_mask,
-				      unsigned long udma_mask);
+extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
+				      unsigned int mwdma_mask,
+				      unsigned int udma_mask);
 extern void ata_unpack_xfermask(unsigned int xfer_mask,
-				unsigned long *pio_mask,
-				unsigned long *mwdma_mask,
-				unsigned long *udma_mask);
+				unsigned int *pio_mask,
+				unsigned int *mwdma_mask,
+				unsigned int *udma_mask);
 extern u8 ata_xfer_mask2mode(unsigned int xfer_mask);
 extern unsigned int ata_xfer_mode2mask(u8 xfer_mode);
 extern int ata_xfer_mode2shift(u8 xfer_mode);
-- 
2.26.3

