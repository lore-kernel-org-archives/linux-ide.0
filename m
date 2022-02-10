Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2AC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiBJTWZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:22:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiBJTWW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 14:22:22 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F52AB
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 11:22:18 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 25C1520CAD97
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 2/3] ata: pata_hpt37x: disable fast interrupts in prereset() method
Date:   Thu, 10 Feb 2022 22:22:13 +0300
Message-ID: <20220210192214.14205-3-s.shtylyov@omp.ru>
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

The PIO/DMA mode setting functions are hardly a good place for disabling
the fast interrupts on a channel -- let's move that code to the driver's
prereset() method instead.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_hpt37x.c | 48 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 7abc7e04f656..cb0fcee02de3 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.23"
+#define DRV_VERSION	"0.6.24"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -394,6 +394,7 @@ static int hpt37x_pre_reset(struct ata_link *link, unsigned long deadline)
 		{ 0x50, 1, 0x04, 0x04 },
 		{ 0x54, 1, 0x04, 0x04 }
 	};
+	u8 mcr2;
 
 	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
 		return -ENOENT;
@@ -402,6 +403,20 @@ static int hpt37x_pre_reset(struct ata_link *link, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
+	/*
+	 * Disable the "fast interrupt" prediction.  Don't hold off
+	 * on interrupts. (== 0x01 despite what the docs say)
+	 */
+	pci_read_config_byte(pdev, 0x51 + 4 * ap->port_no, &mcr2);
+	/* Is it HPT370/A? */
+	if (pdev->device == PCI_DEVICE_ID_TTI_HPT366 && pdev->revision < 5) {
+		mcr2 &= ~0x02;
+		mcr2 |= 0x01;
+	} else {
+		mcr2 &= ~0x07;
+	}
+	pci_write_config_byte(pdev, 0x51 + 4 * ap->port_no, mcr2);
+
 	return ata_sff_prereset(link, deadline);
 }
 
@@ -409,18 +424,8 @@ static void hpt370_set_mode(struct ata_port *ap, struct ata_device *adev,
 			    u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 addr1, addr2;
+	int addr = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
 	u32 reg, timing, mask;
-	u8 fast;
-
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	addr2 = 0x51 + 4 * ap->port_no;
-
-	/* Fast interrupt prediction disable, hold off interrupt disable */
-	pci_read_config_byte(pdev, addr2, &fast);
-	fast &= ~0x02;
-	fast |= 0x01;
-	pci_write_config_byte(pdev, addr2, fast);
 
 	/* Determine timing mask and find matching mode entry */
 	if (mode < XFER_MW_DMA_0)
@@ -432,9 +437,9 @@ static void hpt370_set_mode(struct ata_port *ap, struct ata_device *adev,
 
 	timing = hpt37x_find_mode(ap, mode);
 
-	pci_read_config_dword(pdev, addr1, &reg);
+	pci_read_config_dword(pdev, addr, &reg);
 	reg = (reg & ~mask) | (timing & mask);
-	pci_write_config_dword(pdev, addr1, reg);
+	pci_write_config_dword(pdev, addr, reg);
 }
 /**
  *	hpt370_set_piomode		-	PIO setup
@@ -503,17 +508,8 @@ static void hpt372_set_mode(struct ata_port *ap, struct ata_device *adev,
 			    u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 addr1, addr2;
+	int addr = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
 	u32 reg, timing, mask;
-	u8 fast;
-
-	addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	addr2 = 0x51 + 4 * ap->port_no;
-
-	/* Fast interrupt prediction disable, hold off interrupt disable */
-	pci_read_config_byte(pdev, addr2, &fast);
-	fast &= ~0x07;
-	pci_write_config_byte(pdev, addr2, fast);
 
 	/* Determine timing mask and find matching mode entry */
 	if (mode < XFER_MW_DMA_0)
@@ -525,9 +521,9 @@ static void hpt372_set_mode(struct ata_port *ap, struct ata_device *adev,
 
 	timing = hpt37x_find_mode(ap, mode);
 
-	pci_read_config_dword(pdev, addr1, &reg);
+	pci_read_config_dword(pdev, addr, &reg);
 	reg = (reg & ~mask) | (timing & mask);
-	pci_write_config_dword(pdev, addr1, reg);
+	pci_write_config_dword(pdev, addr, reg);
 }
 
 /**
-- 
2.26.3

