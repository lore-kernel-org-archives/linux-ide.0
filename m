From: akpm@linux-foundation.org
Subject: [patch 07/25] libata: adjust libata to ignore errors after spinup
Date: Fri, 10 Aug 2007 13:59:35 -0700
Message-ID: <200708102059.l7AKxZ9I008587@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52842 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S938121AbXHJVAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:00:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, rpower@sysreset.com, htejun@gmail.com, liml@rtr.ca

From: Ryan Power <rpower@sysreset.com>

Adjust libata to ignore errors after spinup

This patch is to ignore errors from the spinup attempt if the drive is
in the "standby id" state.

Signed-off-by: Ryan Power <rpower@sysreset.com>
Acked-by: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/libata-core.c~libata-adjust-libata-to-ignore-errors-after drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-adjust-libata-to-ignore-errors-after
+++ a/drivers/ata/libata-core.c
@@ -1723,7 +1723,7 @@ int ata_dev_read_id(struct ata_device *d
 		tf.protocol = ATA_PROT_NODATA;
 		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-		if (err_mask) {
+		if (err_mask && id[2] != 0x738c) {
 			rc = -EIO;
 			reason = "SPINUP failed";
 			goto err_out;
_
