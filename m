From: sonic zhang <sonic.adi@gmail.com>
Subject: [PATCH] [libata] Return proper ATA INT status in pata_bf54x driver.
Date: Mon, 26 Nov 2007 17:50:56 +0800
Message-ID: <1196070656.15520.4.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:21493 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXKZKB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Nov 2007 05:01:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>

INT status can be OR.


Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

---
 drivers/ata/pata_bf54x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index b5e3842..81db405 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1145,13 +1145,13 @@ static unsigned char bfin_bmdma_status(s
 	unsigned short int_status = ATAPI_GET_INT_STATUS(base);
 
 	if (ATAPI_GET_STATUS(base) & (MULTI_XFER_ON|ULTRA_XFER_ON)) {
-		host_stat = ATA_DMA_ACTIVE;
+		host_stat |= ATA_DMA_ACTIVE;
 	}
 	if (int_status & (MULTI_DONE_INT|UDMAIN_DONE_INT|UDMAOUT_DONE_INT)) {
-		host_stat = ATA_DMA_INTR;
+		host_stat |= ATA_DMA_INTR;
 	}
 	if (int_status & (MULTI_TERM_INT|UDMAIN_TERM_INT|UDMAOUT_TERM_INT)) {
-		host_stat = ATA_DMA_ERR;
+		host_stat |= ATA_DMA_ERR;
 	}
 
 	return host_stat;
-- 
1.4.3.4


