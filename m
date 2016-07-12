From: tom.ty89@gmail.com
Subject: [PATCH] libata-scsi: set correct VERSION field for ZAC devices
Date: Tue, 12 Jul 2016 21:45:30 +0800
Message-ID: <5784f482.d607620a.24b2e.ffffae8e@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36839 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcGLNpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 09:45:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id i123so1108378pfg.3
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2016 06:45:39 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, hare@suse.de, shaun.tancheff@seagate.com
Cc: linux-ide@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>

From: Tom Yan <tom.ty89@gmail.com>

Commit 856c4663930988118d9f355aad66811dd6df06de had the line that
"bumps" the VERSION field in standard INQUIRY data removed. Add
it back and claim SPC-5 version compatibility, which matches with
the current version descriptor "SPC-5 (no version claimed)" used
for ZAC devices.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bfec66f..27e29e1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2109,8 +2109,10 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
 		hdr[1] |= (1 << 7);
 
-	if (args->dev->class == ATA_DEV_ZAC)
+	if (args->dev->class == ATA_DEV_ZAC) {
 		hdr[0] = TYPE_ZBC;
+		hdr[2] = 0x7; /* claim SPC-5 version compatibility */
+	}
 
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
-- 
2.9.0

