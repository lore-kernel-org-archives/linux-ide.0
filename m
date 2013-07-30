From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 27/35] ide: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:16:47 +0900
Message-ID: <005601ce8cfd$22cedd40$686c97c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55254 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758079Ab3G3IQt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jul 2013 04:16:49 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ00FDCPNBDFS0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 30 Jul 2013 17:16:48 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'David S. Miller'" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/gayle.c        |    2 +-
 drivers/ide/ide_platform.c |    2 +-
 drivers/ide/tx4938ide.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/gayle.c b/drivers/ide/gayle.c
index 0a8440a..97a2f9d 100644
--- a/drivers/ide/gayle.c
+++ b/drivers/ide/gayle.c
@@ -132,7 +132,7 @@ static int __init amiga_gayle_ide_probe(struct platform_device *pdev)
 	if (!request_mem_region(res->start, resource_size(res), "IDE"))
 		return -EBUSY;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	pr_info("ide: Gayle IDE controller (A%u style%s)\n",
 		pdata->explicit_ack ? 1200 : 4000,
 		ide_doubler ? ", IDE doubler" : "");
diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index ba4bfbe..a8b4b6a 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -56,7 +56,7 @@ static int plat_ide_probe(struct platform_device *pdev)
 	struct ide_hw hw, *hws[] = { &hw };
 	struct ide_port_info d = platform_ide_port_info;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 
 	/* get a pointer to the register memory */
 	res_base = platform_get_resource(pdev, IORESOURCE_IO, 0);
diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index ede8575..68edd4f 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -58,7 +58,7 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 
 static void tx4938ide_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	struct tx4938ide_platform_info *pdata = hwif->dev->platform_data;
+	struct tx4938ide_platform_info *pdata = dev_get_platdata(hwif->dev);
 	u8 safe = drive->pio_mode - XFER_PIO_0;
 	ide_drive_t *pair;
 
@@ -132,7 +132,7 @@ static int __init tx4938ide_probe(struct platform_device *pdev)
 	struct ide_hw hw, *hws[] = { &hw };
 	struct ide_host *host;
 	struct resource *res;
-	struct tx4938ide_platform_info *pdata = pdev->dev.platform_data;
+	struct tx4938ide_platform_info *pdata = dev_get_platdata(&pdev->dev);
 	int irq, ret, i;
 	unsigned long mapbase, mapctl;
 	struct ide_port_info d = tx4938ide_port_info;
-- 
1.7.10.4


