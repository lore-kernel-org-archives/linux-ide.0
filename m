From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: kill ATA_DNXFER_ANY
Date: Fri, 2 Feb 2007 16:09:31 +0900
Message-ID: <117040017115-git-send-email-htejun@gmail.com>
References: <11704001701015-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:48480 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423154AbXBBHJi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:09:38 -0500
Received: by wx-out-0506.google.com with SMTP id h31so810584wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:09:38 -0800 (PST)
In-Reply-To: <11704001701015-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ATA_DNXFER_ANY isn't used anymore.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    9 ---------
 drivers/ata/libata.h      |    1 -
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cbd4bf1..651ab4b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2327,15 +2327,6 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 		udma_mask = 0;
 		break;
 
-	case ATA_DNXFER_ANY:
-		/* don't gear down to MWDMA from UDMA, go directly to PIO */
-		if (xfer_mask & ATA_MASK_UDMA)
-			xfer_mask &= ~ATA_MASK_MWDMA;
-
-		highbit = fls(xfer_mask) - 1;
-		xfer_mask &= ~(1 << highbit);
-		break;
-
 	default:
 		BUG();
 	}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 36e08d2..6fc6260 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -48,7 +48,6 @@ enum {
 	ATA_DNXFER_40C		= 2,	/* apply 40c cable limit */
 	ATA_DNXFER_FORCE_PIO	= 3,	/* force PIO */
 	ATA_DNXFER_FORCE_PIO0	= 4,	/* force PIO0 */
-	ATA_DNXFER_ANY		= 5,	/* speed down any */
 
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
-- 
1.4.4.4


