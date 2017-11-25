From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] pata_pdc2027x: Fix coding sytle error
Date: Sat, 25 Nov 2017 16:04:07 +0530
Message-ID: <68e25992911d7c4d6c17b9f31524a614466d9588.1511605703.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37738 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdKYKeS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Nov 2017 05:34:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org, sergei.shtylyov@cogentembedded.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Fix these checkpatch.pl error:
ERROR: space prohibited before open square bracket '['.

ERROR: space prohibited after that '~' (ctx:WxW)
+		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));

ERROR: spaces required around that '?' (ctx:VxW)
+	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;

ERROR: that open brace { should be on the previous line
+	const struct ata_port_info *ppi[] =
+		{ &pdc2027x_port_info[board_idx], NULL };

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v1:
              These cheange was a part of '[PATCH] pata_pdc2027x:
              Remove unnecessary error check and coding style error'
              and got comment 'Please fix the checkpatch.pl errors
              in a sperate patch'.

 drivers/ata/pata_pdc2027x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 6348a83..d1e8b63 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -84,7 +84,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
  */
 static struct pdc2027x_pio_timing {
 	u8 value0, value1, value2;
-} pdc2027x_pio_timing_tbl [] = {
+} pdc2027x_pio_timing_tbl[] = {
 	{ 0xfb, 0x2b, 0xac }, /* PIO mode 0 */
 	{ 0x46, 0x29, 0xa4 }, /* PIO mode 1 */
 	{ 0x23, 0x26, 0x64 }, /* PIO mode 2 */
@@ -94,7 +94,7 @@ static struct pdc2027x_pio_timing {
 
 static struct pdc2027x_mdma_timing {
 	u8 value0, value1;
-} pdc2027x_mdma_timing_tbl [] = {
+} pdc2027x_mdma_timing_tbl[] = {
 	{ 0xdf, 0x5f }, /* MDMA mode 0 */
 	{ 0x6b, 0x27 }, /* MDMA mode 1 */
 	{ 0x69, 0x25 }, /* MDMA mode 2 */
@@ -102,7 +102,7 @@ static struct pdc2027x_mdma_timing {
 
 static struct pdc2027x_udma_timing {
 	u8 value0, value1, value2;
-} pdc2027x_udma_timing_tbl [] = {
+} pdc2027x_udma_timing_tbl[] = {
 	{ 0x4a, 0x0f, 0xd5 }, /* UDMA mode 0 */
 	{ 0x3a, 0x0a, 0xd0 }, /* UDMA mode 1 */
 	{ 0x2a, 0x07, 0xcd }, /* UDMA mode 2 */
@@ -277,7 +277,7 @@ static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long
 			  ATA_ID_PROD_LEN + 1);
 	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
 	if (strstr(model_num, "Maxtor") == NULL && pair->dma_mode == XFER_UDMA_6)
-		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
+		mask &= ~(1 << (6 + ATA_SHIFT_UDMA));
 
 	return mask;
 }
@@ -520,7 +520,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u16 pll_ctl;
 	long pll_clock_khz = pll_clock / 1000;
-	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
+	long pout_required = board_idx ? PDC_133_MHZ : PDC_100_MHZ;
 	long ratio = pout_required / pll_clock_khz;
 	int F, R;
 
@@ -705,8 +705,8 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 	static const unsigned long cmd_offset[] = { 0x17c0, 0x15c0 };
 	static const unsigned long bmdma_offset[] = { 0x1000, 0x1008 };
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	const struct ata_port_info *ppi[] =
-		{ &pdc2027x_port_info[board_idx], NULL };
+	const struct ata_port_info *ppi[] = {
+		&pdc2027x_port_info[board_idx], NULL };
 	struct ata_host *host;
 	void __iomem *mmio_base;
 	int i, rc;
-- 
2.7.4

