From: Baruch Even <baruch@ev-en.org>
Subject: [PATCH 1/1] [libata] SCSI: really use SATL version in VPD
Date: Fri,  5 Apr 2013 17:50:25 +0300
Message-ID: <1365173425-16599-1-git-send-email-baruch@ev-en.org>
References: <satl-driver-version-v2>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40050 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161785Ab3DEOur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Apr 2013 10:50:47 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj8so676506wib.7
        for <linux-ide@vger.kernel.org>; Fri, 05 Apr 2013 07:50:46 -0700 (PDT)
In-Reply-To: <satl-driver-version-v2>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Baruch Even <baruch@ev-en.org>

As per c78968bb by Jeff Garzik ([libata] SCSI: simulator version, not device version, belongs in VPD)
We need to provide the SATL driver version and not the disk firmware version
but the code overwrites the driver version with the disk version.

Signed-off-by: Baruch Even <baruch@ev-en.org>
---
 drivers/ata/libata-scsi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 318b413..e61a054 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2126,7 +2126,6 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 	memcpy(&rbuf[8], "linux   ", 8);
 	memcpy(&rbuf[16], "libata          ", 16);
 	memcpy(&rbuf[32], DRV_VERSION, 4);
-	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
 
 	/* we don't store the ATA device signature, so we fake it */
 
-- 
1.7.10.4

