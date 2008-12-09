From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 2/3] pata_hpt366: no ATAPI DMA
Date: Tue, 09 Dec 2008 17:14:04 +0900
Message-ID: <493E28CC.6070000@kernel.org>
References: <493E289F.1010000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42394 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbYLIIO2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 03:14:28 -0500
In-Reply-To: <493E289F.1010000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rt>

IDE hpt366 driver doesn't allow DMA for ATAPI devices and MWDMA2 on
ATAPI device locks up pata_hpt366.  Follow the suit.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_hpt366.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -183,7 +183,9 @@ static unsigned long hpt366_filter(struc
 			mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
 			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
-	}
+	} else if (adev->class == ATA_DEV_ATAPI)
+		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+
 	return ata_bmdma_mode_filter(adev, mask);
 }
 
