From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: update atapi_eh_request_sense() such
 that lbam/lbah contains buffer size
Date: Wed, 12 Dec 2007 12:12:46 +0900
Message-ID: <475F51AE.1010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:17794 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbXLLDMz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 22:12:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so57070rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 11 Dec 2007 19:12:54 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, will@trivescon.com.au, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
left out.  Update it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This patch is from improve-ATAPI-data-xfer patchset pending for
#upstream.

 drivers/ata/libata-eh.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1264,8 +1264,8 @@ static unsigned int atapi_eh_request_sen
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
 		tf.protocol = ATA_PROT_ATAPI;
-		tf.lbam = (8 * 1024) & 0xff;
-		tf.lbah = (8 * 1024) >> 8;
+		tf.lbam = SCSI_SENSE_BUFFERSIZE;
+		tf.lbah = 0;
 	}
 
 	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
