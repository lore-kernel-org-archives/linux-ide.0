Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E18FC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 15 May 2022 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiEOUlj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 May 2022 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiEOUlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2022 16:41:35 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B41ADAD
        for <linux-ide@vger.kernel.org>; Sun, 15 May 2022 13:41:31 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 3078F20A4E6F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 4/4] ata: pata_hpt3x2n: pass base DPLL frequency to hpt3x2n_pci_clock()
Date:   Sun, 15 May 2022 23:41:26 +0300
Message-ID: <20220515204126.4866-5-s.shtylyov@omp.ru>
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

Currently, the base DPLL frequency is hardcoded in hpt3x2n_pci_clock().
Align with the updated 'pata_hpt37x' driver, where this frequency is a
parameter to hpt37x_pci_clock().

While at it, also do the following to align with the 'pata_hpt37x' driver:
- fix the 'freq' local variable's type;
- remove the 'iobase' local variable;
- extend the comment to the inl() call;
- move the 'total' local variable's declaration.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_hpt3x2n.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 1f6afd8ee29b..d1595e17dca2 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.18"
+#define DRV_VERSION	"0.3.19"
 
 enum {
 	PCI66		=	(1 << 1),
@@ -403,17 +403,20 @@ static int hpt3xn_calibrate_dpll(struct pci_dev *dev)
 	return 0;
 }
 
-static int hpt3x2n_pci_clock(struct pci_dev *pdev)
+static int hpt3x2n_pci_clock(struct pci_dev *pdev, unsigned int base)
 {
-	unsigned long freq;
+	unsigned int freq;
 	u32 fcnt;
-	unsigned long iobase = pci_resource_start(pdev, 4);
 
-	fcnt = inl(iobase + 0x90);	/* Not PCI readable for some chips */
+	/*
+	 * Some devices do not let this value be accessed via PCI space
+	 * according to the old driver.
+	 */
+	fcnt = inl(pci_resource_start(pdev, 4) + 0x90);
 	if ((fcnt >> 12) != 0xABCDE) {
+		u32 total = 0;
 		int i;
 		u16 sr;
-		u32 total = 0;
 
 		dev_warn(&pdev->dev, "BIOS clock data not set\n");
 
@@ -427,7 +430,7 @@ static int hpt3x2n_pci_clock(struct pci_dev *pdev)
 	}
 	fcnt &= 0x1FF;
 
-	freq = (fcnt * 77) / 192;
+	freq = (fcnt * base) / 192;	/* in MHz */
 
 	/* Clamp to bands */
 	if (freq < 40)
@@ -559,7 +562,7 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	 * 50 for UDMA100. Right now we always use 66
 	 */
 
-	pci_mhz = hpt3x2n_pci_clock(dev);
+	pci_mhz = hpt3x2n_pci_clock(dev, 77);
 
 	f_low = (pci_mhz * 48) / 66;	/* PCI Mhz for 66Mhz DPLL */
 	f_high = f_low + 2;		/* Tolerance */
-- 
2.26.3

