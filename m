From: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] ata: SATL compliance for Inquiry Product Revision
Date: Tue, 29 Apr 2014 13:25:24 -0600
Message-ID: <1398799524-5625-1-git-send-email-keith.busch@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:19691 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964915AbaD2TZ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2014 15:25:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>

The SCSI/ATA Translation standard says to use data words 25 and 26 unless
they are spaces. These words are generally more useful anway for devices
that are not padding the firmware field with spaces.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
---
 drivers/ata/libata-scsi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ef8567d..8034a38 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1993,7 +1993,10 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
 	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
-	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
+	if (args->id[25] == 0x2020 && args->id[26] == 0x2020)
+		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
+	else
+		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV + 2, 4);
 
 	if (rbuf[32] == 0 || rbuf[32] == ' ')
 		memcpy(&rbuf[32], "n/a ", 4);
-- 
1.7.10.4

