From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-scsi: automatically use DMADIR if drive/bridge requires
 it
Date: Mon, 18 Feb 2008 15:53:46 -0500
Message-ID: <47B9F05A.1060207@rtr.ca>
References: <47B9D64C.3000705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3353 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762075AbYBRUxs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 15:53:48 -0500
In-Reply-To: <47B9D64C.3000705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>

Back in 2.6.17-rc2, a libata module parameter was added for atapi_dmadir.

That's nice, but most SATA devices which need it will tell us about it
in their IDENTIFY PACKET response, as bit-15 of word-62 of the
returned data (as per ATA7, ATA8 specifications).

So for those which specify it, we should automatically use the DMADIR bit.
Otherwise, disc writing will fail by default on many SATA-ATAPI drives.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/libata-scsi.c	2008-02-18 14:45:08.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2008-02-18 14:53:02.000000000 -0500
@@ -2543,9 +2543,10 @@
 		qc->tf.protocol = ATAPI_PROT_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-		if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
-			/* some SATA bridges need us to indicate data xfer direction */
-			qc->tf.feature |= ATAPI_DMADIR;
+		/* some SATA bridges need us to indicate data xfer direction */
+		if (atapi_dmadir || (dev->id[62] & 0x8000))
+			if (scmd->sc_data_direction != DMA_TO_DEVICE)
+				qc->tf.feature |= ATAPI_DMADIR;
 	}
 
 
