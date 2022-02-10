Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D7C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiBJTWZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:22:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiBJTWW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 14:22:22 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1DBB60
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 11:22:19 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7D5C520A8A2B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 3/3] ata: pata_hpt3x2n: disable fast interrupts in prereset() method
Date:   Thu, 10 Feb 2022 22:22:14 +0300
Message-ID: <20220210192214.14205-4-s.shtylyov@omp.ru>
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
 drivers/ata/pata_hpt3x2n.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index b36090808890..1f6afd8ee29b 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.17"
+#define DRV_VERSION	"0.3.18"
 
 enum {
 	PCI66		=	(1 << 1),
@@ -166,6 +166,7 @@ static int hpt3x2n_pre_reset(struct ata_link *link, unsigned long deadline)
 		{ 0x50, 1, 0x04, 0x04 },
 		{ 0x54, 1, 0x04, 0x04 }
 	};
+	u8 mcr2;
 
 	if (!pci_test_config_bits(pdev, &hpt3x2n_enable_bits[ap->port_no]))
 		return -ENOENT;
@@ -174,6 +175,11 @@ static int hpt3x2n_pre_reset(struct ata_link *link, unsigned long deadline)
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
 
+	/* Fast interrupt prediction disable, hold off interrupt disable */
+	pci_read_config_byte(pdev, 0x51 + 4 * ap->port_no, &mcr2);
+	mcr2 &= ~0x07;
+	pci_write_config_byte(pdev, 0x51 + 4 * ap->port_no, mcr2);
+
 	return ata_sff_prereset(link, deadline);
 }
 
@@ -181,17 +187,8 @@ static void hpt3x2n_set_mode(struct ata_port *ap, struct ata_device *adev,
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
@@ -203,9 +200,9 @@ static void hpt3x2n_set_mode(struct ata_port *ap, struct ata_device *adev,
 
 	timing = hpt3x2n_find_mode(ap, mode);
 
-	pci_read_config_dword(pdev, addr1, &reg);
+	pci_read_config_dword(pdev, addr, &reg);
 	reg = (reg & ~mask) | (timing & mask);
-	pci_write_config_dword(pdev, addr1, reg);
+	pci_write_config_dword(pdev, addr, reg);
 }
 
 /**
-- 
2.26.3

