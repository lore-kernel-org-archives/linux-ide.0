From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2] ata: SATL compliance for Inquiry Product Revision
Date: Thu,  1 May 2014 11:12:03 -0600
Message-ID: <1398964323-26014-1-git-send-email-keith.busch@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12266 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaEARPD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2014 13:15:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>

The SCSI-to-ATA Translation standard says to use data words 25 and 26
unless they are spaces. For devices that use these words in the firmware
field, they are generally more useful anyway.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

Use words 25 and 26 by default, strncmp for spaces and fall back to
the original.

Added a comment to explain what the heck is happening.

 drivers/ata/libata-scsi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ef8567d..72691fd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1993,7 +1993,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
 	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
-	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
+
+	/* From SAT, use last 2 words from fw rev unless they are spaces */
+	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV + 2, 4);
+	if (strncmp(&rbuf[32], "    ", 4) == 0)
+		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
 
 	if (rbuf[32] == 0 || rbuf[32] == ' ')
 		memcpy(&rbuf[32], "n/a ", 4);
-- 
1.7.10.4

