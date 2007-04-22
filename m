From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-acpi: fix _GTF command protocol for ATAPI devices
Date: Mon, 23 Apr 2007 02:06:46 +0900
Message-ID: <20070422170646.GM10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:14794 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161514AbXDVRGw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:06:52 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1326890wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:06:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

_GTF command is never ATA_PROT_ATAPI_NODATA whether the device is
ATAPI or not.  It's always ATA_PROT_NODATA.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 03a0acf..cb3eab6 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -489,8 +489,7 @@ static void taskfile_load_raw(struct ata_port *ap,
 
 	/* convert gtf to tf */
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
-	tf.protocol = atadev->class == ATA_DEV_ATAPI ?
-		ATA_PROT_ATAPI_NODATA : ATA_PROT_NODATA;
+	tf.protocol = ATA_PROT_NODATA;
 	tf.feature = gtf->tfa[0];	/* 0x1f1 */
 	tf.nsect   = gtf->tfa[1];	/* 0x1f2 */
 	tf.lbal    = gtf->tfa[2];	/* 0x1f3 */
-- 
1.5.0.3

