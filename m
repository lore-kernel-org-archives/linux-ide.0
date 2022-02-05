Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BAEC433F5
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 20:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381048AbiBEUeo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 15:34:44 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:34260 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiBEUei (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 15:34:38 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 4F28B2072131
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v4 3/3] pata_artop: use *switch* in atp8xx_fixup()
Date:   Sat, 5 Feb 2022 23:34:34 +0300
Message-ID: <20220205203434.15339-4-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220205203434.15339-1-s.shtylyov@omp.ru>
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This driver uses a string of the *if* statements in atp8xx_fixup() where
a *switch* statement would fit better...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 4:
- new patch.

 drivers/ata/pata_artop.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index d8c388da0c70..0aef9941b5b1 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -28,7 +28,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.8"
+#define DRV_VERSION	"0.4.9"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -315,12 +315,15 @@ static struct ata_port_operations artop6260_ops = {
 
 static void atp8xx_fixup(struct pci_dev *pdev)
 {
-	if (pdev->device == 0x0005)
+	u8 reg;
+
+	switch (pdev->device) {
+	case 0x0005:
 		/* BIOS may have left us in UDMA, clear it before libata probe */
 		pci_write_config_byte(pdev, 0x54, 0);
-	else if (pdev->device == 0x0008 || pdev->device == 0x0009) {
-		u8 reg;
-
+		break;
+	case 0x0008:
+	case 0x0009:
 		/* Mac systems come up with some registers not set as we
 		   will need them */
 
@@ -338,6 +341,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
 		/* Enable IRQ output and burst mode */
 		pci_read_config_byte(pdev, 0x4a, &reg);
 		pci_write_config_byte(pdev, 0x4a, (reg & ~0x01) | 0x80);
+		break;
 	}
 }
 
-- 
2.26.3

