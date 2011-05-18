From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Use Maximum Write Same Length to report discard size limit
Date: Tue, 17 May 2011 22:13:23 -0400
Message-ID: <yq1aaekhi2k.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:58139 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703Ab1ERCNr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 May 2011 22:13:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org


Previously we used Maximum Unmap LBA Count in the Block Limits VPD to
signal the maximum number of sectors we could handle in a single Write
Same command.

Starting with SBC3r26 the Block Limits VPD has an explicit limit on the
number of blocks in a Write Same. This means we can stop abusing a field
related to the Unmap command and let our SAT use the proper value in the
VPD (Maximum Write Same Length).

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

Jeff: This is an important fix for discard. I missed this patch when I
originally submitted the thin provisioning updates for 2.6.39.


diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e2f57e9e..30ea95f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2138,7 +2138,7 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	 * with the unmap bit set.
 	 */
 	if (ata_id_has_trim(args->id)) {
-		put_unaligned_be32(65535 * 512 / 8, &rbuf[20]);
+		put_unaligned_be64(65535 * 512 / 8, &rbuf[36]);
 		put_unaligned_be32(1, &rbuf[28]);
 	}
 
