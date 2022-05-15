Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF3C4332F
	for <linux-ide@archiver.kernel.org>; Sun, 15 May 2022 20:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiEOUll (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 May 2022 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEOUlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2022 16:41:35 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC31ADA6
        for <linux-ide@vger.kernel.org>; Sun, 15 May 2022 13:41:31 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru DBB4E22F1311
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 3/4] ata: pata_hpt37x: merge hpt374_read_freq() to hpt37x_pci_clock()
Date:   Sun, 15 May 2022 23:41:25 +0300
Message-ID: <20220515204126.4866-4-s.shtylyov@omp.ru>
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

With hpt374_read_freq() implemented as a separate function, there's
some code duplication going on, not to mention that this function is
named incorrectly: it returns the f_CNT register value saved by BIOS,
not the PCI clock frequency.
Folding hpt374_read_freq() into hpt37x_pci_clock() saves 20 bytes of
object code with x86_64 gcc 10.3.1...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_hpt37x.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 38fc7f3d593c..d1a3d99d5d0a 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.29"
+#define DRV_VERSION	"0.6.30"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -644,26 +644,6 @@ static int hpt37x_calibrate_dpll(struct pci_dev *dev)
 	return 0;
 }
 
-static u32 hpt374_read_freq(struct pci_dev *pdev)
-{
-	u32 freq;
-	unsigned long io_base = pci_resource_start(pdev, 4);
-
-	if (PCI_FUNC(pdev->devfn) & 1) {
-		struct pci_dev *pdev_0;
-
-		pdev_0 = pci_get_slot(pdev->bus, pdev->devfn - 1);
-		/* Someone hot plugged the controller on us ? */
-		if (pdev_0 == NULL)
-			return 0;
-		io_base = pci_resource_start(pdev_0, 4);
-		freq = inl(io_base + 0x90);
-		pci_dev_put(pdev_0);
-	} else
-		freq = inl(io_base + 0x90);
-	return freq;
-}
-
 static int hpt37x_pci_clock(struct pci_dev *pdev, unsigned int base)
 {
 	unsigned int freq;
@@ -674,10 +654,16 @@ static int hpt37x_pci_clock(struct pci_dev *pdev, unsigned int base)
 	 * according to the old driver. In addition we must use the value
 	 * from FN 0 on the HPT374.
 	 */
-	if (pdev->device == PCI_DEVICE_ID_TTI_HPT374) {
-		fcnt = hpt374_read_freq(pdev);
-		if (!fcnt)
+	if (pdev->device == PCI_DEVICE_ID_TTI_HPT374 &&
+	    (PCI_FUNC(pdev->devfn) & 1)) {
+		struct pci_dev *pdev_fn0;
+
+		pdev_fn0 = pci_get_slot(pdev->bus, pdev->devfn - 1);
+		/* Someone hot plugged the controller on us? */
+		if (!pdev_fn0)
 			return 0;
+		fcnt = inl(pci_resource_start(pdev_fn0, 4) + 0x90);
+		pci_dev_put(pdev_fn0);
 	} else	{
 		fcnt = inl(pci_resource_start(pdev, 4) + 0x90);
 	}
-- 
2.26.3

