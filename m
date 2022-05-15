Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D6C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 15 May 2022 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiEOUlj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 May 2022 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEOUlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2022 16:41:35 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162F1ADAB
        for <linux-ide@vger.kernel.org>; Sun, 15 May 2022 13:41:31 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 306C120EC9A4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 1/4] ata: pata_hpt37x: move claculating PCI clock from hpt37x_clock_slot()
Date:   Sun, 15 May 2022 23:41:23 +0300
Message-ID: <20220515204126.4866-2-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220515204126.4866-1-s.shtylyov@omp.ru>
References: <20220515204126.4866-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

hpt37x_init_one() incorrectly calls an averaged f_CNT register value 'freq'
and hpt37x_clock_slot() takes that value as the 'freq' parameter -- rename
the former variable to 'fcnt' and move the actual code calculating the PCI
clock from hpt37x_clock_slot() to hpt37x_init_one(), along with adding the
frequency clamping code, in preparation for the factoring out the PCI clock
detection, so that this driver would become more like the 'pata_hpt3x2n'
driver...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_hpt37x.c | 45 ++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 156f304ef051..80564ea50966 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.25"
+#define DRV_VERSION	"0.6.28"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -592,21 +592,19 @@ static struct ata_port_operations hpt374_fn1_port_ops = {
 
 /**
  *	hpt37x_clock_slot	-	Turn timing to PC clock entry
- *	@freq: Reported frequency timing
- *	@base: Base timing
+ *	@freq: Reported frequency in MHz
  *
- *	Turn the timing data intoa clock slot (0 for 33, 1 for 40, 2 for 50
+ *	Turn the timing data into a clock slot (0 for 33, 1 for 40, 2 for 50
  *	and 3 for 66Mhz)
  */
 
-static int hpt37x_clock_slot(unsigned int freq, unsigned int base)
+static int hpt37x_clock_slot(unsigned int freq)
 {
-	unsigned int f = (base * freq) / 192;	/* Mhz */
-	if (f < 40)
+	if (freq < 40)
 		return 0;	/* 33Mhz slot */
-	if (f < 45)
+	if (freq < 45)
 		return 1;	/* 40Mhz slot */
-	if (f < 55)
+	if (freq < 55)
 		return 2;	/* 50Mhz slot */
 	return 3;		/* 60Mhz slot */
 }
@@ -770,7 +768,8 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	u8 rev = dev->revision;
 	u8 irqmask;
 	u8 mcr1;
-	u32 freq;
+	unsigned int freq; /* MHz */
+	u32 fcnt;
 	int prefer_dpll = 1;
 
 	unsigned long iobase = pci_resource_start(dev, 4);
@@ -903,13 +902,13 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	 */
 
 	if (chip_table == &hpt374) {
-		freq = hpt374_read_freq(dev);
-		if (freq == 0)
+		fcnt = hpt374_read_freq(dev);
+		if (fcnt == 0)
 			return -ENODEV;
 	} else
-		freq = inl(iobase + 0x90);
+		fcnt = inl(iobase + 0x90);
 
-	if ((freq >> 12) != 0xABCDE) {
+	if ((fcnt >> 12) != 0xABCDE) {
 		int i;
 		u16 sr;
 		u32 total = 0;
@@ -922,16 +921,28 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 			total += sr & 0x1FF;
 			udelay(15);
 		}
-		freq = total / 128;
+		fcnt = total / 128;
 	}
-	freq &= 0x1FF;
+	fcnt &= 0x1FF;
+
+	freq = (fcnt * chip_table->base) / 192;	/* Mhz */
+
+	/* Clamp to bands */
+	if (freq < 40)
+		freq = 33;
+	else if (freq < 45)
+		freq = 40;
+	else if (freq < 55)
+		freq = 50;
+	else
+		freq = 66;
 
 	/*
 	 *	Turn the frequency check into a band and then find a timing
 	 *	table to match it.
 	 */
 
-	clock_slot = hpt37x_clock_slot(freq, chip_table->base);
+	clock_slot = hpt37x_clock_slot(freq);
 	if (chip_table->clocks[clock_slot] == NULL || prefer_dpll) {
 		/*
 		 *	We need to try PLL mode instead
-- 
2.26.3

