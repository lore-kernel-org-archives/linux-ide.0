Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C9C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiBJTWY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:22:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiBJTWW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 14:22:22 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E676B4A
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 11:22:18 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru DC44B20ABA04
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 1/3] ata: pata_hpt366: disable fast interrupts in prereset() method
Date:   Thu, 10 Feb 2022 22:22:12 +0300
Message-ID: <20220210192214.14205-2-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220210192214.14205-1-s.shtylyov@omp.ru>
References: <20220210192214.14205-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The PIO/DMA mode setting function is hardly a good place for disabling
the fast interrupts on a channel -- let's move that code to the driver's
prereset() method instead.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_hpt366.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 96caa79dc8d7..c99e8f0708b3 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.12"
+#define DRV_VERSION	"0.6.13"
 
 struct hpt_clock {
 	u8	xfer_mode;
@@ -300,10 +300,15 @@ static int hpt366_prereset(struct ata_link *link, unsigned long deadline)
 	static const struct pci_bits hpt366_enable_bits = {
 		0x50, 1, 0x30, 0x30
 	};
+	u8 mcr2;
 
 	if (!pci_test_config_bits(pdev, &hpt366_enable_bits))
 		return -ENOENT;
 
+	pci_read_config_byte(pdev, 0x51, &mcr2);
+	if (mcr2 & 0x80)
+		pci_write_config_byte(pdev, 0x51, mcr2 & ~0x80);
+
 	return ata_sff_prereset(link, deadline);
 }
 
@@ -334,17 +339,13 @@ static struct ata_port_operations hpt366_port_ops = {
 
 static void hpt36x_init_chipset(struct pci_dev *dev)
 {
-	u8 drive_fast, mcr1;
+	u8 mcr1;
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
 	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
 	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	pci_read_config_byte(dev, 0x51, &drive_fast);
-	if (drive_fast & 0x80)
-		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
-
 	/*
 	 * Now we'll have to force both channels enabled if at least one
 	 * of them has been enabled by BIOS...
-- 
2.26.3

