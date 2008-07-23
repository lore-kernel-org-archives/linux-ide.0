From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] libata: WIN_* -> ATA_CMD_*
Date: Wed, 23 Jul 2008 20:41:42 +0200
Message-ID: <200807232041.42750.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:18045 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbYGWSuR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 14:50:17 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1652803mue.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2008 11:50:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/libata-scsi.c
===================================================================
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -398,7 +398,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	scsi_cmd[0] = ATA_16;
 
 	scsi_cmd[4] = args[2];
-	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
+	if (args[0] == ATA_CMD_SMART) { /* hack -- ide driver does this too */
 		scsi_cmd[6]  = args[3];
 		scsi_cmd[8]  = args[1];
 		scsi_cmd[10] = 0x4f;
