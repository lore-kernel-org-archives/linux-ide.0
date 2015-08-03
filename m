From: Tomer Barletz <barletz@gmail.com>
Subject: [PATCH] Check return code from pdc20621_i2c_read()
Date: Sun,  2 Aug 2015 23:06:34 -0700
Message-ID: <1438581994-23521-1-git-send-email-barletz@gmail.com>
References: <CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33991 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbHCGHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2015 02:07:01 -0400
In-Reply-To: <CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, sergei.shtylyov@cogentembedded.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tomer Barletz <barletz@gmail.com>

The variable spd0 might be used uninitialized when pdc20621_i2c_read()
fails.
This also generates a compilation warning with gcc 5.1.

Signed-off-by: Tomer Barletz <barletz@gmail.com>
---
 drivers/ata/sata_sx4.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 3a18a8a..070b272 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1238,8 +1238,11 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_host *host)
 	readl(mmio + PDC_SDRAM_CONTROL);
 
 	/* Turn on for ECC */
-	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
-			  PDC_DIMM_SPD_TYPE, &spd0);
+	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
+	                       PDC_DIMM_SPD_TYPE, &spd0)) {
+		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
+		return 1;
+	}
 	if (spd0 == 0x02) {
 		data |= (0x01 << 16);
 		writel(data, mmio + PDC_SDRAM_CONTROL);
@@ -1380,8 +1383,11 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	/* ECC initiliazation. */
 
-	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
-			  PDC_DIMM_SPD_TYPE, &spd0);
+	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
+	                       PDC_DIMM_SPD_TYPE, &spd0)) {
+		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
+		return 1;
+	}
 	if (spd0 == 0x02) {
 		void *buf;
 		VPRINTK("Start ECC initialization\n");
-- 
2.4.3

