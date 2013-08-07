From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] ide: palm_bk3710: add missing __iomem annotation
Date: Wed, 07 Aug 2013 14:17:11 +0900
Message-ID: <002801ce932d$5ea499a0$1bedcce0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40552 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab3HGFRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Aug 2013 01:17:12 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR5001E2AOIX820@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 07 Aug 2013 14:17:11 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Added missing __iomem annotation in order to fix the following
sparse warnings:

drivers/ide/palm_bk3710.c:194:31: warning: incorrect type in initializer (different address spaces)
drivers/ide/palm_bk3710.c:194:31:    expected void [noderef] <asn:2>*base
drivers/ide/palm_bk3710.c:194:31:    got void *<noident>
drivers/ide/palm_bk3710.c:212:31: warning: incorrect type in initializer (different address spaces)
drivers/ide/palm_bk3710.c:212:31:    expected void [noderef] <asn:2>*base
drivers/ide/palm_bk3710.c:212:31:    got void *<noident>

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/palm_bk3710.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index 6107cc4..ba20d18 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -191,7 +191,7 @@ static void palm_bk3710_setpiomode(void __iomem *base, ide_drive_t *mate,
 static void palm_bk3710_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	int is_slave = drive->dn & 1;
-	void __iomem *base = (void *)hwif->dma_base;
+	void __iomem *base = (void __iomem *)hwif->dma_base;
 	const u8 xferspeed = drive->dma_mode;
 
 	if (xferspeed >= XFER_UDMA_0) {
@@ -209,7 +209,7 @@ static void palm_bk3710_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	unsigned int cycle_time;
 	int is_slave = drive->dn & 1;
 	ide_drive_t *mate;
-	void __iomem *base = (void *)hwif->dma_base;
+	void __iomem *base = (void __iomem *)hwif->dma_base;
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
 	/*
-- 
1.7.10.4


