From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] libata: fix ata_set_max_sectors()
Date: Fri, 21 Sep 2007 20:07:14 +0900
Message-ID: <20070921110714.GH10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:30624 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbXIULHW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 07:07:22 -0400
Received: by nz-out-0506.google.com with SMTP id s18so648252nze
        for <linux-ide@vger.kernel.org>; Fri, 21 Sep 2007 04:07:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

In ata_set_max_sectors(), the highest nibble in LBA28 mode was
missing.  This made drives sized between 8G and 128G with HPA turned
on to be resized to under 8G.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This one fixes my dumb mistake.

 drivers/ata/libata-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2116f27..1056279 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -952,9 +952,12 @@ static int ata_set_max_sectors(struct ata_device *dev, u64 new_sectors)
 		tf.hob_lbal = (new_sectors >> 24) & 0xff;
 		tf.hob_lbam = (new_sectors >> 32) & 0xff;
 		tf.hob_lbah = (new_sectors >> 40) & 0xff;
-	} else
+	} else {
 		tf.command = ATA_CMD_SET_MAX;
 
+		tf.device |= (new_sectors >> 24) & 0xf;
+	}
+
 	tf.protocol |= ATA_PROT_NODATA;
 	tf.device |= ATA_LBA;
 
