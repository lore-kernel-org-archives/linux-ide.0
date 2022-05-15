Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C60C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 15 May 2022 20:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiEOUlm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 May 2022 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiEOUlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2022 16:41:35 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412FC1ADA8
        for <linux-ide@vger.kernel.org>; Sun, 15 May 2022 13:41:31 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 80DB320EC9AB
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 2/4] ata: pata_hpt37x: factor out hpt37x_pci_clock()
Date:   Sun, 15 May 2022 23:41:24 +0300
Message-ID: <20220515204126.4866-3-s.shtylyov@omp.ru>
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

Factor out the PCI clock frequency detection code into hpt37x_pci_clock(),
so that this driver becomes more like 'pata_hpt3x2n'.  Note that I decided
to change the way HPT374 is identified to using the PCI device ID...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_hpt37x.c | 94 +++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 80564ea50966..38fc7f3d593c 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.28"
+#define DRV_VERSION	"0.6.29"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -664,6 +664,53 @@ static u32 hpt374_read_freq(struct pci_dev *pdev)
 	return freq;
 }
 
+static int hpt37x_pci_clock(struct pci_dev *pdev, unsigned int base)
+{
+	unsigned int freq;
+	u32 fcnt;
+
+	/*
+	 * Some devices do not let this value be accessed via PCI space
+	 * according to the old driver. In addition we must use the value
+	 * from FN 0 on the HPT374.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_TTI_HPT374) {
+		fcnt = hpt374_read_freq(pdev);
+		if (!fcnt)
+			return 0;
+	} else	{
+		fcnt = inl(pci_resource_start(pdev, 4) + 0x90);
+	}
+
+	if ((fcnt >> 12) != 0xABCDE) {
+		u32 total = 0;
+		int i;
+		u16 sr;
+
+		dev_warn(&pdev->dev, "BIOS clock data not set\n");
+
+		/* This is the process the HPT371 BIOS is reported to use */
+		for (i = 0; i < 128; i++) {
+			pci_read_config_word(pdev, 0x78, &sr);
+			total += sr & 0x1FF;
+			udelay(15);
+		}
+		fcnt = total / 128;
+	}
+	fcnt &= 0x1FF;
+
+	freq = (fcnt * base) / 192;	/* in MHz */
+
+	/* Clamp to bands */
+	if (freq < 40)
+		return 33;
+	if (freq < 45)
+		return 40;
+	if (freq < 55)
+		return 50;
+	return 66;
+}
+
 /**
  *	hpt37x_init_one		-	Initialise an HPT37X/302
  *	@dev: PCI device
@@ -769,7 +816,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	u8 irqmask;
 	u8 mcr1;
 	unsigned int freq; /* MHz */
-	u32 fcnt;
 	int prefer_dpll = 1;
 
 	unsigned long iobase = pci_resource_start(dev, 4);
@@ -895,47 +941,9 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (chip_table == &hpt372a)
 		outb(0x0e, iobase + 0x9c);
 
-	/*
-	 * Some devices do not let this value be accessed via PCI space
-	 * according to the old driver. In addition we must use the value
-	 * from FN 0 on the HPT374.
-	 */
-
-	if (chip_table == &hpt374) {
-		fcnt = hpt374_read_freq(dev);
-		if (fcnt == 0)
-			return -ENODEV;
-	} else
-		fcnt = inl(iobase + 0x90);
-
-	if ((fcnt >> 12) != 0xABCDE) {
-		int i;
-		u16 sr;
-		u32 total = 0;
-
-		dev_warn(&dev->dev, "BIOS has not set timing clocks\n");
-
-		/* This is the process the HPT371 BIOS is reported to use */
-		for (i = 0; i < 128; i++) {
-			pci_read_config_word(dev, 0x78, &sr);
-			total += sr & 0x1FF;
-			udelay(15);
-		}
-		fcnt = total / 128;
-	}
-	fcnt &= 0x1FF;
-
-	freq = (fcnt * chip_table->base) / 192;	/* Mhz */
-
-	/* Clamp to bands */
-	if (freq < 40)
-		freq = 33;
-	else if (freq < 45)
-		freq = 40;
-	else if (freq < 55)
-		freq = 50;
-	else
-		freq = 66;
+	freq = hpt37x_pci_clock(dev, chip_table->base);
+	if (!freq)
+		return -ENODEV;
 
 	/*
 	 *	Turn the frequency check into a band and then find a timing
-- 
2.26.3

