From: "Tobias Oed" <tobiasoed@hotmail.com>
Subject: [patch] pdc202xx_old depends on CONFIG_BLK_DEV_IDEDMA
Date: Sun, 18 Jun 2006 13:21:58 -0400
Message-ID: <BAY105-F37E386C7671BF4F79ABE01A3810@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay105-f37.bay105.hotmail.com ([65.54.224.47]:38936 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932263AbWFRRWA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jun 2006 13:22:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: tobiasoed@hotmail.com

The driver pdc202xx_old requires CONFIG_BLK_DEV_IDEDMA, so it's always 
defined

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

--- linux-2.6.17-rc1-mm3-1/drivers/ide/pci/pdc202xx_old.c       2006-04-26 
11:59:42.000000000 +0200
+++ linux-2.6.17-rc1-mm3-2/drivers/ide/pci/pdc202xx_old.c       2006-04-26 
11:59:52.000000000 +0200
@@ -491,12 +491,8 @@

static void pdc202xx_reset_host (ide_hwif_t *hwif)
{
-#ifdef CONFIG_BLK_DEV_IDEDMA
//     unsigned long high_16   = hwif->dma_base - (8*(hwif->channel));
        unsigned long high_16   = hwif->dma_master;
-#else /* !CONFIG_BLK_DEV_IDEDMA */
-       unsigned long high_16   = pci_resource_start(hwif->pci_dev, 4);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
        u8 udma_speed_flag      = hwif->INB(high_16|0x001f);

        hwif->OUTB((udma_speed_flag | 0x10), (high_16|0x001f));

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

